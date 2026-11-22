// dbap_control.js  (for a [v8 dbap_control.js] object)
//
// Holds the sources for the current scene and writes point positions into
// buffer~ dbap_pts for the gen~ core. A source is one or more points
// (console channels) that move together. Stereo pairs, mic pairs and the
// drum kit are single sources with per-point offsets.
//
// Messages:
//   loadscenes <file.json>      load scene definitions
//   scene <name>                recall a scene (fades out everything else)
//   pos <id> <x> <y>            move a source
//   group <gid> <x> <y>         move a group by its centroid, keeping offsets
//   width <id> <m>              scale a source's point offsets
//   rotate <id> <deg>           rotate a source's point offsets
//   slew <id> <ms>              gain smoothing, 0 = hard cut
//   blur <id> <m>               spatial blur
//   level <id> <lin>            source level (linear)
//   enable <id> <0|1>
//   home <id>                   send source to its home position
//   sethome <id>                make the current position its home
//   dump                        republish state
//
// Batched (for dbap_behave.js, ~30 Hz): these update the buffer but don't
// republish; send "flush" after a batch.
//   posq <id> <x> <y>
//   groupq <gid> <x> <y>
//   flush
//
// Room / calibration (room units, normally feet; inches as decimals):
//   loadroom <file.json>        load measurements
//   saveroom <file.json>        save measurements (plus computed values)
//   measure <n> <a> <b>         speaker n: distance from mark A, from mark B
//   baseline <d>                distance between marks A and B
//   listener <x> <y>            calibration position (centred room coords)
//   operator <x> <y>            operator position (display only)
//   adjust <n> <dB> <ms>        manual gain / delay offset for speaker n
//   calibrate <0|1>             bypass / enable delay and gain trims
//
// Speakers: 1 FL, 2 FR, 3 SL, 4 SR, 5 BL, 6 BR.
// Mark A is the LEFT mark when facing the stage, B the right one.
// Speaker positions are solved from the A/B distances and centred on the
// middle of the six speakers.
//
// Outlet: "dictionary dbap_state" after every change (for UI and debugging).

autowatch = 1;
inlets = 1;
outlets = 1;

const NPTS = 24;
const NSPK = 6;

const pts = new Buffer("dbap_pts");
const spkbuf = new Buffer("dbap_spk");   // 6 frames x 4 ch: x, y, delay ms, gain
const stateDict = new Dict("dbap_state");

let scenes = {};
let sceneName = "";
let sources = {};
let dirty = false;
let sceneCount = 0;   // bumps on every recall, so listeners can reapply settings

const FT = 0.3048;

// default: 24 ft square, marks A and B at the FL and FR speakers
const DEFAULT_ROOM = {
	units: "ft",
	baseline: 24,
	speed_of_sound: 343,
	speakers: {
		"1": { label: "FL", a: 0,      b: 24 },
		"2": { label: "FR", a: 24,     b: 0 },
		"3": { label: "SL", a: 12,     b: 26.833 },
		"4": { label: "SR", a: 26.833, b: 12 },
		"5": { label: "BL", a: 24,     b: 33.941 },
		"6": { label: "BR", a: 33.941, b: 24 }
	},
	listener: [0, 0],
	operator: [8, -8],
	adjust: {}
};

let room = JSON.parse(JSON.stringify(DEFAULT_ROOM));
let speakers = [];   // metres, centred
let cal = [];        // per speaker: dist_m, delay_ms, gain_db
let calOn = true;

const DEFAULTS = {
	width: 1, rotation: 0, level: 1, slew: 20, blur: 0.01,
	enabled: true, acoustic: false, group: ""
};

function loadbang() {
	init();
}

function init() {
	// buffer~ dbap_pts 1 5 and dbap_spk 1 2 already hold ~44 frames at 1 ms,
	// which is enough. The resize is a nicety; don't let it stop init.
	try {
		pts.send("sizeinsamps", NPTS);
		spkbuf.send("sizeinsamps", NSPK);
	} catch (e) {
		post("dbap: buffer resize skipped (" + e + ")\n");
	}
	for (let i = 0; i < NPTS; i++) writePoint(i, 0, 0, 0, 20, 0.01);
	updateRoom();
}

function loadscenes(file) {
	const d = new Dict("dbap_scenes");
	d.import_json(file);
	scenes = JSON.parse(d.stringify());
	post("dbap: scenes loaded: " + Object.keys(scenes).join(", ") + "\n");
}

function scene(name) {
	const sc = scenes[name];
	if (!sc) {
		error("dbap: no scene " + name + "\n");
		return;
	}
	writeSpeakers();
	for (let i = 0; i < NPTS; i++) pts.poke(3, i, 0);
	sources = {};
	for (const [id, def] of Object.entries(sc.sources)) {
		const s = Object.assign({}, DEFAULTS, def);
		s.id = id;
		s.home = s.home.slice();
		s.x = s.home[0];
		s.y = s.home[1];
		sources[id] = s;
		writeSource(s);
	}
	sceneName = name;
	sceneCount++;
	publish();
}

// ---- per-source messages ----

function pos(id, x, y) { edit(id, s => { s.x = x; s.y = y; }); }
function width(id, w) { edit(id, s => { s.width = w; }); }
function rotate(id, deg) { edit(id, s => { s.rotation = deg; }); }
function slew(id, ms) { edit(id, s => { s.slew = Math.max(0, ms); }); }
function blur(id, m) { edit(id, s => { s.blur = Math.max(0.001, m); }); }
function level(id, v) { edit(id, s => { s.level = Math.max(0, v); }); }
function enable(id, on) { edit(id, s => { s.enabled = !!on; }); }
function home(id) { edit(id, s => { s.x = s.home[0]; s.y = s.home[1]; }); }
function sethome(id) { edit(id, s => { s.home = [s.x, s.y]; }); }

function group(gid, x, y) {
	if (moveGroup(gid, x, y)) publish();
}

function posq(id, x, y) {
	const s = sources[id];
	if (!s) return;
	s.x = x;
	s.y = y;
	writeSource(s);
	dirty = true;
}

function groupq(gid, x, y) {
	if (moveGroup(gid, x, y)) dirty = true;
}

function flush() {
	if (!dirty) return;
	dirty = false;
	publish();
}

function moveGroup(gid, x, y) {
	const members = Object.values(sources).filter(s => s.group === gid);
	if (!members.length) {
		error("dbap: no group " + gid + "\n");
		return false;
	}
	const cx = members.reduce((a, s) => a + s.x, 0) / members.length;
	const cy = members.reduce((a, s) => a + s.y, 0) / members.length;
	for (const s of members) {
		s.x += x - cx;
		s.y += y - cy;
		writeSource(s);
	}
	return true;
}

// ---- room / calibration ----

function loadroom(file) {
	const d = new Dict("dbap_room");
	d.import_json(file);
	room = Object.assign(JSON.parse(JSON.stringify(DEFAULT_ROOM)), JSON.parse(d.stringify()));
	post("dbap: room loaded from " + file + "\n");
	updateRoom();
}

function saveroom(file) {
	const out = JSON.parse(JSON.stringify(room));
	out.computed = speakers.map((p, i) => ({
		speaker: i + 1,
		label: room.speakers[i + 1].label,
		x_m: round(p[0], 3), y_m: round(p[1], 3),
		dist_m: round(cal[i].dist_m, 3),
		delay_ms: round(cal[i].delay_ms, 3),
		gain_db: round(cal[i].gain_db, 2)
	}));
	const d = new Dict("dbap_room");
	d.parse(JSON.stringify(out));
	d.export_json(file);
	post("dbap: room saved to " + file + "\n");
}

function measure(n, a, b) {
	const sp = room.speakers[n];
	if (!sp) { error("dbap: no speaker " + n + "\n"); return; }
	sp.a = a;
	sp.b = b;
	updateRoom();
}

function baseline(d) { room.baseline = d; updateRoom(); }
function listener(x, y) { room.listener = [x, y]; updateRoom(); }
function operator(x, y) { room.operator = [x, y]; publish(); }
function calibrate(on) { calOn = !!on; writeSpeakers(); publish(); }

function adjust(n, db, ms) {
	if (n < 1 || n > NSPK) return;
	room.adjust[n] = { gain_db: db || 0, delay_ms: ms || 0 };
	updateRoom();
}

function updateRoom() {
	solveRoom();
	calcCal();
	writeSpeakers();
	publish();
}

// trilateration: A at (0,0), B at (L,0), speakers on the audience side (y < 0)
function solveRoom() {
	const k = room.units === "m" ? 1 : FT;
	const L = room.baseline;
	const local = [];
	for (let n = 1; n <= NSPK; n++) {
		const { a, b } = room.speakers[n];
		const x = (a * a - b * b + L * L) / (2 * L);
		const y2 = a * a - x * x;
		if (y2 < -0.25) {
			post("dbap: speaker " + n + " measurements don't meet, check a/b\n");
		}
		local.push([x, -Math.sqrt(Math.max(0, y2))]);
	}
	const cx = local.reduce((t, p) => t + p[0], 0) / NSPK;
	const cy = local.reduce((t, p) => t + p[1], 0) / NSPK;
	speakers = local.map(p => [(p[0] - cx) * k, (p[1] - cy) * k]);
}

// delay closer speakers and turn them down so all six line up at the listener
function calcCal() {
	const k = room.units === "m" ? 1 : FT;
	const lx = room.listener[0] * k;
	const ly = room.listener[1] * k;
	const c = room.speed_of_sound || 343;
	const d = speakers.map(p => Math.max(0.3, Math.hypot(p[0] - lx, p[1] - ly)));
	const dmax = Math.max(...d);
	cal = d.map((di, i) => {
		const adj = room.adjust[i + 1] || {};
		return {
			dist_m: di,
			delay_ms: Math.max(0, (dmax - di) / c * 1000 + (adj.delay_ms || 0)),
			gain_db: 20 * Math.log10(di / dmax) + (adj.gain_db || 0)
		};
	});
}

function round(v, places) {
	const m = Math.pow(10, places);
	return Math.round(v * m) / m;
}

function dump() { publish(); }

// ---- internals ----

function edit(id, fn) {
	const s = sources[id];
	if (!s) {
		error("dbap: no source " + id + "\n");
		return;
	}
	fn(s);
	writeSource(s);
	publish();
}

function writeSource(s) {
	const r = s.rotation * Math.PI / 180;
	const c = Math.cos(r);
	const sn = Math.sin(r);
	const lvl = s.enabled ? s.level : 0;
	for (const p of s.points) {
		const idx = p.ch - 1;
		if (idx < 0 || idx >= NPTS) continue;
		const ox = p.offset[0] * s.width;
		const oy = p.offset[1] * s.width;
		const px = s.x + ox * c - oy * sn;
		const py = s.y + ox * sn + oy * c;
		writePoint(idx, px, py, lvl * (p.gain ?? 1), s.slew, s.blur);
	}
}

function writePoint(idx, x, y, lvl, sl, bl) {
	pts.poke(1, idx, x);
	pts.poke(2, idx, y);
	pts.poke(3, idx, lvl);
	pts.poke(4, idx, sl);
	pts.poke(5, idx, bl);
}

function writeSpeakers() {
	for (let i = 0; i < NSPK; i++) {
		spkbuf.poke(1, i, speakers[i][0]);
		spkbuf.poke(2, i, speakers[i][1]);
		spkbuf.poke(3, i, calOn ? cal[i].delay_ms : 0);
		spkbuf.poke(4, i, calOn ? Math.pow(10, cal[i].gain_db / 20) : 1);
	}
}

function publish() {
	const k = room.units === "m" ? 1 : FT;
	const sc = scenes[sceneName] || {};
	stateDict.parse(JSON.stringify({
		scene: sceneName,
		sceneCount,
		keys: sc.keys || [],
		sticks: sc.sticks || {},
		sources,
		speakers: speakers.map((p, i) => ({
			n: i + 1,
			label: room.speakers[i + 1].label,
			x: p[0], y: p[1],
			delay_ms: cal[i].delay_ms,
			gain_db: cal[i].gain_db
		})),
		room: {
			units: room.units,
			calibrate: calOn,
			listener: [room.listener[0] * k, room.listener[1] * k],
			operator: [room.operator[0] * k, room.operator[1] * k]
		}
	}));
	outlet(0, "dictionary", "dbap_state");
}