// dbap_view.js  (for a [v8ui dbap_view.js] object)
//
// Room view for the panner: speakers with output meters, sources coloured by
// key (1-9), frozen units hollow, the calibration position (+) and the
// operator (OP), plus the mode, the glide/cut setting and the sticks.
// Stage is at the top.
//
// Inlet:
//   dictionary dbap_state      from dbap_control.js
//   dictionary dbap_behave     from dbap_behave.js outlet 2
//   meters <6 amplitudes>      FL FR SL SR BL BR, linear (e.g. from peakamp~)
//
// Mouse (all optional, everything is on the keyboard and nanoKONTROL2 too):
//   click GLIDE/CUT            same as TAB
//   click a mode box           same as its number key
//   click a unit box           toggle it (M); shift-click sends it home (R)
//
// Outlet: "key <ascii>", "toggle <n>", "home <n>" to dbap_behave.js

autowatch = 1;
inlets = 1;
outlets = 1;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

const C_BG = [0.11, 0.11, 0.12, 1];
const C_PANEL = [0.16, 0.16, 0.18, 1];
const C_ROOM = [0.14, 0.14, 0.16, 1];
const C_LINE = [0.35, 0.35, 0.38, 1];
const C_TEXT = [0.85, 0.85, 0.85, 1];
const C_DIM = [0.5, 0.5, 0.52, 1];
const C_LIT = [0.95, 0.35, 0.2, 1];
const C_METER = [0.45, 0.75, 1.0, 1];
const C_OFF = [0.3, 0.3, 0.32, 1];
const NUNITS = 8;
const UNIT_COLS = [
	[0.95, 0.45, 0.35, 1], [0.95, 0.75, 0.3, 1], [0.6, 0.85, 0.35, 1],
	[0.3, 0.8, 0.7, 1], [0.4, 0.65, 1.0, 1], [0.65, 0.5, 1.0, 1],
	[0.95, 0.5, 0.8, 1], [0.85, 0.85, 0.85, 1]
];

let st = null;      // dbap_state
let bh = null;      // dbap_behave
let lv = [0, 0, 0, 0, 0, 0];
let hits = [];      // clickable boxes from the last paint

function dictionary(name) {
	if (name !== "dbap_state" && name !== "dbap_behave") {
		post("dbap_view: ignoring dictionary " + name + "\n");
		return;
	}
	const o = JSON.parse(new Dict(name).stringify());
	if (name === "dbap_state") st = o;
	else bh = o;
	mgraphics.redraw();
}

function num(v, d) { return typeof v === "number" ? v : d; }
function strv(v) { return v === undefined || v === null ? "" : String(v); }

function meters() {
	const a = arrayfromargs(arguments);
	for (let i = 0; i < 6; i++) lv[i] = a[i] || 0;
	mgraphics.redraw();
}

// ---- drawing helpers ----

function setc(c) { mgraphics.set_source_rgba(c[0], c[1], c[2], c[3]); }

function text(s, x, y, size, c, align) {
	if (!s) return;
	mgraphics.set_font_size(size);
	const w = mgraphics.text_measure(s)[0];
	setc(c);
	mgraphics.move_to(align === "c" ? x - w / 2 : (align === "r" ? x - w : x), y);
	mgraphics.show_text(s);
}

function fit(s, size, maxw) {
	mgraphics.set_font_size(size);
	while (s.length > 1 && mgraphics.text_measure(s)[0] > maxw) s = s.slice(0, -1);
	return s;
}

function rrect(x, y, w, h, r, c) {
	setc(c);
	mgraphics.rectangle_rounded(x, y, w, h, r, r);
	mgraphics.fill();
}

function toArr(v) {
	if (v === undefined || v === null) return [];
	return Array.isArray(v) ? v : [v];
}

function pretty(id) { return String(id).replace(/_/g, " "); }

// ---- paint ----

function paint() {
	const W = mgraphics.size[0], H = mgraphics.size[1];
	hits = [];
	mgraphics.select_font_face("Arial");
	setc(C_BG);
	mgraphics.rectangle(0, 0, W, H);
	mgraphics.fill();

	if (!st) {
		text("waiting for dbap_state", W / 2, H / 2, 14, C_DIM, "c");
		return;
	}

	const HEAD = 34, MODES = 30, UNITS = 40, PAD = 10;
	drawHeader(W, HEAD);
	const mapTop = HEAD + PAD, mapBot = H - MODES - UNITS - PAD * 2;
	drawMap(PAD, mapTop, W - PAD * 2, mapBot - mapTop);
	drawModes(PAD, H - MODES - UNITS - PAD, W - PAD * 2, MODES - 4);
	drawUnits(PAD, H - UNITS - PAD / 2, W - PAD * 2, UNITS - 4);
}

function drawHeader(W, h) {
	rrect(4, 4, W - 8, h - 6, 5, C_PANEL);
	text("SCENE", 14, 15, 9, C_DIM);
	text(pretty(st.scene || "-").toUpperCase(), 14, 29, 13, C_TEXT);
	if (!bh) return;
	text("MODE", 150, 15, 9, C_DIM);
	text((strv(bh.modeKey) + "  " + strv(bh.mode)).toUpperCase(), 150, 29, 13, C_TEXT);

	// glide / cut toggle
	const bw = 120, bx = W - bw - 10, by = 8, bhh = h - 14;
	const g = bh.glide;
	rrect(bx, by, bw, bhh, 4, g ? C_METER : C_LIT);
	const label = g ? "GLIDE " + num(bh.glideTime, 0).toFixed(1) + "s" : "CUT";
	text(label, bx + bw / 2, by + bhh / 2 + 5, 12, C_BG, "c");
	text("TAB", bx - 8, by + bhh / 2 + 4, 9, C_DIM, "r");
	hits.push({ x: bx, y: by, w: bw, h: bhh, key: 9 });

	text("SPEED x" + num(bh.speed, 1).toFixed(2), bx - 40, 29, 11, C_DIM, "r");
}

function drawMap(x, y, w, h) {
	const spk = toArr(st.speakers);
	if (!spk.length) return;
	const xs = spk.map(s => s.x), ys = spk.map(s => s.y);
	const room = { x0: Math.min(...xs), x1: Math.max(...xs), y0: Math.min(...ys), y1: Math.max(...ys) };
	const M = 0.6, STAGE = 1.2;
	const wx0 = room.x0 - M, wx1 = room.x1 + M, wy0 = room.y0 - M, wy1 = room.y1 + M + STAGE;
	const s = Math.min(w / (wx1 - wx0), h / (wy1 - wy0));
	const ox = x + (w - (wx1 - wx0) * s) / 2, oy = y + (h - (wy1 - wy0) * s) / 2;
	const P = (px, py) => [ox + (px - wx0) * s, oy + (wy1 - py) * s];

	// stage
	const s0 = P(room.x0, room.y1 + M + STAGE), s1 = P(room.x1, room.y1 + M * 0.5);
	rrect(s0[0], s0[1], s1[0] - s0[0], s1[1] - s0[1], 4, C_PANEL);
	text("STAGE", (s0[0] + s1[0]) / 2, (s0[1] + s1[1]) / 2 + 5, 12, C_DIM, "c");

	// room
	const r0 = P(room.x0, room.y1), r1 = P(room.x1, room.y0);
	setc(C_ROOM);
	mgraphics.rectangle(r0[0], r0[1], r1[0] - r0[0], r1[1] - r0[1]);
	mgraphics.fill();
	setc(C_LINE);
	mgraphics.set_line_width(1);
	mgraphics.rectangle(r0[0], r0[1], r1[0] - r0[0], r1[1] - r0[1]);
	mgraphics.stroke();

	// speakers + meters
	spk.forEach((sp, i) => {
		const p = P(sp.x, sp.y);
		const db = lv[i] > 0 ? 20 * Math.log10(lv[i]) : -100;
		const k = Math.max(0, Math.min(1, (db + 60) / 60));
		const sz = 26;
		rrect(p[0] - sz / 2, p[1] - sz / 2, sz, sz, 3, C_OFF);
		if (k > 0) rrect(p[0] - sz / 2, p[1] + sz / 2 - sz * k, sz, sz * k, 3, C_METER);
		text(sp.label || String(sp.n), p[0], p[1] + sz / 2 + 13, 10, C_TEXT, "c");
	});

	// calibration position and operator
	if (st.room) {
		const L = P(st.room.listener[0], st.room.listener[1]);
		setc(C_DIM);
		mgraphics.set_line_width(1.5);
		mgraphics.move_to(L[0] - 7, L[1]); mgraphics.line_to(L[0] + 7, L[1]);
		mgraphics.move_to(L[0], L[1] - 7); mgraphics.line_to(L[0], L[1] + 7);
		mgraphics.stroke();
		const O = P(st.room.operator[0], st.room.operator[1]);
		mgraphics.arc(O[0], O[1], 9, 0, Math.PI * 2);
		mgraphics.stroke();
		text("OP", O[0], O[1] + 3.5, 8, C_DIM, "c");
	}

	// which unit each source belongs to
	const unitOfSrc = {}, unitInfo = {};
	if (bh) for (const u of toArr(bh.units)) {
		unitInfo[u.n] = u;
		for (const m of toArr(u.members)) unitOfSrc[m] = u.n;
	}

	// sources
	for (const id of Object.keys(st.sources || {})) {
		const src = st.sources[id];
		if (!src.enabled) continue;
		const n = unitOfSrc[id];
		const col = n && UNIT_COLS[n - 1] ? UNIT_COLS[n - 1] : C_DIM;
		const frozen = n && unitInfo[n] && !unitInfo[n].active;
		const pts = pointsOf(src).map(q => P(q[0], q[1]));
		setc(col);
		mgraphics.set_line_width(1.5);
		if (pts.length > 1) {
			mgraphics.move_to(pts[0][0], pts[0][1]);
			for (const q of pts.slice(1)) mgraphics.line_to(q[0], q[1]);
			mgraphics.stroke();
		}
		for (const q of pts) {
			mgraphics.arc(q[0], q[1], src.acoustic ? 7 : 6, 0, Math.PI * 2);
			if (frozen) mgraphics.stroke();
			else mgraphics.fill();
		}
		const c = P(src.x, src.y);
		text((n ? n + " " : "") + pretty(id), c[0] + 10, c[1] - 8, 10, col);
	}

	// sticks, in gamepad mode
	if (bh && bh.mode === "gamepad" && bh.sticks) {
		const R = 26;
		[["L", toArr(bh.sticks.L)], ["R", toArr(bh.sticks.R)]].forEach(([nm, v], j) => {
			const cx = x + w - (j === 0 ? 3.4 : 1.2) * R - 6, cy = y + h - R - 6;
			setc(C_LINE);
			mgraphics.set_line_width(1);
			mgraphics.arc(cx, cy, R, 0, Math.PI * 2);
			mgraphics.stroke();
			setc(C_METER);
			mgraphics.arc(cx + num(v[0], 0) * R, cy - num(v[1], 0) * R, 4, 0, Math.PI * 2);
			mgraphics.fill();
			text(nm, cx, cy - R - 4, 9, C_DIM, "c");
		});
	}
}

// same geometry as dbap_control.js writeSource()
function pointsOf(s) {
	const r = (s.rotation || 0) * Math.PI / 180;
	const c = Math.cos(r), sn = Math.sin(r);
	const w = s.width === undefined ? 1 : s.width;
	return toArr(s.points).map(p => {
		const off = toArr(p.offset);
		const ox = (off[0] || 0) * w, oy = (off[1] || 0) * w;
		return [s.x + ox * c - oy * sn, s.y + ox * sn + oy * c];
	});
}

function drawModes(x, y, w, h) {
	if (!bh) return;
	const ms = toArr(bh.modes);
	const bw = w / ms.length;
	ms.forEach((m, i) => {
		const bx = x + i * bw + 2;
		const key = strv(m.key), name = strv(m.name);
		if (!key) return;
		const on = name === bh.mode;
		rrect(bx, y, bw - 4, h, 4, on ? C_LIT : C_PANEL);
		text(key.toUpperCase(), bx + 6, y + h / 2 + 4, 10, on ? C_BG : C_DIM);
		text(fit(name, 10, bw - 24), bx + 18, y + h / 2 + 4, 10, on ? C_BG : C_TEXT);
		hits.push({ x: bx, y, w: bw - 4, h, key: key.charCodeAt(0) });
	});
}

function drawUnits(x, y, w, h) {
	if (!bh) return;
	const bw = w / NUNITS;
	const us = {};
	for (const u of toArr(bh.units)) us[u.n] = u;
	for (let n = 1; n <= NUNITS; n++) {
		const u = us[n];
		const bx = x + (n - 1) * bw + 2;
		const col = UNIT_COLS[n - 1];
		rrect(bx, y, bw - 4, h, 4, C_PANEL);
		if (!u) {
			text("" + n, bx + 6, y + 15, 11, C_OFF);
			continue;
		}
		if (u.active) {
			rrect(bx, y, 5, h, 2, col);
		} else {
			setc(col);
			mgraphics.set_line_width(1.5);
			mgraphics.rectangle_rounded(bx + 1, y + 1, bw - 6, h - 2, 4, 4);
			mgraphics.stroke();
		}
		text("" + n, bx + 10, y + 15, 12, col);
		text(u.active ? (u.stick ? "stick " + u.stick : "active") : "frozen", bx + 24, y + 15, 9, C_DIM);
		text(fit(pretty(u.id), 10, bw - 16), bx + 10, y + h - 7, 10, C_TEXT);
		hits.push({ x: bx, y, w: bw - 4, h, unit: n });
	}
}

// ---- mouse ----

function onclick(x, y, but, cmd, shift) {
	for (const b of hits) {
		if (x >= b.x && x <= b.x + b.w && y >= b.y && y <= b.y + b.h) {
			if (b.unit) outlet(0, shift ? "home" : "toggle", b.unit);
			else outlet(0, "key", b.key);
			return;
		}
	}
}

function onresize() {
	mgraphics.redraw();
}