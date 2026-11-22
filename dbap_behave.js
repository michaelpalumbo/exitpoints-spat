// dbap_behave.js  (for a [v8 dbap_behave.js] object)
//
// Behaviour engine. Moves "units" (a source, or a group of sources) by sending
// position messages to dbap_control.js about 30 times a second.
//
// Units 1-8 are defined per scene by "keys" in dbap_scenes.json, one per
// nanoKONTROL2 channel.
//
// Keyboard ("key <ascii>", from [key] -> [prepend key]):
//   1-8   modes: stage, drift, orbit, hop, pulse, swarm, sway, perimeter
//   9     gamepad (sticks)
//   0     hold: active units stop where they are
//   TAB   glide / cut for mode and state changes
//
// From dbap_nk.js (or the room view):
//   toggle <n>                 unit n active (follows the mode) / frozen (stays put)
//   home <n>                   send unit n home and freeze it there
//   unitlevel <n> <dB>
//   unitparam <n> <name> <v>   spread (blur, m), width (x scene width), speed (x),
//                              accel (0-1, 1 = instant), range (0-1 of the movement)
//   speed <mult>               global behaviour speed
//   glidetime <seconds>
//
// Other messages:
//   dictionary dbap_state      from dbap_control.js
//   lstick <x> <y>, rstick <x> <y>   -1..1, +y = up
//   saveparams <file.json>, loadparams <file.json>   backup copies of the settings
//
// Settings (levels, per-unit parameters, global speed and glide) are kept per
// scene in dict "dbap_params". Put [dict dbap_params @embed 1] in the patch and
// save the patch to keep them.
//
// Outlets:
//   0  to dbap_control.js
//   1  to dbap_nk.js
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
const NUNITS = 8;

const MODE_KEYS = "1234567890";
const MODE_NAMES = ["stage", "drift", "orbit", "hop", "pulse", "swarm", "sway", "perimeter", "gamepad", "hold"];

const DEFAULTS = { level: 0, spread: 0.01, width: 1, speed: 1, accel: 1, range: 1 };
const PARAM_NAMES = ["spread", "width", "speed", "accel", "range"];

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

let params = null;          // { global: {speed, glide}, scenes: { name: { id: {...} } } }
let paramsDirty = false;

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
	const m = MODE_KEYS.indexOf(String.fromCharCode(a));
	if (m >= 0) setMode(MODE_NAMES[m]);
}

function lstick(x, y) { sticks.L = [x, y]; }
function rstick(x, y) { sticks.R = [x, y]; }

function speed(v) {
	tempo = Math.max(0.01, v);
	ensureParams();
	params.global.speed = tempo;
	paramsDirty = true;
	publish();
}

function glidetime(s) {
	glideTime = Math.max(0, s);
	ensureParams();
	params.global.glide = glideTime;
	paramsDirty = true;
	publish();
}

function toggle(n) {
	const u = unitOf(n);
	if (!u) return;
	u.active = !u.active;
	if (u.active) {
		startTrans(u, glide ? glideTime : 0);
	} else {
		u.hold = u.out.slice();
		u.trans = null;
	}
	outlet(1, "active", n, u.active ? 1 : 0);
	publish();
}

function home(n) {
	const u = unitOf(n);
	if (!u) return;
	u.active = false;
	u.hold = u.home.slice();
	startTrans(u, glide ? glideTime : 0);
	resetBehaviour(u);
	outlet(1, "active", n, 0);
	publish();
}

function unitlevel(n, db) {
	const u = unitOf(n);
	if (!u) return;
	u.p.level = db;
	applyLevel(u);
	paramsDirty = true;
	publish();
}

function unitparam(n, name, v) {
	const u = unitOf(n);
	if (!u || PARAM_NAMES.indexOf(name) < 0) return;
	u.p[name] = v;
	if (name === "spread") applySpread(u);
	if (name === "width") applyWidth(u);
	paramsDirty = true;
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
	// rebuild on every scene recall (sceneCount), so stored settings are reapplied
	const s = state.scene + "|" + state.sceneCount + "|" + JSON.stringify(state.keys || []) +
		"|" + JSON.stringify(state.sticks || {});
	if (s !== sig) {
		sig = s;
		buildUnits();
	}
}

// ---- settings storage ----

function ensureParams() {
	if (params) return;
	let o = {};
	try { o = JSON.parse(new Dict("dbap_params").stringify()) || {}; } catch (e) { o = {}; }
	params = { global: o.global || {}, scenes: o.scenes || {} };
	if (typeof params.global.speed === "number") tempo = params.global.speed;
	if (typeof params.global.glide === "number") glideTime = params.global.glide;
}

function writeParams() {
	new Dict("dbap_params").parse(JSON.stringify(params));
	paramsDirty = false;
}

function saveparams(file) {
	ensureParams();
	writeParams();
	new Dict("dbap_params").export_json(file);
	post("dbap_behave: settings saved to " + file + "\n");
}

function loadparams(file) {
	const d = new Dict("dbap_params");
	d.import_json(file);
	params = null;
	ensureParams();
	sig = "";        // force a rebuild so the loaded settings apply
	if (state) dictionary("dbap_state");
	post("dbap_behave: settings loaded from " + file + "\n");
}

// ---- units ----

function buildUnits() {
	ensureParams();
	if (!state.scene) {
		units = [];
		sendUnits();
		publish();
		return;
	}
	const old = {};
	for (const u of units) old[u.id] = u;
	const keys = toArr(state.keys).slice(0, NUNITS);
	const st = state.sticks || {};
	const L = toArr(st.L);
	const R = toArr(st.R);
	const sp = params.scenes[state.scene] = params.scenes[state.scene] || {};
	units = [];
	keys.forEach((id, i) => {
		const n = i + 1;
		let kind = "source";
		let members = [id];
		if (!state.sources[id]) {
			kind = "group";
			members = Object.keys(state.sources).filter(k => state.sources[k].group === id);
			if (!members.length) {
				post("dbap_behave: unit " + n + ": no source or group called " + id + "\n");
				return;
			}
		}
		const ms = members.map(m => state.sources[m]);
		const home = [avg(ms.map(s => s.home[0])), avg(ms.map(s => s.home[1]))];
		const pos = [avg(ms.map(s => s.x)), avg(ms.map(s => s.y))];
		const prev = old[id];
		sp[id] = Object.assign({}, DEFAULTS, sp[id] || {});
		const u = {
			n, id, kind, members,
			acoustic: ms.some(s => s.acoustic),
			hasWidth: ms.some(s => toArr(s.points).length > 1),
			baseWidth: {},
			p: sp[id],
			home,
			out: pos,
			pos: pos.slice(),
			vel: [0, 0],
			hold: pos.slice(),
			active: prev ? prev.active : true,
			stick: L.indexOf(n) >= 0 ? "L" : (R.indexOf(n) >= 0 ? "R" : null),
			trans: null,
			slew: -1,
			sector: -1,
			T: 0,
			st: {}
		};
		for (const m of members) u.baseWidth[m] = state.sources[m].width === undefined ? 1 : state.sources[m].width;
		resetBehaviour(u);
		units.push(u);
	});
	for (const u of units) {
		applyLevel(u);
		applySpread(u);
		applyWidth(u);
	}
	paramsDirty = true;
	sendUnits();
	publish();
}

function applyLevel(u) {
	const lin = Math.pow(10, u.p.level / 20);
	for (const m of u.members) outlet(0, "level", m, lin);
}

function applySpread(u) {
	for (const m of u.members) outlet(0, "blur", m, u.p.spread);
}

function applyWidth(u) {
	if (!u.hasWidth) return;
	for (const m of u.members) outlet(0, "width", m, u.baseWidth[m] * u.p.width);
}

function unitOf(n) {
	return units.find(u => u.n === n);
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

	let moved = false;
	for (const u of units) {
		u.T += dt * tempo * u.p.speed;
		let tg;
		if (u.active) {
			// fixed slot by unit number, so toggling one unit never moves the others
			tg = target(u, u.n - 1, units.length);
			if (mode !== "hold") {
				// range: how far the movement reaches away from home
				tg.x = u.home[0] + (tg.x - u.home[0]) * u.p.range;
				tg.y = u.home[1] + (tg.y - u.home[1]) * u.p.range;
			}
		} else {
			tg = { x: u.hold[0], y: u.hold[1], slew: SMOOTH_SLEW };
		}

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

		// acceleration: 1 = jump straight to the target, lower = the unit has weight
		if (u.p.accel >= 0.999) {
			u.pos = [x, y];
			u.vel = [0, 0];
		} else {
			const amax = 0.3 * Math.pow(200, u.p.accel);   // m/s^2, 0.3 to 60
			const want = [(x - u.pos[0]) * 4, (y - u.pos[1]) * 4];
			let dv = [want[0] - u.vel[0], want[1] - u.vel[1]];
			const m = Math.hypot(dv[0], dv[1]), lim = amax * dt;
			if (m > lim) dv = [dv[0] * lim / m, dv[1] * lim / m];
			u.vel = [u.vel[0] + dv[0], u.vel[1] + dv[1]];
			u.pos = [u.pos[0] + u.vel[0] * dt, u.pos[1] + u.vel[1] * dt];
			x = u.pos[0];
			y = u.pos[1];
			slew = SMOOTH_SLEW;
		}

		if (slew !== u.slew) {
			u.slew = slew;
			for (const mbr of u.members) outlet(0, "slew", mbr, slew);
		}
		if (Math.abs(x - u.out[0]) > 1e-4 || Math.abs(y - u.out[1]) > 1e-4) {
			u.out = [x, y];
			outlet(0, u.kind === "group" ? "groupq" : "posq", u.id, x, y);
			moved = true;
		}
	}
	if (moved) outlet(0, "flush");
	tickCount++;
	if (tickCount % 3 === 0) publish();
	if (tickCount % 15 === 0 && paramsDirty) writeParams();
}

// ---- behaviours ----
// Each returns where a unit should be now. i = its slot (unit number - 1),
// n = how many units the scene has. u.T is the unit's own clock (its speed).
// Acoustic units move less and more slowly (amp and tempo factors).

function target(u, i, n) {
	const H = u.home;
	const A = u.acoustic ? 0.6 : 1;
	const Tm = u.acoustic ? 0.5 : 1;
	const t = u.T;
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
		const R = 1.8 * A, tt = t * Tm;
		return at(
			H[0] + R * (0.6 * Math.sin(TAU * fr[0] * tt + ph[0]) + 0.4 * Math.sin(TAU * fr[1] * tt + ph[1])),
			H[1] + R * (0.6 * Math.sin(TAU * fr[2] * tt + ph[2]) + 0.4 * Math.sin(TAU * fr[3] * tt + ph[3])));
	}

	case "orbit": {
		// circles around the middle of the room, alternating directions, one lap ~40 s
		const rmax = Math.min(hx, hy) * 0.9;
		const r = Math.min(rmax, (0.35 + 0.3 * (i % 3)) * rmax / 0.95) * (u.acoustic ? 0.8 : 1);
		const dir = i % 2 ? -1 : 1;
		const a = TAU * i / n + dir * TAU * t * Tm / 40;
		return at(cx + r * Math.cos(a), cy + r * Math.sin(a));
	}

	case "hop":
		// hard cuts between speakers at random intervals (2-6 s, slower for acoustic)
		return hop(u, (2 + 4 * rnd0(u)) / Tm);

	case "pulse": {
		// cuts on a beat, each unit on a different speaker (in sync while speeds match)
		const P = 1.5;
		const beat = Math.floor(t * Tm / P);
		if (!spk.length) return at(H[0], H[1]);
		const p = spk[(beat + i) % spk.length];
		return { x: p[0], y: p[1], slew: HOP_SLEW };
	}

	case "swarm": {
		// a shared centre wanders the room (global clock); units buzz around it (own clock)
		const C = [cx + hx * 0.6 * Math.sin(TAU * 0.03 * T + 1), cy + hy * 0.6 * Math.sin(TAU * 0.021 * T)];
		const x = C[0] + 0.7 * Math.sin(TAU * fr[0] * 2 * t + ph[0]);
		const y = C[1] + 0.7 * Math.sin(TAU * fr[2] * 2 * t + ph[2]);
		if (u.acoustic) return at(x + (H[0] - x) * 0.4, y + (H[1] - y) * 0.4);
		return at(x, y);
	}

	case "sway": {
		// front to back and back again, ~12 s, staggered
		const th = TAU * t * Tm / 12 + TAU * i / n;
		const depth = (H[1] - bounds.y0) * A;
		return at(H[0], H[1] - (1 - Math.cos(th)) / 2 * depth);
	}

	case "perimeter": {
		// spread evenly around the walls, slowly rotating (one lap ~90 s)
		const s = ((i / n + t * Tm / 90) % 1 + 1) % 1;
		const p = perimeterPoint(s);
		if (u.acoustic) return at(p[0] + (H[0] - p[0]) * 0.3, p[1] + (H[1] - p[1]) * 0.3);
		return at(p[0], p[1]);
	}

	case "gamepad":
		return gamepad(u, H, A, Tm, t);
	}
	return at(H[0], H[1]);
}

function gamepad(u, H, A, Tm, t) {
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
		const c = [0.6 * Math.cos(TAU * 0.08 * t + ph[0]), 0.6 * Math.sin(TAU * 0.08 * t + ph[0])];
		const k = mag * A;
		return at(H[0] + (c[0] - H[0]) * k, H[1] + (c[1] - H[1]) * k);
	}
	case 2: {
		// down: fast jitter around home, wider as you push
		const R = 2.0 * A * mag;
		return at(
			H[0] + R * (0.6 * Math.sin(TAU * fr[0] * 3 * t + ph[0]) + 0.4 * Math.sin(TAU * fr[1] * 3 * t + ph[1])),
			H[1] + R * (0.6 * Math.sin(TAU * fr[2] * 3 * t + ph[2]) + 0.4 * Math.sin(TAU * fr[3] * 3 * t + ph[3])));
	}
	case 1: {
		// right: clockwise orbit around home, radius grows with the push
		const r = 2.0 * A * mag;
		const a = ph[0] - TAU * t * Tm / 6;
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
	if (u.st.hopNext === null || u.T >= u.st.hopNext) {
		let k = Math.floor(rnd(u) * spk.length);
		if (k === u.st.hopCur) k = (k + 1 + Math.floor(rnd(u) * (spk.length - 1))) % spk.length;
		u.st.hopCur = k;
		u.st.hopNext = u.T + interval;
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

function sendUnits() {
	for (let n = 1; n <= NUNITS; n++) {
		const u = unitOf(n);
		if (!u) {
			outlet(1, "unit", n, "-", 0, 0, 0, DEFAULTS.spread, 1, 1, 1, 1);
			continue;
		}
		outlet(1, "unit", n, u.id, u.hasWidth ? 1 : 0, u.active ? 1 : 0,
			u.p.level, u.p.spread, u.p.width, u.p.speed, u.p.accel, u.p.range);
	}
	outlet(1, "globals", tempo, glideTime);
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
			active: u.active ? 1 : 0, stick: u.stick || "", p: u.p
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