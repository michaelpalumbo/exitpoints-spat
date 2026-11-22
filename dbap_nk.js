// dbap_nk.js  (for a [v8 dbap_nk.js] object)
//
// nanoKONTROL2 for the panner. One channel per unit (units 1-8 of the scene).
//
//   fader     unit level, -30 dB to +6 dB (unity about 5/6 up). The bottom is
//             not off: there is no mute anywhere on the controller.
//   M         toggle the unit active / frozen (LED lit = active)
//   R         send the unit home and freeze it there
//   S         unused
//   knob      the unit's value for the current page:
//     <<   (43)  spread    point source to diffuse (spatial blur, 1 cm to 4 m)
//     >>   (44)  width     stereo / multi-mic width, x0 to x2 (units with one mic: unused)
//     STOP (42)  range     how far the movement reaches from home, 0-100%
//     PLAY (41)  speed     the unit's movement speed, x1/4 to x4
//     REC  (45)  accel     1 = instant; lower gives the unit weight (it swings into
//                          place and hard cuts become swoops)
//     CYCLE (46) global    knob 1 overall speed, knob 2 glide time
//
// Knobs and faders pick up (same rule as nanoKontrolModes.js): nothing happens
// until the control reaches or passes the current value. Pickup resets on page
// and scene changes.
//
// Inlet:
//   <value> <cc>        from [ctlin] (value and CC packed)
//   screen <value> <cc> from nk_screen.js (sets values directly, no pickup)
//   unit <n> <id> <hasWidth> <active> <dB> <spread> <width> <speed> <accel> <range>
//   globals <speed> <glide>, active <n> <0/1>, unitsdone     from dbap_behave.js
//
// Outlets:
//   0  to dbap_behave.js
//   1  to nk_screen.js
//   2  LED pairs "value cc" for [ctlout]

autowatch = 1;
inlets = 1;
outlets = 3;

const N = 8;
const KNOB0 = 8, S0 = 32, M0 = 48, R0 = 64;
const PICK = 0.03;
const DB_LO = -30, DB_HI = 6;

const PAGES = [
	{ cc: 43, name: "spread" },
	{ cc: 44, name: "width" },
	{ cc: 42, name: "range" },
	{ cc: 41, name: "speed" },
	{ cc: 45, name: "accel" },
	{ cc: 46, name: "global" }
];

let page = 0;
const U = [];
for (let i = 0; i < N; i++) {
	U.push({ id: "", hasWidth: 0, active: 0, level: 0, spread: 0.01, width: 1, speed: 1, accel: 1, range: 1 });
}
let gSpeed = 1, gGlide = 2;

const fPos = new Array(N).fill(-1), fPicked = new Array(N).fill(0);
const kPos = new Array(N).fill(-1), kPicked = new Array(N).fill(0);
const rHeld = new Array(N).fill(0);

function loadbang() {
	refresh();
}

// ---- from dbap_behave ----

function unit(n, id, hasWidth, active, db, spread, width, speed, accel, range) {
	const u = U[n - 1];
	if (!u) return;
	u.id = id === "-" ? "" : String(id);
	Object.assign(u, { hasWidth, active, level: db, spread, width, speed, accel, range });
}

function globals(sp, gl) {
	gSpeed = sp;
	gGlide = gl;
}

function active(n, on) {
	const u = U[n - 1];
	if (!u) return;
	u.active = on ? 1 : 0;
	led(M0 + n - 1, u.active);
	labels();
}

function unitsdone() {
	for (let i = 0; i < N; i++) { fPicked[i] = 0; kPicked[i] = 0; }
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
		if (on && pg !== page) {
			page = pg;
			for (let i = 0; i < N; i++) kPicked[i] = 0;
		}
		pageLeds();   // also relights after the controller turns the LED off on release
		display();
		return;
	}

	if (cc >= M0 && cc < M0 + N) {
		const n = cc - M0;
		if (on && U[n].id) outlet(0, "toggle", n + 1);
		else led(cc, U[n].active);   // release: put the LED back to the unit's state
		return;
	}

	if (cc >= R0 && cc < R0 + N) {
		const n = cc - R0;
		rHeld[n] = on ? 1 : 0;
		if (on && U[n].id) outlet(0, "home", n + 1);
		led(cc, on && U[n].id ? 1 : 0);
		return;
	}

	if (cc >= S0 && cc < S0 + N) led(cc, 0);   // unused: keep dark
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
	if (name === "spread") return Math.log(u.spread / 0.01) / Math.log(400);
	if (name === "width") return u.hasWidth ? u.width / 2 : -1;
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
	if (name === "spread") val = 0.01 * Math.pow(400, v);
	else if (name === "width") val = v * 2;
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

function knobName(k) {
	const name = PAGES[page].name;
	if (name === "global") return k === 0 ? "speed" : (k === 1 ? "glide" : "-");
	return knobNorm(k) < 0 ? "-" : name;
}

// ---- scaling ----

function dbOf(p) { return DB_LO + Math.max(0, Math.min(1, p)) * (DB_HI - DB_LO); }
function posOfDb(db) { return (Math.max(DB_LO, Math.min(DB_HI, db)) - DB_LO) / (DB_HI - DB_LO); }
function speedOf(v) { return Math.pow(2, v * 4 - 2); }
function speedNorm(s) { return (Math.log(s) / Math.LN2 + 2) / 4; }
function glideOf(v) { return 0.2 * Math.pow(50, v); }
function glideNorm(s) { return Math.log(Math.max(0.2, s) / 0.2) / Math.log(50); }

// ---- LEDs and screen ----

function led(cc, on) {
	const v = on ? 127 : 0;
	outlet(2, v, cc);
	outlet(1, v, cc);
}

function pageLeds() {
	PAGES.forEach((p, i) => led(p.cc, i === page));
}

function labels() {
	for (let n = 0; n < N; n++) {
		const has = !!U[n].id;
		outlet(1, "btn", S0 + n, "");
		outlet(1, "btn", M0 + n, has ? (U[n].active ? "active" : "frozen") : "");
		outlet(1, "btn", R0 + n, has ? "home" : "");
	}
	for (const p of PAGES) outlet(1, "btn", p.cc, p.name);
	for (const cc of [58, 59, 60, 61, 62]) outlet(1, "btn", cc, "");
}

function display() {
	for (let n = 0; n < N; n++) {
		const u = U[n];
		if (!u.id) {
			outlet(1, "fader", n, -1, fPos[n], "-", "");
		} else {
			const txt = (u.level > 0.05 ? "+" : "") + u.level.toFixed(1) + "dB";
			outlet(1, "fader", n, posOfDb(u.level), fPos[n], (n + 1) + "_" + u.id, txt);
		}
		outlet(1, "knob", n, knobNorm(n), kPos[n], knobName(n), knobText(n), -1, 0);
	}
	outlet(1, "mode", PAGES[page].name);
}

function refresh() {
	labels();
	pageLeds();
	for (let n = 0; n < N; n++) {
		led(M0 + n, U[n].id ? U[n].active : 0);
		led(R0 + n, 0);
		led(S0 + n, 0);
	}
	display();
}