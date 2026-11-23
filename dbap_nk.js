// dbap_nk.js  (for a [v8 dbap_nk.js] object)
//
// nanoKONTROL2 for the panner. One channel per unit (units 1-8 of the scene).
//
//   fader     unit level, off (bottom, -70 dB) to 0 dB (top)
//   M         toggle the unit frozen / movable in the current mode
//             (LED lit = movable; everything starts frozen, except in "set home
//             positions" where every unit is always movable and M does nothing)
//   R         send the unit home; the LED flashes while it travels. M off: it
//             stays home. M on: it goes back to the mode once it gets there.
//             (Does nothing, and stays dark, in set home positions.)
//   S         tap:  select the unit for assigning a behaviour (assign mode, key 0);
//                   the LED flashes slowly while selected. Tap again to deselect.
//             hold 2 s: clear the unit's loop (the LED flashes fast while held;
//                   let go early to keep the loop). Hold several to clear several.
//             Otherwise the LED is lit while the unit is playing its loop (its
//             behaviour is loop and it has one).
//   knob      the unit's value for the current page:
//     <<   (43)  spread    per unit: point source to diffuse (1 cm to 4 m,
//                          on a curve that changes visibly from the first turn)
//     >>   (44)  width     per unit: stereo / multi-mic width, x0 to x5
//     STOP (42)  range     per unit, per behaviour: how far it moves from home
//     PLAY (41)  speed     per unit, per behaviour: x1/4 to x6
//     REC  (45)  accel     per unit, per behaviour: 1 = instant, lower = heavier
//     CYCLE (46) global    knob 1 overall speed, knob 2 glide time
//   In set home positions, range / speed / accel do nothing: their buttons are
//   greyed out and dark, and those knobs show n/a. In assign mode the same goes
//   for each unit assigned to set home.
//
// Knobs and faders pick up (same rule as nanoKontrolModes.js). Pickup resets on
// page, mode and scene changes.
//
// Inlet:
//   <value> <cc>          from [ctlin] (value and CC packed)
//   screen <value> <cc>   from nk_screen.js (sets values directly, no pickup)
//   from dbap_behave.js:
//     unit <n> <id> <hasWidth> <active> <dB> <spread> <width> <speed> <accel> <range> <hasLoop> <behaviour>
//     behmode <name>, globals <speed> <glide>, active <n> <0/1>, hasloop <n> <0/1>,
//     selected <n> <0/1>, unitsdone
//
// Outlets:
//   0  to dbap_behave.js
//   1  to nk_screen.js
//   2  LED pairs "value cc" -> [unpack 0 0] -> [ctlout "nanoKONTROL2 CTRL"]

autowatch = 1;
inlets = 1;
outlets = 3;

const N = 8;
const KNOB0 = 8, S0 = 32, M0 = 48, R0 = 64;
const PICK = 0.03;
const DB_LO = -70, DB_HI = 0;   // the bottom of the fader is off
const CLEAR_MS = 2000;       // hold S this long to clear a loop
const TAP_MS = 500;          // a shorter S press is a tap (select)
const FAST_MS = 100;         // flash while holding S to clear
const SLOW_MS = 300;         // flash while selected
const HOMING_MS = 150;       // R flashes while the unit travels home

const PAGES = [
	{ cc: 43, name: "spread" },
	{ cc: 44, name: "width" },
	{ cc: 42, name: "range" },
	{ cc: 41, name: "speed" },
	{ cc: 45, name: "accel" },
	{ cc: 46, name: "global" }
];

let page = 0;
let mode = "manual";
let modeLbl = "set home";
const BEH_LABELS = { manual: "set_home" };
const U = [];
for (let i = 0; i < N; i++) {
	U.push({ id: "", hasWidth: 0, active: 0, level: 0, spread: 0.01, width: 1,
		speed: 1, accel: 1, range: 1, hasLoop: 0, beh: "manual", selected: 0, homing: 0 });
}
let gSpeed = 1, gGlide = 2;

const fPos = new Array(N).fill(-1), fPicked = new Array(N).fill(0);
const kPos = new Array(N).fill(-1), kPicked = new Array(N).fill(0);
const sDown = new Array(N).fill(0);    // when each S went down (0 = up)
const sDone = new Array(N).fill(0);    // this press already cleared the loop
const rDown = new Array(N).fill(0);    // R held down
const ledState = {};

const flasher = new Task(flash, this);
flasher.interval = 50;
flasher.repeat();

function loadbang() {
	refresh();
}

// ---- from dbap_behave ----

function unit(n, id, hasWidth, active, db, spread, width, speed, accel, range, hasLoop, beh) {
	const u = U[n - 1];
	if (!u) return;
	u.id = id === "-" ? "" : String(id);
	Object.assign(u, { hasWidth, active, level: db, spread, width, speed, accel, range,
		hasLoop: hasLoop ? 1 : 0, beh: beh === "-" ? "" : String(beh) });
	if (!u.id) u.selected = 0;
}

function behmode(m, label) {
	mode = String(m);
	modeLbl = label === undefined ? mode : String(label);
}

function globals(sp, gl) {
	gSpeed = sp;
	gGlide = gl;
	display();
}

function active(n, on) {
	const u = U[n - 1];
	if (!u) return;
	u.active = on ? 1 : 0;
	led(M0 + n - 1, u.active);
	labels();
}

function homing(n, on) {
	const u = U[n - 1];
	if (!u) return;
	u.homing = on ? 1 : 0;
	flash();
}

function hasloop(n, on) {
	const u = U[n - 1];
	if (!u) return;
	u.hasLoop = on ? 1 : 0;
	labels();
}

function selected(n, on) {
	const u = U[n - 1];
	if (!u) return;
	u.selected = on ? 1 : 0;
	labels();
}

function unitsdone() {
	for (let i = 0; i < N; i++) { fPicked[i] = 0; kPicked[i] = 0; U[i].homing = 0; }
	refresh();
}


// ---- controller ----

function list(v, cc) {
	if (v === undefined || cc === undefined) return;
	const on = v > 0;

	if (cc >= 0 && cc < N) { hwFader(cc, v / 127); return; }
	if (cc >= KNOB0 && cc < KNOB0 + N) { hwKnob(cc - KNOB0, v / 127); return; }

	const pg = PAGES.findIndex(p => p.cc === cc);
	if (pg >= 0) {
		if (pageDisabled(pg)) {          // not used in set home positions: stay dark
			led(cc, 0, true);
			return;
		}
		if (on && pg !== page) {
			page = pg;
			for (let i = 0; i < N; i++) kPicked[i] = 0;
		}
		pageLeds(true);   // also relights after the controller turns the LED off on release
		display();
		return;
	}

	if (cc >= M0 && cc < M0 + N) {
		const n = cc - M0;
		if (on && U[n].id) outlet(0, "toggle", n + 1);
		else led(cc, U[n].id && U[n].active, true);   // release: back to the unit's state
		return;
	}

	if (cc >= R0 && cc < R0 + N) {
		const n = cc - R0;
		if (unitIsHome(n)) {             // already home: nothing to do, stay dark
			led(cc, 0, true);
			return;
		}
		rDown[n] = on && U[n].id ? 1 : 0;
		if (on && U[n].id) outlet(0, "home", n + 1);
		flash();
		return;
	}

	if (cc >= S0 && cc < S0 + N) {
		const n = cc - S0;
		if (!U[n].id) return;
		if (on) {
			sDown[n] = Date.now();
			sDone[n] = 0;
		} else {
			const held = sDown[n] ? Date.now() - sDown[n] : 0;
			sDown[n] = 0;
			if (!sDone[n] && held < TAP_MS) outlet(0, "select", n + 1);
		}
		flash();
	}
}

function screen(v, cc) {
	if (v === undefined || cc === undefined) return;
	if (cc >= 0 && cc < N) {
		if (!U[cc].id) return;
		setLevel(cc, v / 127);
		fPicked[cc] = 0;
		display();
		return;
	}
	if (cc >= KNOB0 && cc < KNOB0 + N) {
		const k = cc - KNOB0;
		if (knobNorm(k) < 0) return;
		setKnob(k, Math.max(0, Math.min(1, v / 127)));
		kPicked[k] = 0;
		display();
		return;
	}
	list(v, cc);
}

// S buttons: hold-to-clear timing and all the flashing
function flash() {
	const now = Date.now();
	for (let n = 0; n < N; n++) {
		const u = U[n];
		let on;
		if (!u.id) {
			on = 0;
		} else if (sDown[n] && u.hasLoop && !sDone[n]) {
			if (now - sDown[n] >= CLEAR_MS) {
				sDone[n] = 1;
				outlet(0, "clearloop", n + 1);
				on = 0;
			} else {
				on = Math.floor((now - sDown[n]) / FAST_MS) % 2 === 0;
			}
		} else if (u.selected) {
			on = Math.floor(now / SLOW_MS) % 2 === 0;
		} else if (sDown[n]) {
			on = 1;
		} else {
			on = playingLoop(u);
		}
		led(S0 + n, on);

		// R: flashes while the unit travels home, lit while held, otherwise dark
		let r = 0;
		if (u.id && !unitIsHome(n)) {
			if (u.homing) r = Math.floor(now / HOMING_MS) % 2 === 0;
			else r = rDown[n];
		}
		led(R0 + n, r);
	}
}

function hwFader(n, pos) {
	const prev = fPos[n];
	fPos[n] = pos;
	if (U[n].id) {
		if (!fPicked[n] && pickedUp(prev, pos, posOfDb(U[n].level))) fPicked[n] = 1;
		if (fPicked[n]) setLevel(n, pos);
	}
	display();
}

function hwKnob(k, pos) {
	const prev = kPos[k];
	kPos[k] = pos;
	const cur = knobNorm(k);
	if (cur >= 0) {
		if (!kPicked[k] && pickedUp(prev, pos, cur)) kPicked[k] = 1;
		if (kPicked[k]) setKnob(k, pos);
	}
	display();
}

// the unit's behaviour is set home positions ("manual" inside)
function unitIsHome(n) {
	return !!U[n].id && U[n].beh === "manual";
}

// pages whose values belong to the behaviour (range, speed, accel)
const BEH_PAGES = ["range", "speed", "accel"];
function behPage(i) {
	return BEH_PAGES.indexOf(PAGES[i].name) >= 0;
}

// in set home positions the behaviour pages do nothing
function pageDisabled(i) {
	return mode === "manual" && behPage(i);
}

// a knob with nothing to set on this page: the text to show, or ""
function naText(k) {
	if (PAGES[page].name === "width" && U[k].id && !U[k].hasWidth) return "n/a (mono)";
	if (behPage(page) && unitIsHome(k)) return "n/a (set home)";
	return "";
}

function playingLoop(u) {
	return u.hasLoop && u.beh === "loop";
}

function pickedUp(prev, pos, cur) {
	const crossed = prev >= 0 && (prev - cur) * (pos - cur) <= 0;
	return crossed || Math.abs(pos - cur) <= PICK;
}

function setLevel(n, pos) {
	const db = Math.round(dbOf(pos) * 10) / 10;
	U[n].level = db;
	outlet(0, "unitlevel", n + 1, db);
}

// ---- knob values per page ----

// the knob's current value 0-1, or -1 if the knob does nothing on this page
function knobNorm(k) {
	const name = PAGES[page].name;
	if (name === "global") {
		if (k === 0) return speedNorm(gSpeed);
		if (k === 1) return glideNorm(gGlide);
		return -1;
	}
	const u = U[k];
	if (!u.id) return -1;
	if (naText(k)) return -1;
	if (name === "spread") return spreadNorm(u.spread);
	if (name === "width") return u.hasWidth ? u.width / 5 : -1;
	if (name === "range") return u.range;
	if (name === "speed") return speedNorm(u.speed);
	if (name === "accel") return u.accel;
	return -1;
}

function setKnob(k, v) {
	const name = PAGES[page].name;
	if (name === "global") {
		if (k === 0) { gSpeed = speedOf(v); outlet(0, "speed", gSpeed); }
		if (k === 1) { gGlide = glideOf(v); outlet(0, "glidetime", gGlide); }
		return;
	}
	const u = U[k];
	let val;
	if (name === "spread") val = spreadOf(v);
	else if (name === "width") val = v * 5;
	else if (name === "range") val = v;
	else if (name === "speed") val = speedOf(v);
	else if (name === "accel") val = v > 0.97 ? 1 : v;   // a small detent at the top: instant
	else return;
	u[name] = val;
	outlet(0, "unitparam", k + 1, name, val);
}

function knobText(k) {
	const name = PAGES[page].name;
	if (knobNorm(k) < 0) return "";
	if (name === "global") return k === 0 ? "x" + gSpeed.toFixed(2) : gGlide.toFixed(1) + "s";
	const u = U[k];
	if (name === "spread") return u.spread < 0.05 ? "point" : u.spread.toFixed(1) + "m";
	if (name === "width") return "x" + u.width.toFixed(2);
	if (name === "range") return Math.round(u.range * 100) + "%";
	if (name === "speed") return "x" + u.speed.toFixed(2);
	if (name === "accel") return u.accel >= 0.999 ? "instant" : (0.3 * Math.pow(200, u.accel)).toFixed(1) + "m/s2";
	return "";
}

// width page, a unit with a single mic: nothing to widen
function monoWidth(k) {
	return PAGES[page].name === "width" && U[k].id && !U[k].hasWidth;
}

function knobName(k) {
	const name = PAGES[page].name;
	if (name === "global") return k === 0 ? "speed" : (k === 1 ? "glide" : "-");
	if (knobNorm(k) < 0) return "-";
	// in assign mode, say which behaviour this unit's range / speed / accel belong to
	if (mode === "assign" && (name === "range" || name === "speed" || name === "accel")) return BEH_LABELS[U[k].beh] || U[k].beh;
	return name;
}

// ---- scaling ----

function dbOf(p) { return DB_LO + Math.max(0, Math.min(1, p)) * (DB_HI - DB_LO); }
function posOfDb(db) { return (Math.max(DB_LO, Math.min(DB_HI, db)) - DB_LO) / (DB_HI - DB_LO); }
// x1/4 to x6 on a log scale (x1 sits a bit left of centre)
function speedOf(v) { return 0.25 * Math.pow(24, v); }
function speedNorm(s) { return Math.log(Math.max(0.25, s) / 0.25) / Math.log(24); }
function spreadOf(v) { return 0.01 + 3.99 * v * v; }
function spreadNorm(s) { return Math.sqrt(Math.max(0, Math.min(1, (s - 0.01) / 3.99))); }
function glideOf(v) { return 0.2 * Math.pow(50, v); }
function glideNorm(s) { return Math.log(Math.max(0.2, s) / 0.2) / Math.log(50); }

// ---- LEDs and screen ----

// sends only changes unless forced (the flasher runs every 50 ms)
function led(cc, on, force) {
	const v = on ? 127 : 0;
	if (!force && ledState[cc] === v) return;
	ledState[cc] = v;
	outlet(2, v, cc);
	outlet(1, v, cc);
}

function pageLeds(force) {
	PAGES.forEach((p, i) => led(p.cc, i === page && !pageDisabled(i), force));
}

function labels() {
	for (let n = 0; n < N; n++) {
		const u = U[n];
		const has = !!u.id;
		let sl = "";
		if (has && mode === "assign") sl = u.selected ? "selected" : "select";
		else if (has && playingLoop(u)) sl = "delete";   // hold 2 s to delete the loop
		outlet(1, "btn", S0 + n, sl);
		outlet(1, "btn", M0 + n, has ? (u.active ? "movable" : "frozen") : "");
		outlet(1, "btn", R0 + n, has && !unitIsHome(n) ? "home" : "");
	}
	for (const p of PAGES) outlet(1, "btn", p.cc, p.name);
	for (const cc of [58, 59, 60, 61, 62]) outlet(1, "btn", cc, "");
	// range / speed / accel belong to the behaviour: box them and say which
	PAGES.forEach((p, i) => outlet(1, "dim", p.cc, pageDisabled(i) ? 1 : 0));
	for (let n = 0; n < N; n++) outlet(1, "dim", R0 + n, unitIsHome(n) ? 1 : 0);
	if (mode === "manual") {
		outlet(1, "group", "not used in set home");
		outlet(1, "groupdim", 1);
	} else {
		outlet(1, "group", mode === "assign" ? "each unit's behaviour" : modeLbl + " settings");
		outlet(1, "groupdim", 0);
	}
	outlet(1, "caption", "knobs");
}

function display() {
	for (let n = 0; n < N; n++) {
		const u = U[n];
		if (!u.id) {
			outlet(1, "fader", n, -1, fPos[n], "-", "");
		} else {
			const txt = u.level <= DB_LO + 0.05 ? "off" : (u.level > 0.05 ? "+" : "") + u.level.toFixed(1) + "dB";
			outlet(1, "fader", n, posOfDb(u.level), fPos[n], (n + 1) + "_" + u.id, txt);
		}
		const na = naText(n);
		if (na) outlet(1, "knob", n, -2, -1, PAGES[page].name, na, -1, 0);   // -2: no ring
		else outlet(1, "knob", n, knobNorm(n), kPos[n], knobName(n), knobText(n), -1, 0);
	}
	outlet(1, "mode", PAGES[page].name);
}

function refresh() {
	labels();
	pageLeds(true);
	for (let n = 0; n < N; n++) {
		led(M0 + n, U[n].id && U[n].active, true);
		led(R0 + n, 0, true);
	}
	flash();
	display();
}