// dbap_behave.js  (for a [v8 dbap_behave.js] object)
//
// Behaviour engine. Moves "units" (a source, or a group of sources) by sending
// position messages to dbap_control.js about 30 times a second.
//
// Units 1-8 are defined per scene by "keys" in dbap_scenes.json, one per
// nanoKONTROL2 channel.
//
// Keyboard ("key <ascii>", from [key] -> [prepend key]):
//   1-9   modes: manual, drift, orbit, hop, pulse, swarm, sway, perimeter, loop
//   0     assign: each unit runs the behaviour it has been assigned
//   TAB   glide / cut for mode and state changes
//
// Assign mode (0): select units with their S buttons (they flash slowly), then
// press 1-9 to give the selected units that behaviour. 0 clears the selection.
//
// Every unit starts frozen in every mode (patch load and scene change). Each
// mode keeps its own frozen / active state per unit. The exception is mode 1,
// "set home positions" (manual inside): there every unit is always movable,
// so it sits at its home and can be dragged to a new one; M does nothing.
//
// From dbap_nk.js (or the room view):
//   toggle <n>                 unit n active / frozen in the current mode
//   home <n>                   send unit n home and freeze it there
//   select <n>                 toggle unit n's selection (assign mode only)
//   unitlevel <n> <dB>         -70 or lower = off
//   unitparam <n> <name> <v>   spread, width: per unit (all modes)
//                              range, speed, accel: per unit per behaviour
//   speed <mult>, glidetime <seconds>      global
//   clearloop <n>
//   lineupedit <0|1>, setkey <slot> <id>   line-up editing, passed to dbap_control.js
//   erasescene <name>          empty a switchemups line-up and forget its levels,
//                              settings, homes and loops
//   resetshow                  everything frozen; speed x1 and accel instant for
//                              every unit and behaviour (levels, spread, width,
//                              range, homes, loops and assignments are kept)
//
// From the room view (mouse; manual and loop, or units assigned to them):
//   drag <n> <x> <y>, dragend <n>
//     manual: moves the unit's home (stored per scene)
//     loop:   records the unit's path while dragging, loops it on release
//
// Other: dictionary dbap_state (from dbap_control.js),
//        saveparams <file.json>, loadparams <file.json>
//
// Settings are kept per scene and written to dbap_params.json in the patch's
// folder a couple of seconds after any change, so nobody has to save the patch.
// On load they're read from that file (or, if it doesn't exist yet, from an
// embedded [dict dbap_params], if there is one). The patch must have been saved
// once so it has a folder.
//
// Outlets:
//   0  to dbap_control.js
//   1  to dbap_nk.js
//   2  "dictionary dbap_behave" / "dictionary dbap_loops" for the room view

autowatch = 1;
inlets = 1;
outlets = 3;

const TICK_MS = 33;
const SMOOTH_SLEW = 50;     // ms, continuous movement
const HOP_SLEW = 3;         // ms, hard cuts (just enough to avoid clicks)
const LOOP_CLOSE = 0.4;     // s, glide from a loop's end back to its start
const LOOP_MAX_PTS = 3000;
const TAU = Math.PI * 2;
const NUNITS = 8;

const MODE_KEYS = "1234567890";
const MODE_NAMES = ["manual", "drift", "orbit", "hop", "pulse", "swarm", "sway", "perimeter", "loop", "assign"];
const BEHAVIOURS = MODE_NAMES.slice(0, 9);
// names shown on screen ("manual" is kept inside so saved settings still match)
const MODE_LABELS = { manual: "set home" };
const MODE_TITLES = { manual: "set home positions" };
function modeLabel(m) { return MODE_LABELS[m] || m; }
function modeTitle(m) { return MODE_TITLES[m] || modeLabel(m); }

const UNIT_DEFAULTS = { level: 0, spread: 0.01, width: 1 };
const MODE_DEFAULTS = { range: 1, speed: 1, accel: 1 };
const MODE_PARAMS = ["range", "speed", "accel"];

let state = null;
let sig = "";
let units = [];
let spk = [];
let bounds = { x0: -3, x1: 3, y0: -3, y1: 3 };
let mode = "manual";
let glide = 1;
let glideTime = 2;
let tempo = 1;
let T = 0;
let lastMs = Date.now();
let lastAsk = 0;
let tickCount = 0;
const selected = new Set();

// Dictionaries are held open for the life of the script. A named dict that
// nothing holds can be freed between writes, and a reader then gets an empty one.
const stateIn = new Dict("dbap_state");
const behDict = new Dict("dbap_behave");
const loopsDict = new Dict("dbap_loops");
const paramsDict = new Dict("dbap_params");

let params = null;          // { global: {speed, glide}, scenes: { name: { id: {...} } } }
let paramsDirty = false;    // the in-memory dict needs updating
let fileDirty = false;      // dbap_params.json needs rewriting
const PATCHER = this.patcher;
const PARAMS_FILE = "dbap_params.json";
// Don't read or write the stored settings until the patch has finished loading
// (loadbang), or 1.5 s after this script was loaded (an autowatch reload).
let ready = false;
const bornMs = Date.now();

const task = new Task(tick, this);
task.interval = TICK_MS;
task.repeat();

function loadbang() {
	ready = true;
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
	if (m < 0) return;
	if (mode === "assign" && selected.size) {
		if (MODE_NAMES[m] === "assign") clearSelection();
		else assign(MODE_NAMES[m]);
		return;
	}
	setMode(MODE_NAMES[m]);
}

// line-up editing (switchemups): passed through to dbap_control.js
function lineupedit(on) { outlet(0, "lineupedit", on ? 1 : 0); }
function setkey(slot, id) { outlet(0, "setkey", slot, id); }

function erasescene(name) {
	name = String(name);
	if (name.indexOf("switchemups") !== 0) {
		post("dbap_behave: only switchemups scenes can be erased\n");
		return;
	}
	ensureParams();
	delete params.scenes[name];
	paramsDirty = true;
	if (state && state.scene === name) sig = "";   // rebuild from fresh defaults
	outlet(0, "clearlineup", name);
}

function speed(v) {
	tempo = Math.max(0.01, v);
	if (params) { params.global.speed = tempo; paramsDirty = true; }
	publish();
}

function glidetime(s) {
	glideTime = Math.max(0, s);
	if (params) { params.global.glide = glideTime; paramsDirty = true; }
	publish();
}

function toggle(n) {
	const u = unitOf(n);
	if (!u) return;
	if (behOf(u) === "manual") {      // always movable here: M does nothing
		outlet(1, "active", n, 1);
		return;
	}
	setActive(u, !isActive(u));
	if (isActive(u)) {
		resetBehaviour(u);
		startTrans(u, glide ? glideTime : 0);
	} else {
		u.hold = u.out.slice();
		u.trans = null;
	}
	outlet(1, "active", n, isActive(u) ? 1 : 0);
	publish();
}

function home(n) {
	const u = unitOf(n);
	if (!u) return;
	setActive(u, false);
	u.hold = u.home.slice();
	startTrans(u, glide ? glideTime : 0);
	resetBehaviour(u);
	outlet(1, "active", n, 0);
	publish();
}

function select(n) {
	const u = unitOf(n);
	if (!u || mode !== "assign") return;
	if (selected.has(n)) selected.delete(n);
	else selected.add(n);
	outlet(1, "selected", n, selected.has(n) ? 1 : 0);
	publish();
}

function clearSelection() {
	for (const n of selected) outlet(1, "selected", n, 0);
	selected.clear();
	publish();
}

function assign(beh) {
	for (const n of selected) {
		const u = unitOf(n);
		if (!u) continue;
		u.p.assign = beh;
		resetBehaviour(u);
		if (isActive(u)) startTrans(u, glide ? glideTime : 0);
		outlet(1, "selected", n, 0);
	}
	selected.clear();
	paramsDirty = true;
	sendUnits();      // the knobs now edit each unit's newly assigned behaviour
	publishLoops();
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
	if (!u) return;
	if (name === "spread" || name === "width") {
		u.p[name] = v;
		if (name === "spread") applySpread(u);
		else applyWidth(u);
	} else if (MODE_PARAMS.indexOf(name) >= 0) {
		mp(u)[name] = v;
		if (name === "range") u.showRangeUntil = Date.now() + 2000;
	} else {
		return;
	}
	paramsDirty = true;
	publish();
}

function resetshow() {
	if (!params) return;
	for (const sc of Object.values(params.scenes)) {
		for (const p of Object.values(sc)) {
			for (const m of Object.values(p.modes || {})) {
				m.speed = 1;
				m.accel = 1;
			}
		}
	}
	for (const u of units) {
		u.activeBy = {};
		u.hold = u.out.slice();
		u.trans = null;
	}
	clearSelection();
	paramsDirty = true;
	sendUnits();
	publish();
	post("dbap_behave: show reset (all frozen, speed x1, accel instant)\n");
}

function drag(n, x, y) {
	const u = unitOf(n);
	if (!u) return;
	const beh = behOf(u);
	if (beh !== "manual" && beh !== "loop") return;
	x = clamp(x, bounds.x0, bounds.x1);
	y = clamp(y, bounds.y0, bounds.y1);
	const now = Date.now();
	u.dragging = true;
	u.dragPos = [x, y];
	u.trans = null;
	if (beh === "manual") {
		u.home = [x, y];
		u.p.home = [round3(x), round3(y)];
		if (!isActive(u)) u.hold = [x, y];
		paramsDirty = true;
	} else {
		if (!u.rec) {
			u.rec = { t0: now, pts: [], last: -1 };
			if (!isActive(u)) {
				setActive(u, true);
				outlet(1, "active", n, 1);
			}
		}
		const t = now - u.rec.t0;
		if (t - u.rec.last >= 15 && u.rec.pts.length < LOOP_MAX_PTS) {
			u.rec.pts.push([round3(t / 1000), round3(x), round3(y)]);
			u.rec.last = t;
		}
	}
	publish();
}

function dragend(n) {
	const u = unitOf(n);
	if (!u) return;
	u.dragging = false;
	if (u.rec) {
		const pts = u.rec.pts;
		u.rec = null;
		if (pts.length >= 3 && pts[pts.length - 1][0] > 0.3) {
			u.p.loop = { dur: pts[pts.length - 1][0], pts };
			u.loopT0 = u.T;
			paramsDirty = true;
			outlet(1, "hasloop", n, 1);
			publishLoops();
		}
	}
	if (u.dragPos) u.pos = u.dragPos.slice();
	u.vel = [0, 0];
	if (!isActive(u)) u.hold = u.pos.slice();
	publish();
}

function clearloop(n) {
	const u = unitOf(n);
	if (!u || !u.p.loop) return;
	delete u.p.loop;
	paramsDirty = true;
	outlet(1, "hasloop", n, 0);
	publishLoops();
	publish();
}

function dictionary(name) {
	if (name !== "dbap_state") return;
	const o = JSON.parse(stateIn.stringify());
	if (!o || !o.sources) return;   // empty or partial: keep the last good state
	state = o;
	spk = toArr(state.speakers).map(s => [s.x, s.y]);
	if (spk.length) {
		const xs = spk.map(p => p[0]);
		const ys = spk.map(p => p[1]);
		bounds = { x0: Math.min(...xs), x1: Math.max(...xs), y0: Math.min(...ys), y1: Math.max(...ys) };
	}
	if (!ready) return;   // tick() picks it up once the patch has loaded
	// rebuild on every scene recall (sceneCount), so stored settings are reapplied
	const s = state.scene + "|" + state.sceneCount + "|" + JSON.stringify(state.keys || []);
	if (s !== sig) {
		sig = s;
		buildUnits();
	}
}

// ---- settings storage ----

function ensureParams() {
	if (params) return;
	const path = patchFile(PARAMS_FILE);
	if (path && fileExists(path)) {
		try { paramsDict.import_json(path); } catch (e) { post("dbap_behave: couldn't read " + path + "\n"); }
	}
	let o = {};
	try { o = JSON.parse(paramsDict.stringify()) || {}; } catch (e) { o = {}; }
	params = { global: o.global || {}, scenes: o.scenes || {} };
	if (typeof params.global.speed === "number") tempo = params.global.speed;
	if (typeof params.global.glide === "number") glideTime = params.global.glide;
	outlet(1, "globals", tempo, glideTime);
}

function writeParams() {
	paramsDict.parse(JSON.stringify(params));
	paramsDirty = false;
	fileDirty = true;
}

function writeParamsFile() {
	fileDirty = false;
	const path = patchFile(PARAMS_FILE);
	if (!path) return;
	try { paramsDict.export_json(path); } catch (e) { post("dbap_behave: couldn't write " + path + "\n"); }
}

function saveparams(file) {
	if (!params) return;
	writeParams();
	paramsDict.export_json(file);
	post("dbap_behave: settings saved to " + file + "\n");
}

function loadparams(file) {
	paramsDict.import_json(file);
	params = null;
	// skip the automatic file this once, so the backup is what gets loaded
	let o = {};
	try { o = JSON.parse(paramsDict.stringify()) || {}; } catch (e) { o = {}; }
	params = { global: o.global || {}, scenes: o.scenes || {} };
	paramsDirty = true;
	sig = "";
	if (state) dictionary("dbap_state");
	post("dbap_behave: settings loaded from " + file + "\n");
}

// a file in the patch's folder, or "" if the patch has never been saved
function patchFile(name) {
	let fp = "";
	try { fp = PATCHER && PATCHER.filepath ? String(PATCHER.filepath) : ""; } catch (e) { fp = ""; }
	const i = fp.lastIndexOf("/");
	if (i < 0) return "";
	return fp.slice(0, i + 1) + name;
}

function fileExists(path) {
	try {
		const f = new File(path, "read");
		const ok = f.isopen;
		f.close();
		return ok;
	} catch (e) {
		return false;
	}
}

// per unit, per behaviour: range, speed, accel
function mp(u, beh) {
	beh = beh || behOf(u);
	u.p.modes = u.p.modes || {};
	u.p.modes[beh] = Object.assign({}, MODE_DEFAULTS, u.p.modes[beh] || {});
	return u.p.modes[beh];
}

// the behaviour a unit is running: the mode, or in assign mode its assignment
function behOf(u) {
	return mode === "assign" ? (u.p.assign || "manual") : mode;
}

// in "set home positions" (manual) every unit is always movable
function isActive(u) { return behOf(u) === "manual" || !!u.activeBy[mode]; }
function setActive(u, on) { u.activeBy[mode] = !!on; }

// ---- units ----

function buildUnits() {
	ensureParams();
	selected.clear();
	if (!state.scene) {
		units = [];
		sendUnits();
		publishLoops();
		publish();
		return;
	}
	const keys = toArr(state.keys).slice(0, NUNITS);
	const sp = params.scenes[state.scene] = params.scenes[state.scene] || {};
	units = [];
	keys.forEach((id, i) => {
		const n = i + 1;
		if (id === "-" || id === "") return;   // empty slot in a line-up
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
		const pos = [avg(ms.map(s => s.x)), avg(ms.map(s => s.y))];
		// keep what's stored; older files had range/speed/accel per unit, those now
		// start fresh per behaviour
		const old = sp[id] || {};
		const kept = {};
		for (const k of ["level", "spread", "width", "home", "loop", "assign", "modes"]) {
			if (old[k] !== undefined) kept[k] = old[k];
		}
		sp[id] = Object.assign({}, UNIT_DEFAULTS, { modes: {} }, kept);
		const ph = toArr(sp[id].home);
		const homeXY = ph.length === 2 ? ph.slice() : [avg(ms.map(s => s.home[0])), avg(ms.map(s => s.home[1]))];
		const label = kind === "source" ? (state.sources[id].label || id) : id;
		const u = {
			n, id, kind, members, label,
			acoustic: ms.some(s => s.acoustic),
			hasWidth: ms.some(s => toArr(s.points).length > 1),
			baseWidth: {},
			p: sp[id],
			home: homeXY,
			out: pos,
			pos: pos.slice(),
			vel: [0, 0],
			hold: pos.slice(),
			activeBy: {},         // every unit starts frozen in every mode
			trans: null,
			slew: -1,
			T: 0,
			loopT0: 0,
			rot: null,
			ghost: homeXY.slice(),
			showRangeUntil: 0,
			dragging: false,
			dragPos: null,
			rec: null,
			hg: null,
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
	publishLoops();
	publish();
}

function applyLevel(u) {
	// -70 dB (the bottom of the nanoKONTROL2 fader) and below is off
	const lin = u.p.level <= -70 ? 0 : Math.pow(10, u.p.level / 20);
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
	if (mode === "assign" && name !== "assign") clearSelection();
	mode = name;
	for (const u of units) {
		if (isActive(u)) {
			resetBehaviour(u);
			startTrans(u, glide ? glideTime : 0);
		} else {
			u.hold = u.out.slice();   // frozen in this mode: stays where it is
			u.trans = null;
		}
	}
	sendUnits();   // active states and per-behaviour settings change with the mode
	publishLoops();
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
	u.hg = null;
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
	if (!ready && now - bornMs > 1500) ready = true;
	if (!state || !ready) {
		if (ready && now - lastAsk > 1000) { lastAsk = now; outlet(0, "dump"); }
		return;
	}
	if (!params) { sig = ""; dictionary("dbap_state"); }   // first build after loading
	T += dt * tempo;
	const lis = state.room && state.room.listener ? toArr(state.room.listener) : [0, 0];

	let moved = false;
	for (const u of units) {
		const beh = behOf(u);
		const m = mp(u, beh);
		u.T += dt * tempo * m.speed;
		let tg;
		if (u.dragging) {
			tg = { x: u.dragPos[0], y: u.dragPos[1], kind: "cut" };
		} else if (isActive(u)) {
			// fixed slot by unit number, so toggling one unit never moves the others
			tg = target(u, beh, u.n - 1, units.length);
			u.ghost = [tg.x, tg.y];
			if (beh !== "loop") {
				// range: how far the movement reaches away from home
				tg.x = u.home[0] + (tg.x - u.home[0]) * m.range;
				tg.y = u.home[1] + (tg.y - u.home[1]) * m.range;
			}
		} else {
			tg = { x: u.hold[0], y: u.hold[1], kind: "move" };
			u.ghost = u.hold.slice();
		}

		let x = tg.x, y = tg.y;
		const inTrans = !!u.trans;
		if (u.trans) {
			const k = (now - u.trans.t0) / u.trans.dur;
			if (k >= 1) {
				u.trans = null;
			} else {
				const e = k * k * (3 - 2 * k);
				x = u.trans.from[0] + (x - u.trans.from[0]) * e;
				y = u.trans.from[1] + (y - u.trans.from[1]) * e;
			}
		}
		x = clamp(x, bounds.x0, bounds.x1);
		y = clamp(y, bounds.y0, bounds.y1);

		// movement kinds:
		//   cut  - jump (pulse, dragging): accel is ignored
		//   hop  - jump, or with accel < instant a straight eased move to the next speaker
		//   move - continuous: accel gives the unit weight (it swings into place)
		let slew = SMOOTH_SLEW;
		const instant = m.accel >= 0.999;
		if (inTrans) {
			u.pos = [x, y];
			u.vel = [0, 0];
			u.hg = null;
		} else if (tg.kind === "cut" || (tg.kind === "hop" && instant)) {
			u.pos = [x, y];
			u.vel = [0, 0];
			u.hg = null;
			slew = u.dragging ? SMOOTH_SLEW : HOP_SLEW;
		} else if (tg.kind === "hop") {
			if (!u.hg || Math.abs(u.hg.to[0] - x) > 1e-6 || Math.abs(u.hg.to[1] - y) > 1e-6) {
				const D = Math.hypot(x - u.pos[0], y - u.pos[1]);
				u.hg = { from: u.pos.slice(), to: [x, y], t0: now, dur: Math.max(1, 2000 * Math.sqrt(D / accelOf(m.accel))) };
			}
			const k = Math.min(1, (now - u.hg.t0) / u.hg.dur);
			const e = k * k * (3 - 2 * k);
			u.pos = [u.hg.from[0] + (u.hg.to[0] - u.hg.from[0]) * e, u.hg.from[1] + (u.hg.to[1] - u.hg.from[1]) * e];
			u.vel = [0, 0];
		} else if (instant) {
			u.pos = [x, y];
			u.vel = [0, 0];
		} else {
			const amax = accelOf(m.accel);
			const want = [(x - u.pos[0]) * 4, (y - u.pos[1]) * 4];
			let dv = [want[0] - u.vel[0], want[1] - u.vel[1]];
			const mag = Math.hypot(dv[0], dv[1]), lim = amax * dt;
			if (mag > lim) dv = [dv[0] * lim / mag, dv[1] * lim / mag];
			u.vel = [u.vel[0] + dv[0], u.vel[1] + dv[1]];
			u.pos = [u.pos[0] + u.vel[0] * dt, u.pos[1] + u.vel[1] * dt];
		}
		x = u.pos[0];
		y = u.pos[1];

		if (slew !== u.slew) {
			u.slew = slew;
			for (const mbr of u.members) outlet(0, "slew", mbr, slew);
		}

		// multi-mic sources face the calibration position
		if (u.kind === "source" && u.hasWidth) {
			const dx = x - lis[0], dy = y - lis[1];
			if (Math.hypot(dx, dy) > 0.3) {
				const rot = Math.atan2(dy, dx) * 180 / Math.PI - 90;
				if (u.rot === null || Math.abs(angDiff(rot, u.rot)) > 1) {
					u.rot = rot;
					outlet(0, "rotq", u.id, rot);
					moved = true;
				}
			}
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
	if (tickCount % 60 === 0 && fileDirty) writeParamsFile();   // about every 2 s
}

function accelOf(a) {
	return 0.3 * Math.pow(200, a);   // m/s^2, 0.3 to 60
}

function angDiff(a, b) {
	let d = (a - b) % 360;
	if (d > 180) d -= 360;
	if (d < -180) d += 360;
	return d;
}

// ---- behaviours ----
// Each returns where a unit should be now, and its movement kind.
// i = its slot (unit number - 1), n = how many units the scene has.
// u.T is the unit's own clock (global speed x its speed for this behaviour).

function target(u, beh, i, n) {
	const H = u.home;
	const t = u.T;
	const ph = u.st.ph, fr = u.st.fr;
	const cx = (bounds.x0 + bounds.x1) / 2, cy = (bounds.y0 + bounds.y1) / 2;
	const hx = (bounds.x1 - bounds.x0) / 2, hy = (bounds.y1 - bounds.y0) / 2;
	n = Math.max(1, n);

	switch (beh) {
	case "manual":
		return at(H[0], H[1]);

	case "drift":
		// slow wandering over the whole room
		return at(
			cx + hx * 0.8 * (0.6 * Math.sin(TAU * fr[0] * t + ph[0]) + 0.4 * Math.sin(TAU * fr[1] * t + ph[1])),
			cy + hy * 0.8 * (0.6 * Math.sin(TAU * fr[2] * t + ph[2]) + 0.4 * Math.sin(TAU * fr[3] * t + ph[3])));

	case "orbit": {
		// circles around the middle of the room, alternating directions, one lap ~40 s
		const rmax = Math.min(hx, hy) * 0.9;
		const r = Math.min(rmax, (0.35 + 0.3 * (i % 3)) * rmax / 0.95);
		const dir = i % 2 ? -1 : 1;
		const a = TAU * i / n + dir * TAU * t / 40;
		return at(cx + r * Math.cos(a), cy + r * Math.sin(a));
	}

	case "hop":
		// cuts between speakers at random intervals, 2-6 s
		return hop(u, 2 + 4 * rnd0(u));

	case "pulse": {
		// cuts on a beat, each unit on a different speaker (in sync while speeds match)
		const beat = Math.floor(t / 1.5);
		if (!spk.length) return at(H[0], H[1]);
		const p = spk[(beat + i) % spk.length];
		return { x: p[0], y: p[1], kind: "cut" };
	}

	case "swarm": {
		// a shared centre wanders the room (global clock); units buzz around it (own clock)
		const C = [cx + hx * 0.6 * Math.sin(TAU * 0.03 * T + 1), cy + hy * 0.6 * Math.sin(TAU * 0.021 * T)];
		return at(C[0] + 0.7 * Math.sin(TAU * fr[0] * 2 * t + ph[0]), C[1] + 0.7 * Math.sin(TAU * fr[2] * 2 * t + ph[2]));
	}

	case "sway": {
		// front to back and back again, ~12 s, staggered
		const th = TAU * t / 12 + TAU * i / n;
		return at(H[0], H[1] - (1 - Math.cos(th)) / 2 * (H[1] - bounds.y0));
	}

	case "perimeter": {
		// spread evenly around the walls, slowly rotating (one lap ~90 s)
		const p = perimeterPoint(((i / n + t / 90) % 1 + 1) % 1);
		return at(p[0], p[1]);
	}

	case "loop":
		return loopPoint(u, H);
	}
	return at(H[0], H[1]);
}

function loopPoint(u, H) {
	const L = u.p.loop;
	if (!L || !L.pts || L.pts.length < 2) return at(H[0], H[1]);
	const pts = L.pts;
	const total = L.dur + LOOP_CLOSE;
	const tt = (((u.T - u.loopT0) % total) + total) % total;
	if (tt >= L.dur) {
		const k = (tt - L.dur) / LOOP_CLOSE, e = k * k * (3 - 2 * k);
		const a = pts[pts.length - 1], b = pts[0];
		return at(a[1] + (b[1] - a[1]) * e, a[2] + (b[2] - a[2]) * e);
	}
	let lo = 0, hi = pts.length - 1;
	while (hi - lo > 1) {
		const mid = (lo + hi) >> 1;
		if (pts[mid][0] <= tt) lo = mid; else hi = mid;
	}
	const a = pts[lo], b = pts[hi];
	const k = b[0] > a[0] ? (tt - a[0]) / (b[0] - a[0]) : 0;
	return at(a[1] + (b[1] - a[1]) * k, a[2] + (b[2] - a[2]) * k);
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
	return { x: p[0], y: p[1], kind: "hop" };
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
	return { x, y, kind: "move" };
}

// ---- output ----

function sendUnits() {
	for (let n = 1; n <= NUNITS; n++) {
		const u = unitOf(n);
		if (!u) {
			outlet(1, "unit", n, "-", 0, 0, 0, UNIT_DEFAULTS.spread, 1, 1, 1, 1, 0, "-");
			continue;
		}
		const m = mp(u);
		outlet(1, "unit", n, String(u.label).replace(/ /g, "_"), u.hasWidth ? 1 : 0, isActive(u) ? 1 : 0,
			u.p.level, u.p.spread, u.p.width, m.speed, m.accel, m.range, u.p.loop ? 1 : 0, behOf(u));
	}
	outlet(1, "behmode", mode, modeLabel(mode).replace(/ /g, "_"));
	outlet(1, "unitsdone");
}

function publish() {
	behDict.parse(JSON.stringify({
		mode,
		modeKey: MODE_KEYS[MODE_NAMES.indexOf(mode)],
		modes: MODE_NAMES.map((m, i) => ({ key: MODE_KEYS[i], name: m, label: modeLabel(m) })),
		modeTitle: modeTitle(mode),
		glide,
		glideTime,
		speed: tempo,
		units: units.map(u => {
			const beh = behOf(u);
			return {
				n: u.n, id: u.id, kind: u.kind, members: u.members,
				active: isActive(u) ? 1 : 0,
				beh,
				assign: modeLabel(u.p.assign || "manual"),
				selected: selected.has(u.n) ? 1 : 0,
				spread: u.p.spread,
				range: mp(u, beh).range,
				hasLoop: u.p.loop ? 1 : 0,
				home: u.home, ghost: u.ghost,
				showRange: Date.now() < u.showRangeUntil ? 1 : 0,
				dragging: u.dragging ? 1 : 0
			};
		})
	}));
	outlet(2, "dictionary", "dbap_behave");
}

// loop paths for drawing, thinned to about 200 points each
function publishLoops() {
	const out = {};
	for (const u of units) {
		const L = u.p.loop;
		if (!L || !L.pts) continue;
		const step = Math.max(1, Math.floor(L.pts.length / 200));
		const pts = [];
		for (let i = 0; i < L.pts.length; i += step) pts.push([L.pts[i][1], L.pts[i][2]]);
		out[u.n] = pts;
	}
	loopsDict.parse(JSON.stringify({ loops: out }));
	outlet(2, "dictionary", "dbap_loops");
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

function round3(v) {
	return Math.round(v * 1000) / 1000;
}