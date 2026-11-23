// dbap_modehelp.js  (for a [v8ui dbap_modehelp.js] object)
//
// Shows what's special about the current mode: a one-line description and only
// the controls that do something particular in it (nanoKONTROL2 buttons and
// pages, keys, mouse). Greyed rows are controls that do nothing in this mode.
// Designed at 400 x 380; scales to the size of the box.
//
// Inlet (connect the same cords as the room view):
//   dictionary dbap_behave     from dbap_behave.js outlet 2
//   dictionary dbap_state      from dbap_control.js

autowatch = 1;
inlets = 1;
outlets = 0;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

const DW = 400, DH = 380;

const C_BG = [0.11, 0.11, 0.12, 1];
const C_PANEL = [0.16, 0.16, 0.18, 1];
const C_BTN = [0.25, 0.25, 0.28, 1];
const C_OFF = [0.17, 0.17, 0.19, 1];
const C_TEXT = [0.85, 0.85, 0.85, 1];
const C_WHITE = [1, 1, 1, 1];
const C_DIM = [0.5, 0.5, 0.52, 1];
const C_BLUE = [0.45, 0.75, 1.0, 1];
const C_LIT = [0.95, 0.35, 0.2, 1];

// glyphs: S M R (strip buttons), STOP PLAY REC (pages), key:<text>, mouse:<text>,
//         home (an X), combo:S+<key text> (press S, then the key)
//
// Every mode lists M, R and S first. STRIP holds what they usually do; a mode
// can replace any of them with m / r / s: [text, off], or null to leave it out.
const STRIP = {
	M: ["move / freeze this unit"],
	R: ["send home (with M on, it comes back)"],
	S: ["not used here", true]
};
// off: true = this control does nothing in the mode (drawn greyed)
const HELP = {
	manual: {
		title: "set home positions",
		desc: "Every unit sits at its home. Drag one to give it a new home: in every other mode, its home is marked with an X in its colour.",
		m: ["always on here", true],
		r: ["not used here", true],
		rows: [
			["mouse:drag", "a unit (or any of its dots): set its home"],
			["STOP", "range, speed, accel: not used here", true]
		]
	},
	drift: {
		title: "drift",
		desc: "Units wander slowly around the whole room.",
		rows: [
			["STOP", "range: how far from home they wander"]
		]
	},
	orbit: {
		title: "orbit",
		desc: "Units circle the middle of the room, neighbours in opposite directions.",
		rows: [
			["PLAY", "speed: x1 is about 40 s per lap"]
		]
	},
	hop: {
		title: "hop",
		desc: "Units jump between speakers at random, every 2 to 6 s.",
		rows: [
			["REC", "accel below the top: glide speaker to speaker instead of jumping"]
		]
	},
	pulse: {
		title: "pulse",
		desc: "Units jump between speakers together, on a beat.",
		rows: [
			["PLAY", "speed: units with the same speed stay in step"],
			["REC", "accel: no effect, pulse always jumps", true]
		]
	},
	swarm: {
		title: "swarm",
		desc: "Units cluster together and travel around the room as a group.",
		rows: [
			["STOP", "range: how far the swarm pulls them from home"]
		]
	},
	sway: {
		title: "sway",
		desc: "Units sway from their home toward the back and back again.",
		rows: [
			["STOP", "range: how far back they go"]
		]
	},
	perimeter: {
		title: "perimeter",
		desc: "Units spread around the walls and slowly circle the room.",
		rows: [
			["PLAY", "speed: x1 is about 90 s per lap"]
		]
	},
	loop: {
		title: "loop",
		desc: "Each unit follows a path you draw.",
		r: ["send home (with M on, back onto its loop)"],
		s: ["hold 2 s: delete the loop"],
		rows: [
			["mouse:drag", "a unit: record its loop (plays when you let go)"],
			["key:shift", "while dragging: that stretch becomes a jump"],
			["key:shift", "+ click, then drag: choose where the loop starts"],
			["PLAY", "speed: playback speed"],
			["STOP", "range: no effect on loops", true]
		]
	},
	assign: {
		title: "assign",
		desc: "Each unit runs its own mode.",
		s: null,
		rows: [
			["combo:S+1-9", "tap S on units (they flash), then a number: give them that mode"],
			["key:0", "clear the selection"],
			["STOP", "range, speed, accel: for each unit's own mode"],
			["mouse:drag", "units assigned to set home or loop"]
		]
	}
};

let bh = null;
let st = null;
const DICTS = { dbap_behave: new Dict("dbap_behave"), dbap_state: new Dict("dbap_state") };

function dictionary(name) {
	if (!DICTS[name]) return;
	let o;
	try { o = JSON.parse(DICTS[name].stringify()); } catch (e) { return; }
	if (name === "dbap_behave") {
		if (!o || !o.mode) return;
		const before = bh ? key(bh) : "";
		bh = o;
		if (key(bh) !== before) mgraphics.redraw();   // only redraw when something shown changes
	} else {
		if (!o || !o.sources) return;
		const ed = st ? st.editing : -1;
		st = o;
		if (st.editing !== ed) mgraphics.redraw();
	}
}

// what this panel depends on, to avoid redrawing 10 times a second
function key(b) {
	const sel = toArr(b.units).filter(u => u.selected).length;
	return b.mode + "|" + b.modeKey + "|" + sel;
}

// ---- drawing helpers ----

function setc(c) { mgraphics.set_source_rgba(c[0], c[1], c[2], c[3]); }

function rrect(x, y, w, h, r, c) {
	setc(c);
	mgraphics.rectangle_rounded(x, y, w, h, r, r);
	mgraphics.fill();
}

function text(s, x, y, size, c, align) {
	if (!s) return;
	mgraphics.set_font_size(size);
	const w = mgraphics.text_measure(s)[0];
	setc(c);
	mgraphics.move_to(align === "c" ? x - w / 2 : x, y);
	mgraphics.show_text(s);
}

// wrap s to width w; returns the lines
function wrap(s, size, w) {
	mgraphics.set_font_size(size);
	const words = String(s).split(" ");
	const lines = [];
	let cur = "";
	for (const wd of words) {
		const t = cur ? cur + " " + wd : wd;
		if (mgraphics.text_measure(t)[0] > w && cur) {
			lines.push(cur);
			cur = wd;
		} else {
			cur = t;
		}
	}
	if (cur) lines.push(cur);
	return lines;
}

function toArr(v) {
	if (v === undefined || v === null) return [];
	return Array.isArray(v) ? v : [v];
}

const GW = 64;   // glyph column width

// a glyph centred in a GW x 24 box at (x, y)
function glyph(g, x, y, off) {
	if (g.indexOf("combo:") === 0) {
		// S, a plus, then a key cap
		const keyText = g.split("+")[1];
		rrect(x, y, 24, 24, 4, off ? C_OFF : C_BTN);
		text("S", x + 12, y + 18, 15, off ? C_DIM : C_WHITE, "c");
		text("+", x + 30, y + 17, 12, C_DIM, "c");
		glyphKey(keyText, x + 36, y, 28, off);
		return;
	}
	x += (GW - 44) / 2;
	const w = 44, h = 24, cx = x + w / 2, cy = y + h / 2;
	const fg = off ? C_DIM : C_TEXT;
	if (g === "S" || g === "M" || g === "R") {
		rrect(x + 5, y, 34, h, 4, off ? C_OFF : C_BTN);
		text(g, cx, cy + 6, 16, off ? C_DIM : C_WHITE, "c");
		return;
	}
	if (g === "STOP" || g === "PLAY" || g === "REC") {
		rrect(x + 2, y, 40, h, 4, off ? C_OFF : C_BTN);
		setc(off ? C_DIM : C_TEXT);
		if (g === "STOP") {
			mgraphics.rectangle(cx - 6, cy - 6, 12, 12);
			mgraphics.fill();
		} else if (g === "PLAY") {
			mgraphics.move_to(cx - 5, cy - 7);
			mgraphics.line_to(cx - 5, cy + 7);
			mgraphics.line_to(cx + 7, cy);
			mgraphics.close_path();
			mgraphics.fill();
		} else {
			mgraphics.arc(cx, cy, 6.5, 0, Math.PI * 2);
			mgraphics.fill();
		}
		return;
	}
	if (g === "home") {
		setc(off ? C_DIM : C_WHITE);
		mgraphics.set_line_width(2);
		mgraphics.move_to(cx - 6, cy - 6); mgraphics.line_to(cx + 6, cy + 6);
		mgraphics.move_to(cx - 6, cy + 6); mgraphics.line_to(cx + 6, cy - 6);
		mgraphics.stroke();
		return;
	}
	const [kind, label] = g.split(":");
	if (kind === "key") {
		glyphKey(label, x, y, w, off);
		return;
	}
	if (kind === "mouse") {
		setc(off ? C_DIM : C_BLUE);
		mgraphics.set_line_width(1.5);
		mgraphics.rectangle_rounded(x + 0.75, y + 1.75, w - 1.5, h - 3.5, 10, 10);
		mgraphics.stroke();
		text(label, cx, cy + 4, 11, off ? C_DIM : C_BLUE, "c");
	}
}

function glyphKey(label, x, y, w, off) {
	const h = 24;
	rrect(x, y + 1, w, h - 2, 4, off ? C_OFF : [0.2, 0.2, 0.23, 1]);
	setc(off ? C_DIM : [0.4, 0.4, 0.45, 1]);
	mgraphics.set_line_width(1);
	mgraphics.rectangle_rounded(x + 0.5, y + 1.5, w - 1, h - 3, 4, 4);
	mgraphics.stroke();
	text(label, x + w / 2, y + h / 2 + 4, 11, off ? C_DIM : C_TEXT, "c");
}

// the mode's rows: M, R, S (unless replaced or left out), its own rows, the home X
function rowsFor(mode, hp) {
	const rows = [];
	for (const b of ["M", "R", "S"]) {
		const k = b.toLowerCase();
		const r = k in hp ? hp[k] : STRIP[b];
		if (r) rows.push([b, r[0], r[1]]);
	}
	for (const r of hp.rows) rows.push(r);
	if (mode !== "manual") rows.push(["home", "each unit's home (where R sends it)"]);
	return rows;
}

// ---- paint ----

function paint() {
	const W = mgraphics.size[0], H = mgraphics.size[1];
	setc(C_BG);
	mgraphics.rectangle(0, 0, W, H);
	mgraphics.fill();
	const sc = Math.min(W / DW, H / DH);
	mgraphics.save();
	mgraphics.translate((W - DW * sc) / 2, (H - DH * sc) / 2);
	mgraphics.scale(sc, sc);
	mgraphics.select_font_face("Arial");
	rrect(4, 4, DW - 8, DH - 8, 6, C_PANEL);

	if (!bh) {
		text("waiting for dbap_behave", DW / 2, DH / 2, 13, C_DIM, "c");
		mgraphics.restore();
		return;
	}
	const hp = HELP[bh.mode];
	if (!hp) { mgraphics.restore(); return; }

	text("MODE CHEAT SHEET   KEY " + (bh.modeKey || ""), 18, 26, 10, C_DIM);
	text(hp.title.toUpperCase(), 18, 50, 20, C_WHITE);

	let y = 68;
	for (const ln of wrap(hp.desc, 12, DW - 36)) {
		text(ln, 18, y + 12, 12, C_TEXT);
		y += 16;
	}

	// context: line-up editing, assign selection
	const sel = toArr(bh.units).filter(u => u.selected).length;
	let ctx = "";
	if (st && st.editing) ctx = "Editing the line-up: click a unit box to choose its source. Shift-click several sources, then DONE, to make a group.";
	else if (bh.mode === "assign" && sel) ctx = sel + " selected: press 1-9 to give them that mode.";
	if (ctx) {
		y += 6;
		for (const ln of wrap(ctx, 12, DW - 36)) {
			text(ln, 18, y + 12, 12, C_LIT);
			y += 16;
		}
	}

	y += 10;
	const tx = 18 + GW + 10, tw = DW - tx - 16;
	for (const [g, desc, off] of rowsFor(bh.mode, hp)) {
		const lines = wrap(desc, 12, tw);
		const rowH = Math.max(25, lines.length * 15 + 6);
		if (y + rowH > DH - 10) break;   // out of room
		glyph(g, 18, y + (rowH - 24) / 2, off);
		let ly = y + (rowH - lines.length * 15) / 2 + 11;
		for (const ln of lines) {
			text(ln, tx, ly, 12, off ? C_DIM : C_TEXT);
			ly += 15;
		}
		y += rowH + 1;
	}
	mgraphics.restore();
}

function onresize() {
	mgraphics.redraw();
}