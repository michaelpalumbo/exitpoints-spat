// dbap_view.js  (for a [v8ui dbap_view.js] object)
//
// Room view for the panner. The stage end is at the top. Top to bottom: the
// room, the mode buttons, the header (scene, mode, description, line-up
// button, glide/cut), the unit boxes.
//   speakers, sources coloured by unit (1-8), the calibration position (+),
//   a halo showing each unit's spread, the range preview
//   while the range knob moves, and recorded loop paths in loop mode.
//
// The background is solid black. "seethrough 1" makes the strips left and
// right of the speakers see-through, for meter~ objects placed behind the v8ui.
//
// Inlet:
//   dictionary dbap_state | dbap_behave | dbap_loops
//   seethrough <0|1>     side strips see-through (1) or solid black (0, default)
//
// Mouse:
//   GLIDE/CUT box              same as TAB
//   mode box                   same as its number key
//   unit box                   only while editing a line-up (M and R are on the
//                              nanoKONTROL2)
//   drag a unit in the room    manual: move its home position
//                              loop: record a path, loops on release; hold shift
//                              during the drag to make that stretch a jump
//                              (shown as a thin straight line; the unit cuts
//                              straight across it)
//                              (in assign mode, by each unit's behaviour)
//   shift held when you start a loop drag: the first stretch (up to where you
//   let go of shift) is dropped, so the loop starts there
//   (loops are deleted on the nanoKONTROL2 only: hold S for 2 s)
//   HIDE / SHOW HOME POSITIONS (header): the X marking each unit's home
//   EDIT LINE-UP (switchemups scenes only): while on, clicking a unit box opens
//   a list to choose that slot's source; sources that would reuse a channel
//   already in the line-up are greyed out
//
// Outlet: key <ascii>, drag <n> <x> <y> <shift>, dragend <n>,
//         lineupedit <0|1>, setkey <slot> <id>  -> dbap_behave.js

autowatch = 1;
inlets = 1;
outlets = 1;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

const C_BG = [0, 0, 0, 1];
const C_SEE = [0, 0, 0, 0.25];            // see-through side strips (seethrough 1)
const C_PANEL = [0.16, 0.16, 0.18, 1];
const C_ROOM = [0.14, 0.14, 0.16, 1];
const C_LINE = [0.35, 0.35, 0.38, 1];
const C_TEXT = [0.85, 0.85, 0.85, 1];
const C_DIM = [0.5, 0.5, 0.52, 1];
const C_LIT = [0.95, 0.35, 0.2, 1];
const C_BLUE = [0.45, 0.75, 1.0, 1];
const C_SPK = [0.3, 0.3, 0.32, 1];
const NUNITS = 8;
const C_WHITE = [1, 1, 1, 1];

// one line per mode for the header
const DESCRIPTIONS = {
	manual: "drag a unit to set its home. R sends it there from any mode",
	drift: "units wander slowly around the whole room",
	orbit: "units circle the middle of the room",
	hop: "units jump between speakers at random",
	pulse: "units jump between speakers together, on a steady beat",
	swarm: "units cluster together and travel as a group",
	sway: "units sway from the front of the room to the back",
	perimeter: "units spread around the walls and slowly circle",
	loop: "drag a unit to draw its path. It loops when you let go",
	assign: "tap S to select units, then press a number to give them that behaviour"
};
const UNIT_COLS = [
	[0.95, 0.45, 0.35, 1], [0.95, 0.75, 0.3, 1], [0.6, 0.85, 0.35, 1],
	[0.3, 0.8, 0.7, 1], [0.4, 0.65, 1.0, 1], [0.65, 0.5, 1.0, 1],
	[0.95, 0.5, 0.8, 1], [0.85, 0.85, 0.85, 1]
];

const HEAD = 34, MODES = 38, UNITS = 72, PAD = 10;
const SIDE_M = 1.2;    // metres of see-through margin beside the speakers (for meters)
const END_M = 0.5;     // metres of margin above and below the room

// held open for the life of the view (see dbap_behave.js)
const DICTS = {
	dbap_state: new Dict("dbap_state"),
	dbap_behave: new Dict("dbap_behave"),
	dbap_loops: new Dict("dbap_loops")
};

let st = null;      // dbap_state
let bh = null;      // dbap_behave
let loops = {};     // unit n -> [[x, y], ...]
let hits = [];      // clickable boxes from the last paint
let map = null;     // metres <-> pixels, from the last paint
let dragUnit = 0;
let dragOff = [0, 0];   // unit centre minus mouse, in metres, while dragging
let showHomes = 1;      // X at each unit's home
let picker = 0;     // unit slot whose source list is open (line-up editing), 0 = closed
let pickHits = [];
let seeThrough = 0;

function seethrough(on) {
	seeThrough = on ? 1 : 0;
	mgraphics.redraw();
}

function dictionary(name) {
	if (!DICTS[name]) {
		post("dbap_view: ignoring dictionary " + name + "\n");
		return;
	}
	let o;
	try { o = JSON.parse(DICTS[name].stringify()); } catch (e) { return; }
	// an empty or partial update would blank the view for a frame: keep the last good one
	if (name === "dbap_state") {
		if (!o || !o.sources) return;
		st = o;
	} else if (name === "dbap_behave") {
		if (!o || !o.mode || !o.modes) return;
		bh = o;
	} else {
		if (!o || !o.loops) return;
		loops = o.loops;
	}
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

	// layout, top to bottom: room map, mode buttons, header, unit boxes
	const unitsY = H - UNITS - PAD / 2;
	const headY = unitsY - HEAD;
	const modesY = headY - MODES;
	const mapTop = PAD / 2, mapBot = modesY - PAD / 2;
	const spk = toArr(st.speakers);
	layout(PAD, mapTop, W - PAD * 2, mapBot - mapTop, spk);

	// background: solid everywhere except the strips beside the speakers
	if (map) {
		const L = map.P(map.room.x0, 0)[0] - 16, R = map.P(map.room.x1, 0)[0] + 16;
		fillRect(0, 0, W, mapTop, C_BG);
		fillRect(0, mapBot, W, H - mapBot, C_BG);
		fillRect(L, mapTop, R - L, mapBot - mapTop, C_BG);
		fillRect(0, mapTop, Math.max(0, L), mapBot - mapTop, seeThrough ? C_SEE : C_BG);
		fillRect(R, mapTop, Math.max(0, W - R), mapBot - mapTop, seeThrough ? C_SEE : C_BG);
	} else {
		fillRect(0, 0, W, H, C_BG);
	}

	if (map) drawMap(spk);
	drawModes(PAD, modesY, W - PAD * 2, MODES - 4);
	drawHeader(W, headY);
	drawUnits(PAD, unitsY, W - PAD * 2, UNITS - 4);
	if (!st.editing) picker = 0;
	drawPicker(W, mapTop, mapBot);
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

function drawHeader(W, y0) {
	const h = HEAD;
	rrect(4, y0 + 2, W - 8, h - 6, 5, C_PANEL);
	text("SCENE", 14, y0 + 13, 9, C_DIM);
	text(pretty(st.scene || "-").toUpperCase(), 14, y0 + 27, 13, C_TEXT);
	if (!bh) return;
	text("MODE", 150, y0 + 13, 9, C_DIM);
	const mtitle = (strv(bh.modeKey) + "  " + strv(bh.modeTitle || bh.mode)).toUpperCase();
	text(mtitle, 150, y0 + 27, 13, C_TEXT);
	mgraphics.set_font_size(13);
	const titleEnd = 150 + mgraphics.text_measure(mtitle)[0] + 20;
	let hx = Math.max(290, titleEnd);
	if (st.lineup) {
		const ed = !!st.editing, lw = 110;
		rrect(hx, y0 + 6, lw, h - 14, 4, ed ? C_LIT : C_BLUE);
		text(ed ? "DONE" : "EDIT LINE-UP", hx + lw / 2, y0 + 6 + (h - 14) / 2 + 4, 10, C_BG, "c");
		hits.push({ x: hx, y: y0 + 6, w: lw, h: h - 14, lineup: ed ? 0 : 1 });
		hx += lw + 12;
	}
	const desc = st.editing ? "click a unit box below to choose its source" : (DESCRIPTIONS[bh.mode] || "");
	const hw = 150, hbx = W - 120 - 10 - 130 - hw;   // home-positions button, left of the speed readout
	rrect(hbx, y0 + 6, hw, h - 14, 4, C_SPK);
	text(showHomes ? "HIDE HOME POSITIONS" : "SHOW HOME POSITIONS", hbx + hw / 2, y0 + 6 + (h - 14) / 2 + 4, 10, C_TEXT, "c");
	hits.push({ x: hbx, y: y0 + 6, w: hw, h: h - 14, homes: 1 });
	const room = hbx - 12 - hx;   // up to the home-positions button
	if (desc && room > 60) text(fit("description: " + desc, 12, room), hx, y0 + 25, 12, st.editing ? C_LIT : C_WHITE);

	const bw = 120, bx = W - bw - 10, by = y0 + 6, bhh = h - 14;
	const g = bh.glide;
	rrect(bx, by, bw, bhh, 4, g ? C_BLUE : C_LIT);
	text(g ? "GLIDE " + num(bh.glideTime, 0).toFixed(1) + "s" : "CUT", bx + bw / 2, by + bhh / 2 + 5, 12, C_BG, "c");
	text("TAB", bx - 8, by + bhh / 2 + 4, 9, C_DIM, "r");
	hits.push({ x: bx, y: by, w: bw, h: bhh, key: 9 });
	text("SPEED x" + num(bh.speed, 1).toFixed(2), bx - 40, y0 + 27, 11, C_DIM, "r");
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
			setc(unitCol(+n), 0.45);
			mgraphics.set_line_width(3.5);
			// travelled stretches thick, one path each; jumps thin
			let open = false;
			for (let i = 1; i < pts.length; i++) {
				const a = P(pts[i - 1][0], pts[i - 1][1]), b = P(pts[i][0], pts[i][1]);
				if (pts[i][2]) {
					// a jump: a thin straight line from where it starts to where it lands
					if (open) { mgraphics.stroke(); open = false; }
					mgraphics.set_line_width(1);
					mgraphics.move_to(a[0], a[1]);
					mgraphics.line_to(b[0], b[1]);
					mgraphics.stroke();
					mgraphics.set_line_width(3.5);
				} else {
					if (!open) { mgraphics.move_to(a[0], a[1]); open = true; }
					mgraphics.line_to(b[0], b[1]);
				}
			}
			if (open) mgraphics.stroke();
			// the glide from the end back to the start
			const e = P(pts[pts.length - 1][0], pts[pts.length - 1][1]), f = P(pts[0][0], pts[0][1]);
			mgraphics.move_to(e[0], e[1]);
			mgraphics.line_to(f[0], f[1]);
			mgraphics.stroke();
		}
	}

	// home positions: an X in each unit's colour
	if (showHomes && bh) {
		mgraphics.set_line_width(2);
		for (const u of toArr(bh.units)) {
			const hm = toArr(u.home);
			if (hm.length < 2) continue;
			const h = P(hm[0], hm[1]);
			setc(unitCol(u.n), 0.9);
			mgraphics.move_to(h[0] - 6, h[1] - 6); mgraphics.line_to(h[0] + 6, h[1] + 6);
			mgraphics.move_to(h[0] - 6, h[1] + 6); mgraphics.line_to(h[0] + 6, h[1] - 6);
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

		// spread halo: always a small ring (point source), growing with the spatial blur
		const blur = num(src.blur, 0.01);
		const hr = 11 + blur * s;
		for (const q of pts) {
			setc(col, 0.12);
			mgraphics.arc(q[0], q[1], hr, 0, Math.PI * 2);
			mgraphics.fill();
			setc(col, 0.35);
			mgraphics.set_line_width(1);
			mgraphics.arc(q[0], q[1], hr, 0, Math.PI * 2);
			mgraphics.stroke();
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
		text((n ? n + " " : "") + (src.label || pretty(id)), c[0] + 10, c[1] - 8, 10, col);
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
		const key = strv(m.key), name = strv(m.name), lab = strv(m.label || m.name);
		if (!key) return;
		const bx = x + i * bw + 2;
		const on = name === bh.mode;
		rrect(bx, y, bw - 4, h, 4, on ? C_LIT : C_PANEL);
		text(key, bx + 7, y + h / 2 + 5, 13, on ? C_BG : C_DIM);
		text(fit(lab, 13, bw - 30), bx + 23, y + h / 2 + 5, 13, on ? C_BG : C_TEXT);
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
		rrect(bx, y, bw - 4, h, 4, picker === n ? C_SPK : C_PANEL);
		if (st.editing) hits.push({ x: bx, y, w: bw - 4, h, pick: n });
		if (!u) {
			text("" + n, bx + 10, y + 19, 16, C_SPK);
			if (st.editing) text("CHOOSE...", bx + 10, y + 41, 13, C_LIT);
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
		// row 1: number and state; row 2: name; row 3: input channels
		text("" + n, bx + 10, y + 19, 16, col);
		let tag = u.active ? "movable" : "frozen";
		if (bh.mode === "assign") tag = (u.selected ? "SELECTED" : strv(u.assign)) + " - " + tag;
		else if (u.hasLoop) tag += " - loop";
		text(fit(tag, 12, bw - 38), bx + 28, y + 18, 12, u.selected ? C_LIT : C_DIM);
		text(fit(unitLabel(u).toUpperCase(), 13, bw - 16), bx + 10, y + 41, 13, st.editing ? C_LIT : C_TEXT);
		text(inLabel(u), bx + 10, y + h - 9, 13, C_WHITE);

	}
}

function unitLabel(u) {
	const src = st.sources && st.sources[u.id];
	return src && src.label ? src.label : pretty(u.id);
}

// "IN:5/6" from the unit's channels
function inLabel(u) {
	const chs = [];
	for (const m of toArr(u.members)) {
		const src = st.sources && st.sources[m];
		if (src) for (const p of toArr(src.points)) chs.push(p.ch);
	}
	return chs.length ? "IN:" + chs.join("/") : "";
}

// the source list for one slot, over the room
function drawPicker(W, top, bot) {
	pickHits = [];
	if (!picker || !st.editing) return;
	const cat = toArr(st.catalog);
	const keys = toArr(st.keys).map(String);
	// channels used by the other slots
	const used = {};
	keys.forEach((id, i) => {
		if (i === picker - 1 || id === "-") return;
		const c = cat.find(e => e.id === id);
		if (c) for (const ch of toArr(c.channels)) used[ch] = i + 1;
	});
	const items = [{ id: "-", label: "(empty)", channels: [] }].concat(cat);
	const x0 = PAD + 6, y0 = top + 6, w = W - 2 * PAD - 12, h = bot - top - 12;
	rrect(x0, y0, w, h, 6, [0.08, 0.08, 0.09, 0.97]);
	setc(C_LIT);
	mgraphics.set_line_width(1.5);
	mgraphics.rectangle_rounded(x0, y0, w, h, 6, 6);
	mgraphics.stroke();
	text("UNIT " + picker + ": choose a source", x0 + 12, y0 + 20, 12, C_LIT);
	text("click outside to cancel", x0 + w - 12, y0 + 20, 9, C_DIM, "r");
	const cols = 2, rowH = 17;
	const rows = Math.ceil(items.length / cols);
	const cw = (w - 24) / cols;
	const lh = Math.min(rowH, (h - 40) / Math.max(1, rows));
	items.forEach((it, i) => {
		const c = Math.floor(i / rows), r = i % rows;
		const ix = x0 + 12 + c * cw, iy = y0 + 32 + r * lh;
		const clash = toArr(it.channels).find(ch => used[ch]);
		const current = keys[picker - 1] === it.id;
		if (current) rrect(ix - 4, iy, cw - 8, lh - 1, 3, C_SPK);
		const inl = toArr(it.channels).length ? "IN:" + toArr(it.channels).join("/") : "";
		const colr = clash ? C_SPK : C_TEXT;
		text(fit(it.label, 10, cw - 90), ix, iy + lh - 5, 10, colr);
		text(inl + (clash ? "  (unit " + used[clash] + ")" : ""), ix + cw - 14, iy + lh - 5, 9, clash ? C_SPK : C_DIM, "r");
		if (!clash) pickHits.push({ x: ix - 4, y: iy, w: cw - 8, h: lh, id: it.id });
	});
	pickHits.push({ panel: 1, x: x0, y: y0, w, h });
}

// ---- mouse ----

// the unit under the mouse: its centre or any of its points (mics) counts.
// Returns { n, off } where off is the unit centre minus the mouse position in
// metres, so the unit doesn't jump when grabbed by one of its points.
function unitAt(qx, qy) {
	if (!map || !bh || !st) return null;
	let best = null, bestD = 18;   // pixels
	for (const u of toArr(bh.units)) {
		const ms = toArr(u.members).map(m => st.sources[m]).filter(Boolean);
		if (!ms.length) continue;
		const cx = ms.reduce((t, s) => t + s.x, 0) / ms.length;
		const cy = ms.reduce((t, s) => t + s.y, 0) / ms.length;
		const targets = [[cx, cy]];
		for (const src of ms) for (const q of pointsOf(src)) targets.push(q);
		for (const q of targets) {
			const p = map.P(q[0], q[1]);
			const d = Math.hypot(p[0] - qx, p[1] - qy);
			if (d < bestD) {
				bestD = d;
				const mm = map.M(qx, qy);
				best = { n: u.n, off: [cx - mm[0], cy - mm[1]] };
			}
		}
	}
	return best;
}

function inside(b, x, y) {
	return x >= b.x && x <= b.x + b.w && y >= b.y && y <= b.y + b.h;
}

function onclick(x, y, but, cmd, shift) {
	if (picker) {
		for (const b of pickHits) {
			if (b.panel || !inside(b, x, y)) continue;
			outlet(0, "setkey", picker, b.id);
			picker = 0;
			mgraphics.redraw();
			return;
		}
		const panel = pickHits.find(b => b.panel);
		if (panel && inside(panel, x, y)) return;   // a greyed item or a gap: ignore
		picker = 0;                                  // outside the list: cancel
		mgraphics.redraw();
		return;
	}
	for (const b of hits) {
		if (inside(b, x, y)) {
			if (b.homes) { showHomes = showHomes ? 0 : 1; mgraphics.redraw(); }
			else if (b.lineup !== undefined) outlet(0, "lineupedit", b.lineup);
			else if (b.pick) { picker = b.pick; mgraphics.redraw(); }
			else outlet(0, "key", b.key);
			return;
		}
	}
	if (st && st.editing) return;   // no dragging while editing the line-up
	if (!bh || ["manual", "loop", "assign"].indexOf(bh.mode) < 0) return;
	const hit = unitAt(x, y);
	if (!hit) return;
	const n = hit.n;
	dragUnit = n;
	dragOff = hit.off;
	const m = map.M(x, y);
	outlet(0, "drag", n, m[0] + dragOff[0], m[1] + dragOff[1], shift ? 1 : 0);
}

function ondrag(x, y, but, cmd, shift) {
	if (!dragUnit) return;
	if (!but) {
		outlet(0, "dragend", dragUnit);
		dragUnit = 0;
		return;
	}
	const m = map.M(x, y);
	outlet(0, "drag", dragUnit, m[0] + dragOff[0], m[1] + dragOff[1], shift ? 1 : 0);
}

function onresize() {
	mgraphics.redraw();
}