// dbap_nk.js  (for a [v8 dbap_nk.js] object)
//
// nanoKONTROL2 for the panner: faders set unit levels, two knobs set behaviour
// speed and glide time. No mutes: a fader's bottom is -30 dB, not off.
// Uses the same pickup as nanoKontrolModes.js: a fader or knob does nothing
// until it reaches or passes the current value.
//
// Drives nk_screen.js unchanged (same message format).
//
// Inlet:
//   <value> <cc>             from [ctlin] (value and CC packed, as in your looper patch)
//   screen <value> <cc>      from nk_screen.js (mouse; sets values directly, no pickup)
//   unit <n> <name> <dB>     from dbap_behave.js outlet 1 (one per key 1-9)
//   unitsdone                from dbap_behave.js, after a scene change
//
// Controls (same CC layout as your looper setup: faders 0-7, knobs 8-15):
//   faders 1-8   unit levels, -30 dB to +6 dB (unity at about 5/6 of the way up)
//   knob 1       behaviour speed, x1/4 to x4 (centre x1)
//   knob 2       glide time, 0.2 s to 10 s
//   TRACK < >    fader page: units 1-8 / unit 9
//
// Outlets:
//   0  to dbap_behave.js: unitlevel <n> <dB>, speed <mult>, glidetime <s>
//   1  to nk_screen.js

autowatch = 1;
inlets = 1;
outlets = 2;

const N = 8;
const KNOB0 = 8;
const PICK = 0.03;
const TRACK_L = 58, TRACK_R = 59;
const DB_LO = -30, DB_HI = 6;

let page = 0;
const names = ["", "", "", "", "", "", "", "", ""];
const lvl = new Array(9).fill(posOfDb(0));    // unit levels as fader positions 0-1
const fPos = new Array(N).fill(-1);
const fPicked = new Array(N).fill(0);

// knob 1 speed, knob 2 glide time
const kVal = [0.5, glideNorm(2)];
const kPos = [-1, -1];
const kPicked = [0, 0];

function loadbang() {
	sendKnob(0);
	sendKnob(1);
	display();
}

// ---- from dbap_behave ----

function unit(n, name, db) {
	if (n < 1 || n > 9) return;
	names[n - 1] = name === "-" ? "" : String(name);
	lvl[n - 1] = posOfDb(db);
}

function unitsdone() {
	for (let i = 0; i < N; i++) fPicked[i] = 0;
	display();
}

// ---- controller ----

function list(v, cc) {
	if (v === undefined || cc === undefined) return;
	if (cc >= 0 && cc < N) { hwFader(cc, v / 127); return; }
	const k = cc - KNOB0;
	if (k === 0 || k === 1) { hwKnob(k, v / 127); return; }
	if ((cc === TRACK_L || cc === TRACK_R) && v > 0) {
		const p = cc === TRACK_L ? 0 : 1;
		if (p !== page) {
			page = p;
			for (let i = 0; i < N; i++) fPicked[i] = 0;
		}
		display();
	}
}

function screen(v, cc) {
	if (v === undefined || cc === undefined) return;
	if (cc >= 0 && cc < N) {
		const u = unitIndex(cc);
		if (u < 0) return;
		setLevel(u, v / 127);
		fPicked[cc] = 0;
		display();
		return;
	}
	const k = cc - KNOB0;
	if (k === 0 || k === 1) {
		kVal[k] = Math.max(0, Math.min(1, v / 127));
		kPicked[k] = 0;
		sendKnob(k);
		display();
		return;
	}
	list(v, cc);
}

function hwFader(n, pos) {
	const prev = fPos[n];
	fPos[n] = pos;
	const u = unitIndex(n);
	if (u >= 0) {
		if (!fPicked[n]) {
			const cur = lvl[u];
			const crossed = prev >= 0 && (prev - cur) * (pos - cur) <= 0;
			if (crossed || Math.abs(pos - cur) <= PICK) fPicked[n] = 1;
		}
		if (fPicked[n]) setLevel(u, pos);
	}
	display();
}

function hwKnob(k, pos) {
	const prev = kPos[k];
	kPos[k] = pos;
	if (!kPicked[k]) {
		const cur = kVal[k];
		const crossed = prev >= 0 && (prev - cur) * (pos - cur) <= 0;
		if (crossed || Math.abs(pos - cur) <= PICK) kPicked[k] = 1;
	}
	if (kPicked[k]) {
		kVal[k] = pos;
		sendKnob(k);
	}
	display();
}

function setLevel(u, pos) {
	lvl[u] = Math.max(0, Math.min(1, pos));
	outlet(0, "unitlevel", u + 1, Math.round(dbOf(lvl[u]) * 10) / 10);
}

function sendKnob(k) {
	if (k === 0) outlet(0, "speed", speedOf(kVal[0]));
	else outlet(0, "glidetime", glideOf(kVal[1]));
}

// fader n on the current page -> unit index 0-8, or -1 if none
function unitIndex(n) {
	const u = page * N + n;
	return u < 9 && names[u] ? u : -1;
}

// ---- scaling ----

function dbOf(p) { return DB_LO + Math.max(0, Math.min(1, p)) * (DB_HI - DB_LO); }
function posOfDb(db) { return (Math.max(DB_LO, Math.min(DB_HI, db)) - DB_LO) / (DB_HI - DB_LO); }
function speedOf(v) { return Math.pow(2, v * 4 - 2); }
function glideOf(v) { return 0.2 * Math.pow(50, v); }
function glideNorm(s) { return Math.log(s / 0.2) / Math.log(50); }

// ---- screen ----

function display() {
	for (let n = 0; n < N; n++) {
		const u = unitIndex(n);
		if (u < 0) {
			outlet(1, "fader", n, -1, fPos[n], "-", "");
		} else {
			const db = dbOf(lvl[u]);
			const txt = (db > 0.05 ? "+" : "") + db.toFixed(1) + "dB";
			outlet(1, "fader", n, lvl[u], fPos[n], (u + 1) + "_" + names[u], txt);
		}
	}
	outlet(1, "knob", 0, kVal[0], kPos[0], "speed", "x" + speedOf(kVal[0]).toFixed(2), -1, 0);
	outlet(1, "knob", 1, kVal[1], kPos[1], "glide", glideOf(kVal[1]).toFixed(1) + "s", -1, 0);
	for (let k = 2; k < N; k++) outlet(1, "knob", k, -1, -1, "-", "", -1, 0);
	outlet(1, "btn", TRACK_L, "units_1-8");
	outlet(1, "btn", TRACK_R, "unit_9");
	// light the current page's button on the screen (an LED message: value cc)
	outlet(1, page === 0 ? 127 : 0, TRACK_L);
	outlet(1, page === 1 ? 127 : 0, TRACK_R);
	outlet(1, "mode", "panner levels");
}
