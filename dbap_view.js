// dbap_view.js  (for a [v8ui dbap_view.js] object)
//
// Room view for the panner. The stage end is at the top.
//   speakers, sources coloured by unit (1-8), the calibration position (+),
//   a halo showing each unit's spread, the range preview
//   while the range knob moves, and recorded loop paths in loop mode.
//
// The strips left of the left speakers and right of the right speakers are
// see-through, so meter~ objects placed behind the v8ui show through
// (send the meters to the back with Arrange > Send to Back).
//
// Inlet:
//   dictionary dbap_state | dbap_behave | dbap_loops
//
// Mouse:
//   GLIDE/CUT box              same as TAB
//   mode box                   same as its number key
//   unit box                   toggle (M); shift-click: home (R)
//   drag a unit in the room    manual: move its home position
//                              loop: record a path, loops on release
//                              (in assign mode, by each unit's behaviour)
//   shift-click a unit in the room (loop / assign): clear its loop
//
// Outlet: key <ascii>, toggle <n>, home <n>, drag <n> <x> <y>, dragend <n>,
//         clearloop <n>  -> dbap_behave.js

autowatch = 1;
inlets = 1;
outlets = 1;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

const C_BG = [0.11, 0.11, 0.12, 1];
const C_SEE = [0.11, 0.11, 0.12, 0.25];   // see-through side strips
const C_PANEL = [0.16, 0.16, 0.18, 1];
const C_ROOM = [0.14, 0.14, 0.16, 1];
const C_LINE = [0.35, 0.35, 0.38, 1];
const C_TEXT = [0.85, 0.85, 0.85, 1];
const C_DIM = [0.5, 0.5, 0.52, 1];
const C_LIT = [0.95, 0.35, 0.2, 1];
const C_BLUE = [0.45, 0.75, 1.0, 1];
const C_SPK = [0.3, 0.3, 0.32, 1];
const NUNITS = 8;
const UNIT_COLS = [
	[0.95, 0.45, 0.35, 1], [0.95, 0.75, 0.3, 1], [0.6, 0.85, 0.35, 1],
	[0.3, 0.8, 0.7, 1], [0.4, 0.65, 1.0, 1], [0.65, 0.5, 1.0, 1],
	[0.95, 0.5, 0.8, 1], [0.85, 0.85, 0.85, 1]
];

const HEAD = 34, MODES = 30, UNITS = 40, PAD = 10;
const SIDE_M = 1.2;    // metres of see-through margin beside the speakers (for meters)
const END_M = 0.5;     // metres of margin above and below the room

let st = null;      // dbap_state
let bh = null;      // dbap_behave
let loops = {};     // unit n -> [[x, y], ...]
let hits = [];      // clickable boxes from the last paint
let map = null;     // metres <-> pixels, from the last paint
let dragUnit = 0;

function dictionary(name) {
	if (name !== "dbap_state" && name !== "dbap_behave" && name !== "dbap_loops") {
		post("dbap_view: ignoring dictionary " + name + "\n");
		return;
	}
	const o = JSON.parse(new Dict(name).stringify());
	if (name === "dbap_state") st = o;
	else if (name === "dbap_behave") bh = o;
	else loops = o.loops || {};
	mgraphics.redraw();
}

// ---- helpers ----

function setc(c, alpha) {
	mgraphics.set_source_rgba(c[0], c[1], c[2], alpha === undefined ? c[3] : alpha);
}

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

function fillRect(x, y, w, h, c) {
	setc(c);
	mgraphics.rectangle(x, y, w, h);
	mgraphics.fill();
}

function toArr(v) {
	if (v === undefined || v === null) return [];
	return Array.isArray(v) ? v : [v];
}

function num(v, d) { return typeof v === "number" ? v : d; }
function strv(v) { return v === undefined || v === null ? "" : String(v); }
function pretty(id) { return String(id).replace(/_/g, " "); }

function unitCol(n) { return UNIT_COLS[n - 1] || C_DIM; }

// ---- paint ----

function paint() {
	const W = mgraphics.size[0], H = mgraphics.size[1];
	hits = [];
	mgraphics.select_font_face("Arial");

	if (!st) {
		fillRect(0, 0, W, H, C_BG);
		text("waiting for dbap_state", W / 2, H / 2, 14, C_DIM, "c");
		return;
	}

	const mapTop = HEAD + PAD / 2, mapBot = H - MODES - UNITS - PAD;
	const spk = toArr(st.speakers);
	layout(PAD, mapTop, W - PAD * 2, mapBot - mapTop, spk);

	// background: solid everywhere except the strips beside the speakers
	if (map) {
		const L = map.P(map.room.x0, 0)[0] - 16, R = map.P(map.room.x1, 0)[0] + 16;
		fillRect(0, 0, W, mapTop, C_BG);
		fillRect(0, mapBot, W, H - mapBot, C_BG);
		fillRect(L, mapTop, R - L, mapBot - mapTop, C_BG);
		fillRect(0, mapTop, Math.max(0, L), mapBot - mapTop, C_SEE);
		fillRect(R, mapTop, Math.max(0, W - R), mapBot - mapTop, C_SEE);
	} else {
		fillRect(0, 0, W, H, C_BG);
	}

	drawHeader(W);
	if (map) drawMap(spk);
	drawModes(PAD, H - MODES - UNITS - PAD / 2, W - PAD * 2, MODES - 4);
	drawUnits(PAD, H - UNITS - PAD / 2, W - PAD * 2, UNITS - 4);
}

function layout(x, y, w, h, spk) {
	if (!spk.length) { map = null; return; }
	const xs = spk.map(s => s.x), ys = spk.map(s => s.y);
	const room = { x0: Math.min(...xs), x1: Math.max(...xs), y0: Math.min(...ys), y1: Math.max(...ys) };
	const wx0 = room.x0 - SIDE_M, wx1 = room.x1 + SIDE_M, wy0 = room.y0 - END_M, wy1 = room.y1 + END_M;
	const s = Math.min(w / (wx1 - wx0), h / (wy1 - wy0));
	const ox = x + (w - (wx1 - wx0) * s) / 2, oy = y + (h - (wy1 - wy0) * s) / 2;
	map = {
		room, s,
		P: (px, py) => [ox + (px - wx0) * s, oy + (wy1 - py) * s],
		M: (qx, qy) => [wx0 + (qx - ox) / s, wy1 - (qy - oy) / s]
	};
}

function drawHeader(W) {
	const h = HEAD;
	rrect(4, 4, W - 8, h - 6, 5, C_PANEL);
	text("SCENE", 14, 15, 9, C_DIM);
	text(pretty(st.scene || "-").toUpperCase(), 14, 29, 13, C_TEXT);
	if (!bh) return;
	text("MODE", 150, 15, 9, C_DIM);
	text((strv(bh.modeKey) + "  " + strv(bh.mode)).toUpperCase(), 150, 29, 13, C_TEXT);
	if (bh.mode === "manual") text("drag units to place them", 290, 29, 10, C_DIM);
	if (bh.mode === "loop") text("drag a unit to record its loop - shift-click clears", 290, 29, 10, C_DIM);
	if (bh.mode === "assign") text("S selects units, then a number key assigns a behaviour", 290, 29, 10, C_DIM);

	const bw = 120, bx = W - bw - 10, by = 8, bhh = h - 14;
	const g = bh.glide;
	rrect(bx, by, bw, bhh, 4, g ? C_BLUE : C_LIT);
	text(g ? "GLIDE " + num(bh.glideTime, 0).toFixed(1) + "s" : "CUT", bx + bw / 2, by + bhh / 2 + 5, 12, C_BG, "c");
	text("TAB", bx - 8, by + bhh / 2 + 4, 9, C_DIM, "r");
	hits.push({ x: bx, y: by, w: bw, h: bhh, key: 9 });
	text("SPEED x" + num(bh.speed, 1).toFixed(2), bx - 40, 29, 11, C_DIM, "r");
}

function drawMap(spk) {
	const { room, s, P } = map;

	// room
	const r0 = P(room.x0, room.y1), r1 = P(room.x1, room.y0);
	fillRect(r0[0], r0[1], r1[0] - r0[0], r1[1] - r0[1], C_ROOM);
	setc(C_LINE);
	mgraphics.set_line_width(1);
	mgraphics.rectangle(r0[0], r0[1], r1[0] - r0[0], r1[1] - r0[1]);
	mgraphics.stroke();
	text("stage", (r0[0] + r1[0]) / 2, r0[1] - 4, 9, C_DIM, "c");

	// speakers
	spk.forEach(sp => {
		const p = P(sp.x, sp.y);
		const sz = 22;
		rrect(p[0] - sz / 2, p[1] - sz / 2, sz, sz, 3, C_SPK);
		text(sp.label || String(sp.n), p[0], p[1] + 4, 9, C_TEXT, "c");
	});

	// calibration position
	if (st.room) {
		const L = P(toArr(st.room.listener)[0], toArr(st.room.listener)[1]);
		setc(C_DIM);
		mgraphics.set_line_width(1.5);
		mgraphics.move_to(L[0] - 7, L[1]); mgraphics.line_to(L[0] + 7, L[1]);
		mgraphics.move_to(L[0], L[1] - 7); mgraphics.line_to(L[0], L[1] + 7);
		mgraphics.stroke();
	}

	const unitOfSrc = {}, unitInfo = {};
	if (bh) for (const u of toArr(bh.units)) {
		unitInfo[u.n] = u;
		for (const m of toArr(u.members)) unitOfSrc[m] = u.n;
	}

	// loop paths (loop mode, or units assigned to loop)
	if (bh && (bh.mode === "loop" || bh.mode === "assign")) {
		for (const n of Object.keys(loops)) {
			if (bh.mode === "assign" && !(unitInfo[n] && unitInfo[n].beh === "loop")) continue;
			const pts = toArr(loops[n]);
			if (pts.length < 2) continue;
			setc(unitCol(+n), 0.35);
			mgraphics.set_line_width(1.5);
			const a = P(pts[0][0], pts[0][1]);
			mgraphics.move_to(a[0], a[1]);
			for (const q of pts.slice(1)) {
				const b = P(q[0], q[1]);
				mgraphics.line_to(b[0], b[1]);
			}
			mgraphics.close_path();
			mgraphics.stroke();
		}
	}

	// range preview: home, where the movement would be at 100%, and where it is
	for (const n of Object.keys(unitInfo)) {
		const u = unitInfo[n];
		if (!u.showRange && !(u.beh === "manual" && u.dragging)) continue;
		const col = unitCol(u.n);
		const h = P(toArr(u.home)[0], toArr(u.home)[1]);
		const g = P(toArr(u.ghost)[0], toArr(u.ghost)[1]);
		setc(col, 0.8);
		mgraphics.set_line_width(1.5);
		mgraphics.move_to(h[0] - 6, h[1] - 6); mgraphics.line_to(h[0] + 6, h[1] + 6);
		mgraphics.move_to(h[0] - 6, h[1] + 6); mgraphics.line_to(h[0] + 6, h[1] - 6);
		mgraphics.stroke();
		if (u.showRange) {
			setc(col, 0.35);
			mgraphics.move_to(h[0], h[1]);
			mgraphics.line_to(g[0], g[1]);
			mgraphics.stroke();
			mgraphics.arc(g[0], g[1], 7, 0, Math.PI * 2);
			mgraphics.stroke();
			const pct = Math.round(num(u.range, 1) * 100) + "%";
			text("range " + pct, g[0] + 10, g[1] + 4, 9, col);
		}
	}

	// sources
	for (const id of Object.keys(st.sources || {})) {
		const src = st.sources[id];
		if (!src.enabled) continue;
		const n = unitOfSrc[id];
		const col = n ? unitCol(n) : C_DIM;
		const frozen = n && unitInfo[n] && !unitInfo[n].active;
		const pts = pointsOf(src).map(q => P(q[0], q[1]));

		// spread halo: radius = the spatial blur
		const blur = num(src.blur, 0.01);
		if (blur > 0.05) {
			for (const q of pts) {
				setc(col, 0.12);
				mgraphics.arc(q[0], q[1], blur * s, 0, Math.PI * 2);
				mgraphics.fill();
				setc(col, 0.35);
				mgraphics.set_line_width(1);
				mgraphics.arc(q[0], q[1], blur * s, 0, Math.PI * 2);
				mgraphics.stroke();
			}
		}

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
	const bw = w / Math.max(1, ms.length);
	ms.forEach((m, i) => {
		const key = strv(m.key), name = strv(m.name);
		if (!key) return;
		const bx = x + i * bw + 2;
		const on = name === bh.mode;
		rrect(bx, y, bw - 4, h, 4, on ? C_LIT : C_PANEL);
		text(key, bx + 6, y + h / 2 + 4, 10, on ? C_BG : C_DIM);
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
		const col = unitCol(n);
		rrect(bx, y, bw - 4, h, 4, C_PANEL);
		if (!u) {
			text("" + n, bx + 6, y + 15, 11, C_SPK);
			continue;
		}
		// active: full border; frozen: just the bar on the left
		if (u.active) {
			setc(col);
			mgraphics.set_line_width(1.5);
			mgraphics.rectangle_rounded(bx + 1, y + 1, bw - 6, h - 2, 4, 4);
			mgraphics.stroke();
		} else {
			rrect(bx, y, 5, h, 2, col);
		}
		text("" + n, bx + 10, y + 15, 12, col);
		let tag = u.active ? "moving" : "frozen";
		if (bh.mode === "assign") tag = (u.selected ? "SELECTED" : strv(u.assign)) + " - " + tag;
		else if (u.hasLoop) tag += " - loop";
		text(fit(tag, 9, bw - 30), bx + 24, y + 15, 9, u.selected ? C_LIT : C_DIM);
		text(fit(pretty(u.id), 10, bw - 16), bx + 10, y + h - 7, 10, C_TEXT);
		hits.push({ x: bx, y, w: bw - 4, h, unit: n });
	}
}

// ---- mouse ----

function unitAt(qx, qy) {
	if (!map || !bh || !st) return 0;
	let best = 0, bestD = 18;   // pixels
	for (const u of toArr(bh.units)) {
		const ms = toArr(u.members).map(m => st.sources[m]).filter(Boolean);
		if (!ms.length) continue;
		const cx = ms.reduce((t, s) => t + s.x, 0) / ms.length;
		const cy = ms.reduce((t, s) => t + s.y, 0) / ms.length;
		const p = map.P(cx, cy);
		const d = Math.hypot(p[0] - qx, p[1] - qy);
		if (d < bestD) { bestD = d; best = u.n; }
	}
	return best;
}

function onclick(x, y, but, cmd, shift) {
	for (const b of hits) {
		if (x >= b.x && x <= b.x + b.w && y >= b.y && y <= b.y + b.h) {
			if (b.unit) outlet(0, shift ? "home" : "toggle", b.unit);
			else outlet(0, "key", b.key);
			return;
		}
	}
	if (!bh || ["manual", "loop", "assign"].indexOf(bh.mode) < 0) return;
	const n = unitAt(x, y);
	if (!n) return;
	if (shift && (bh.mode === "loop" || bh.mode === "assign")) {
		outlet(0, "clearloop", n);
		return;
	}
	dragUnit = n;
	const m = map.M(x, y);
	outlet(0, "drag", n, m[0], m[1]);
}

function ondrag(x, y, but) {
	if (!dragUnit) return;
	if (!but) {
		outlet(0, "dragend", dragUnit);
		dragUnit = 0;
		return;
	}
	const m = map.M(x, y);
	outlet(0, "drag", dragUnit, m[0], m[1]);
}

function onresize() {
	mgraphics.redraw();
}