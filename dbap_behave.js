// dbap_behave.js  (for a [v8 dbap_behave.js] object)
//
// Behaviour engine. Moves "units" (a source, or a group of sources) by sending
// position messages to dbap_control.js about 30 times a second.
//
// Units: keys 1-9, defined per scene by "keys" in dbap_scenes.json.
//
// Keyboard (send ASCII codes in as "key <ascii>", e.g. from [key] -> [prepend key]):
//   1-9          toggle a unit between active (follows the mode) and frozen (stays put)
//   shift + 1-9  send that unit home and freeze it there (press its number to resume)
//   q w e r t y u i   modes 1-8 (see MODE_NAMES)
//   o            gamepad mode (sticks)
//   p            hold: active units stop where they are
//   TAB          toggle glide / cut for changes of mode and state
//
// Other messages in:
//   dictionary dbap_state     state from dbap_control.js (connect its outlet here)
//   lstick <x> <y>            left stick, -1..1, +y = up
//   rstick <x> <y>            right stick
//   speed <mult>              behaviour speed (1 = normal)
//   glidetime <seconds>       glide length for mode / state changes
//   unitlevel <n> <dB>        level of unit n (from dbap_nk.js)
//
// Outlets:
//   0  to dbap_control.js (posq, groupq, flush, slew, level, dump)
//   1  to dbap_nk.js: "unit <n> <name> <dB>" x 9, then "unitsdone"
//   2  "dictionary dbap_behave" for the room view

autowatch = 1;
inlets = 1;
outlets = 3;

const TICK_MS = 33;
const SMOOTH_SLEW = 50;     // ms, continuous movement
const HOP_SLEW = 3;         // ms, hard cuts (just enough to avoid clicks)
const STICK_DEAD = 0.12;
const SECTOR_GLIDE = 0.3;   // s, when a stick changes direction (glide mode only)
const TAU = Math.PI * 2;

const MODE_KEYS = "qwertyuiop";
const MODE_NAMES = ["stage", "drift", "orbit", "hop", "pulse", "swarm", "sway", "perimeter", "gamepad", "hold"];
const SHIFT_NUM = "!@#$%^&*(";

let state = null;
let sig = "";
let units = [];
let spk = [];
let bounds = { x0: -3, x1: 3, y0: -3, y1: 3 };
let mode = "stage";
let glide = 1;
let glideTime = 2;
let tempo = 1;
let T = 0;
let lastMs = Date.now();
let lastAsk = 0;
let tickCount = 0;
let sticks = { L: [0, 0], R: [0, 0] };

const task = new Task(tick, this);
task.interval = TICK_MS;
task.repeat();

function loadbang() {
	outlet(0, "dump");
}

// ---- input ----

function key(a) {
	if (a === 9) {
		glide = glide ? 0 : 1;
		publish();
		return;
	}
	const c = String.fromCharCode(a);
	if (c >= "1" && c <= "9") { toggleUnit(c.charCodeAt(0) - 48); return; }
	const h = SHIFT_NUM.indexOf(c);
	if (h >= 0) { homeUnit(h + 1); return; }
	const m = MODE_KEYS.indexOf(c.toLowerCase());
	if (m >= 0) setMode(MODE_NAMES[m]);
}

function lstick(x, y) { sticks.L = [x, y]; }
function rstick(x, y) { sticks.R = [x, y]; }
function glidetime(s) { glideTime = Math.max(0, s); publish(); }

// behaviour time runs at this rate (1 = normal)
function speed(v) { tempo = Math.max(0.01, v); publish(); }

function unitlevel(n, db) {
	const u = unitOf(n);
	if (!u) return;
	u.levelDb = db;
	const lin = Math.pow(10, db / 20);
	for (const m of u.members) outlet(0, "level", m, lin);
	publish();
}

function dictionary(name) {
	if (name !== "dbap_state") return;
	state = JSON.parse(new Dict(name).stringify());
	spk = toArr(state.speakers).map(s => [s.x, s.y]);
	if (spk.length) {
		const xs = spk.map(p => p[0]);
		const ys = spk.map(p => p[1]);
		bounds = { x0: Math.min(...xs), x1: Math.max(...xs), y0: Math.min(...ys), y1: Math.max(...ys) };
	}
	const s = state.scene + "|" + JSON.stringify(state.keys || []) + "|" + JSON.stringify(state.sticks || {});
	if (s !== sig) {
		sig = s;
		buildUnits();
	}
}

// ---- units ----

function buildUnits() {
	const old = {};
	for (const u of units) old[u.id] = u;
	const keys = toArr(state.keys).slice(0, 9);
	const st = state.sticks || {};
	const L = toArr(st.L);
	const R = toArr(st.R);
	units = [];
	keys.forEach((id, i) => {
		const n = i + 1;
		let kind = "source";
		let members = [id];
		if (!state.sources[id]) {
			kind = "group";
			members = Object.keys(state.sources).filter(k => state.sources[k].group === id);
			if (!members.length) {
				post("dbap_behave: key " + n + ": no source or group called " + id + "\n");
				return;
			}
		}
		const ms = members.map(m => state.sources[m]);
		const home = [avg(ms.map(s => s.home[0])), avg(ms.map(s => s.home[1]))];
		const pos = [avg(ms.map(s => s.x)), avg(ms.map(s => s.y))];
		const prev = old[id];
		const u = {
			n, id, kind, members,
			acoustic: ms.some(s => s.acoustic),
			home,
			out: pos,
			hold: pos.slice(),
			active: prev ? prev.active : true,
			levelDb: prev ? prev.levelDb : 0,
			stick: L.indexOf(n) >= 0 ? "L" : (R.indexOf(n) >= 0 ? "R" : null),
			trans: null,
			slew: -1,
			sector: -1,
			st: {}
		};
		resetBehaviour(u);
		units.push(u);
	});
	sendNames();
	publish();
}

function unitOf(n) {
	return units.find(u => u.n === n);
}

function toggleUnit(n) {
	const u = unitOf(n);
	if (!u) return;
	u.active = !u.active;
	if (u.active) {
		startTrans(u, glide ? glideTime : 0);
	} else {
		u.hold = u.out.slice();
		u.trans = null;
	}
	publish();
}

function homeUnit(n) {
	const u = unitOf(n);
	if (!u) return;
	u.active = false;
	u.hold = u.home.slice();
	startTrans(u, glide ? glideTime : 0);
	resetBehaviour(u);
	publish();
}

function setMode(name) {
	mode = name;
	for (const u of units) {
		if (!u.active) continue;
		resetBehaviour(u);
		startTrans(u, glide ? glideTime : 0);
	}
	publish();
}

function startTrans(u, dur) {
	u.trans = dur > 0 ? { from: u.out.slice(), t0: Date.now(), dur: dur * 1000 } : null;
}

function resetBehaviour(u) {
	let seed = 0;
	for (let i = 0; i < u.id.length; i++) seed = (seed * 31 + u.id.charCodeAt(i)) % 2147483647;
	u.st = { seed: seed || 1, hopNext: null, hopCur: -1 };
	u.st.ph = [rnd(u) * TAU, rnd(u) * TAU, rnd(u) * TAU, rnd(u) * TAU];
	u.st.fr = [0.04 + rnd(u) * 0.07, 0.04 + rnd(u) * 0.07, 0.04 + rnd(u) * 0.07, 0.04 + rnd(u) * 0.07];
	u.sector = -1;
}

// seeded random per unit, so each unit has its own repeatable character
function rnd(u) {
	u.st.seed = (u.st.seed * 16807) % 2147483647;
	return (u.st.seed - 1) / 2147483646;
}

// ---- the clock ----

function tick() {
	const now = Date.now();
	const dt = Math.min(0.2, (now - lastMs) / 1000);
	lastMs = now;
	if (!state) {
		if (now - lastAsk > 1000) { lastAsk = now; outlet(0, "dump"); }
		return;
	}
	T += dt * tempo;

	const act = units.filter(u => u.active);
	let moved = false;
	for (const u of units) {
		let tg;
		if (u.active) tg = target(u, act.indexOf(u), act.length);
		else tg = { x: u.hold[0], y: u.hold[1], slew: SMOOTH_SLEW };

		let x = tg.x, y = tg.y, slew = tg.slew;
		if (u.trans) {
			const k = (now - u.trans.t0) / u.trans.dur;
			if (k >= 1) {
				u.trans = null;
			} else {
				const e = k * k * (3 - 2 * k);
				x = u.trans.from[0] + (x - u.trans.from[0]) * e;
				y = u.trans.from[1] + (y - u.trans.from[1]) * e;
				slew = SMOOTH_SLEW;
			}
		}
		x = clamp(x, bounds.x0, bounds.x1);
		y = clamp(y, bounds.y0, bounds.y1);

		if (slew !== u.slew) {
			u.slew = slew;
			for (const m of u.members) outlet(0, "slew", m, slew);
		}
		if (Math.abs(x - u.out[0]) > 1e-4 || Math.abs(y - u.out[1]) > 1e-4) {
			u.out = [x, y];
			outlet(0, u.kind === "group" ? "groupq" : "posq", u.id, x, y);
			moved = true;
		}
	}
	if (moved) outlet(0, "flush");
	if (++tickCount % 3 === 0) publish();
}

// ---- behaviours ----
// Each returns where a unit should be now. i = its index among active units, n = how many.
// Acoustic units move less and more slowly (amp and tempo factors).

function target(u, i, n) {
	const H = u.home;
	const A = u.acoustic ? 0.6 : 1;
	const Tm = u.acoustic ? 0.5 : 1;
	const ph = u.st.ph, fr = u.st.fr;
	const cx = (bounds.x0 + bounds.x1) / 2, cy = (bounds.y0 + bounds.y1) / 2;
	const hx = (bounds.x1 - bounds.x0) / 2, hy = (bounds.y1 - bounds.y0) / 2;
	n = Math.max(1, n);

	switch (mode) {
	case "stage":
		return at(H[0], H[1]);

	case "hold":
		return at(u.out[0], u.out[1]);

	case "drift": {
		// slow wandering around home
		const R = 1.8 * A, t = T * Tm;
		return at(
			H[0] + R * (0.6 * Math.sin(TAU * fr[0] * t + ph[0]) + 0.4 * Math.sin(TAU * fr[1] * t + ph[1])),
			H[1] + R * (0.6 * Math.sin(TAU * fr[2] * t + ph[2]) + 0.4 * Math.sin(TAU * fr[3] * t + ph[3])));
	}

	case "orbit": {
		// circles around the middle of the room, alternating directions, one lap ~40 s
		const rmax = Math.min(hx, hy) * 0.9;
		const r = Math.min(rmax, (0.35 + 0.3 * (i % 3)) * rmax / 0.95) * (u.acoustic ? 0.8 : 1);
		const dir = i % 2 ? -1 : 1;
		const a = TAU * i / n + dir * TAU * T * Tm / 40;
		return at(cx + r * Math.cos(a), cy + r * Math.sin(a));
	}

	case "hop":
		// hard cuts between speakers at random intervals (2-6 s, slower for acoustic)
		return hop(u, (2 + 4 * rnd0(u)) / Tm);

	case "pulse": {
		// everyone cuts together on a shared beat, each to a different speaker
		const P = 1.5;
		const beat = Math.floor(T * Tm / P);
		if (!spk.length) return at(H[0], H[1]);
		const p = spk[(beat + i) % spk.length];
		return { x: p[0], y: p[1], slew: HOP_SLEW };
	}

	case "swarm": {
		// a shared centre wanders the room; units buzz around it
		const C = [cx + hx * 0.6 * Math.sin(TAU * 0.03 * T + 1), cy + hy * 0.6 * Math.sin(TAU * 0.021 * T)];
		const x = C[0] + 0.7 * Math.sin(TAU * fr[0] * 2 * T + ph[0]);
		const y = C[1] + 0.7 * Math.sin(TAU * fr[2] * 2 * T + ph[2]);
		if (u.acoustic) return at(x + (H[0] - x) * 0.4, y + (H[1] - y) * 0.4);
		return at(x, y);
	}

	case "sway": {
		// front to back and back again, ~12 s, staggered
		const th = TAU * T * Tm / 12 + TAU * i / n;
		const depth = (H[1] - bounds.y0) * A;
		return at(H[0], H[1] - (1 - Math.cos(th)) / 2 * depth);
	}

	case "perimeter": {
		// spread evenly around the walls, slowly rotating (one lap ~90 s)
		const s = ((i / n + T * Tm / 90) % 1 + 1) % 1;
		const p = perimeterPoint(s);
		if (u.acoustic) return at(p[0] + (H[0] - p[0]) * 0.3, p[1] + (H[1] - p[1]) * 0.3);
		return at(p[0], p[1]);
	}

	case "gamepad":
		return gamepad(u, H, A, Tm);
	}
	return at(H[0], H[1]);
}

function gamepad(u, H, A, Tm) {
	if (!u.stick) return at(H[0], H[1]);   // not on a stick: home
	const v = sticks[u.stick];
	const len = Math.hypot(v[0], v[1]);
	const mag = clamp((len - STICK_DEAD) / (1 - STICK_DEAD), 0, 1);
	let sector = -1;
	if (mag > 0) {
		if (Math.abs(v[0]) > Math.abs(v[1])) sector = v[0] > 0 ? 1 : 3;   // right, left
		else sector = v[1] > 0 ? 0 : 2;                                    // up, down
	}
	if (sector !== u.sector) {
		u.sector = sector;
		u.st.hopNext = null;
		if (glide) startTrans(u, SECTOR_GLIDE);
	}
	const ph = u.st.ph, fr = u.st.fr;
	switch (sector) {
	case 0: {
		// up: pulled toward the middle, circling it
		const c = [0.6 * Math.cos(TAU * 0.08 * T + ph[0]), 0.6 * Math.sin(TAU * 0.08 * T + ph[0])];
		const k = mag * A;
		return at(H[0] + (c[0] - H[0]) * k, H[1] + (c[1] - H[1]) * k);
	}
	case 2: {
		// down: fast jitter around home, wider as you push
		const R = 2.0 * A * mag;
		return at(
			H[0] + R * (0.6 * Math.sin(TAU * fr[0] * 3 * T + ph[0]) + 0.4 * Math.sin(TAU * fr[1] * 3 * T + ph[1])),
			H[1] + R * (0.6 * Math.sin(TAU * fr[2] * 3 * T + ph[2]) + 0.4 * Math.sin(TAU * fr[3] * 3 * T + ph[3])));
	}
	case 1: {
		// right: clockwise orbit around home, radius grows with the push
		const r = 2.0 * A * mag;
		const a = ph[0] - TAU * T * Tm / 6;
		return at(H[0] + r * Math.cos(a), H[1] + r * Math.sin(a));
	}
	case 3:
		// left: speaker hops, faster as you push (3 s down to 0.25 s)
		return hop(u, (3 - 2.75 * mag) / Tm);
	}
	return at(H[0], H[1]);
}

function hop(u, interval) {
	if (!spk.length) return at(u.home[0], u.home[1]);
	if (u.st.hopNext === null || T >= u.st.hopNext) {
		let k = Math.floor(rnd(u) * spk.length);
		if (k === u.st.hopCur) k = (k + 1 + Math.floor(rnd(u) * (spk.length - 1))) % spk.length;
		u.st.hopCur = k;
		u.st.hopNext = T + interval;
	}
	const p = spk[u.st.hopCur];
	return { x: p[0], y: p[1], slew: HOP_SLEW };
}

// a random value that doesn't advance the unit's sequence (for interval lengths)
function rnd0(u) {
	const s = (u.st.seed * 48271) % 2147483647;
	return (s - 1) / 2147483646;
}

function perimeterPoint(s) {
	const { x0, x1, y0, y1 } = bounds;
	const W = x1 - x0, Hh = y1 - y0;
	let d = s * 2 * (W + Hh);
	if (d < W) return [x0 + d, y1];        // front, left to right
	d -= W;
	if (d < Hh) return [x1, y1 - d];       // right side, front to back
	d -= Hh;
	if (d < W) return [x1 - d, y0];        // back, right to left
	d -= W;
	return [x0, y0 + d];                   // left side, back to front
}

function at(x, y) {
	return { x, y, slew: SMOOTH_SLEW };
}

// ---- output ----

function sendNames() {
	for (let n = 1; n <= 9; n++) {
		const u = unitOf(n);
		outlet(1, "unit", n, u ? u.id : "-", u ? u.levelDb : 0);
	}
	outlet(1, "unitsdone");
}

function publish() {
	const d = new Dict("dbap_behave");
	d.parse(JSON.stringify({
		mode,
		modeKey: MODE_KEYS[MODE_NAMES.indexOf(mode)],
		modes: MODE_NAMES.map((m, i) => ({ key: MODE_KEYS[i], name: m })),
		glide,
		glideTime,
		speed: tempo,
		sticks,
		units: units.map(u => ({
			n: u.n, id: u.id, kind: u.kind, members: u.members,
			active: u.active ? 1 : 0, stick: u.stick || "", levelDb: u.levelDb
		}))
	}));
	outlet(2, "dictionary", "dbap_behave");
}

// ---- helpers ----

function toArr(v) {
	if (v === undefined || v === null) return [];
	return Array.isArray(v) ? v : [v];
}

function avg(a) {
	return a.reduce((t, v) => t + v, 0) / a.length;
}

function clamp(v, lo, hi) {
	return Math.max(lo, Math.min(hi, v));
}
