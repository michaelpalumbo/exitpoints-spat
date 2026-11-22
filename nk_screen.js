// nk_screen.js
// On-screen nanoKONTROL2 for [v8ui]: 8 strips (knob, fader, S M R) plus the
// transport, cycle, track and marker buttons, labelled by the current mode.
// Scales to the size of the v8ui box (designed at 904 x 340).
//
// Inlet (from nanoKontrolModes.js outlet 10, and the LED streams):
//   knob <k> <value 0-1, -1 unused, -2 hidden (no ring, labels only)> <hardware position 0-1, -1 unseen> <name> <value text>
//        [<remembered value 0-1, -1 none> <pushed 0/1>]
//        Knobs: blue arc = the value, yellow tick = where the hardware knob is,
//        red tick = a remembered value (region knobs 4 and 5): faint normally,
//        bright when the other knob has pushed the edge away from it.
//   fader <n> <level 0-1> <hardware position 0-1, -1 unseen> <name> <value text>
//   Faders: the blue bar is the level; the yellow line is where the hardware
//   fader is. The hardware fader takes over once the line reaches the bar.
//   btn <cc> <label>
//   mode <name...>
//   caption <text>      the small label above the mode line (default MODE)
//   dim <cc> <0|1>      grey a button out (dark, label dimmed); it still sends
//   groupdim <0|1>      grey the group box out
//   group <text>        box the three transport buttons STOP, PLAY, REC and label
//                       them (e.g. "orbit settings"); empty text removes the box
//   <value> <cc>        an LED message (the same lists that go to [ctlout])
//
// Outlet: "screen <value> <cc>" to nanoKontrolModes.js and nk_delete.js.
//   Buttons send 127 on press and 0 on release. Knobs: drag up/down.
//   Faders: click or drag to a position. Shift-drag a knob for fine control.

inlets = 1;
outlets = 1;

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

var N = 8;
var DW = 904, DH = 340;

// colours
var C_BG = [0.11, 0.11, 0.12, 1];
var C_PANEL = [0.16, 0.16, 0.18, 1];
var C_BTN = [0.25, 0.25, 0.28, 1];
var C_LIT = [0.95, 0.35, 0.2, 1];
var C_TEXT = [0.85, 0.85, 0.85, 1];
var C_DIM = [0.5, 0.5, 0.52, 1];
var C_VALUE = [0.45, 0.75, 1.0, 1];
var C_HW = [1.0, 0.8, 0.2, 1];
var C_TRACK = [0.08, 0.08, 0.09, 1];
var C_MEM = [1.0, 0.3, 0.3, 0.35];       // remembered value, faint
var C_MEM_PUSHED = [1.0, 0.3, 0.3, 1.0]; // remembered value, edge pushed away from it

// state
var knobParam = [-1, -1, -1, -1, -1, -1, -1, -1];
var knobPhys = [-1, -1, -1, -1, -1, -1, -1, -1];
var knobName = ["", "", "", "", "", "", "", ""];
var knobText = ["", "", "", "", "", "", "", ""];
var knobMem = [-1, -1, -1, -1, -1, -1, -1, -1];
var knobPushed = [0, 0, 0, 0, 0, 0, 0, 0];
var faderVal = [1, 1, 1, 1, 1, 1, 1, 1];
var faderPos = [-1, -1, -1, -1, -1, -1, -1, -1];
var faderName = ["", "", "", "", "", "", "", ""];
var faderText = ["", "", "", "", "", "", "", ""];
var led = {};
var label = {};
var modeName = "";
var captionText = "MODE";
var groupText = "";
var groupDim = 0;
var dimmed = {};
var C_OFFBTN = [0.17, 0.17, 0.19, 1];   // a greyed-out button
var GROUP_CCS = [42, 41, 45]; // STOP, PLAY, REC: boxed together by "group"

// layout, in design coordinates
var controls = [];
var groupLabels = []; // text above button groups, e.g. TRACK, MARKER
var STRIP_X = 260, STRIP_W = 80;
var STRIP_TOP = 40;   // strip content starts below the channel number

// icon: "rew" "ff" "stop" "play" "rec" "cycle" "left" "right", or null for text
// big: the transport-area style (icon, all-caps mode label); otherwise an S/M/R button
function addButton(cc, name, icon, x, y, w, h, big) {
	controls.push({ type: "btn", cc: cc, name: name, icon: icon, x: x, y: y, w: w, h: h, big: big });
}

(function layout() {
	// track
	groupLabels.push({ text: "TRACK", cx: 62, y: 16 });
	addButton(58, "<", "left", 10, 22, 50, 36, true);
	addButton(59, ">", "right", 65, 22, 50, 36, true);
	// cycle and marker
	addButton(46, "CYCLE", null, 10, 84, 62, 40, true);
	groupLabels.push({ text: "MARKER", cx: 165, y: 78 });
	addButton(60, "SET", null, 85, 84, 52, 40, true);
	addButton(61, "<", "left", 141, 84, 52, 40, true);
	addButton(62, ">", "right", 197, 84, 52, 40, true);
	// transport
	var tr = [[43, "rew"], [44, "ff"], [42, "stop"], [41, "play"], [45, "rec"]];
	for (var i = 0; i < tr.length; i++) {
		addButton(tr[i][0], "", tr[i][1], 8 + i * 49, 140, 46, 44, true);
	}
	// strips
	for (var n = 0; n < N; n++) {
		var x = STRIP_X + n * STRIP_W;
		var t = STRIP_TOP;
		controls.push({ type: "knob", k: n, cx: x + 40, cy: t + 45, r: 20, x: x + 15, y: t + 20, w: 50, h: 50 });
		addButton(32 + n, "S", null, x + 6, t + 100, 34, 40, false);
		addButton(48 + n, "M", null, x + 6, t + 146, 34, 40, false);
		addButton(64 + n, "R", null, x + 6, t + 192, 34, 40, false);
		controls.push({ type: "fader", n: n, x: x + 50, y: t + 100, w: 20, h: 150 });
	}
})();

// ---- incoming messages ----

function str(v) {
	if (v === undefined || v === null) return "";
	return String(v).replace(/_/g, " ");
}

function knob(k, value, phys, name, text, mem, pushed) {
	if (k < 0 || k >= N) return;
	knobParam[k] = value;
	knobPhys[k] = phys;
	knobName[k] = str(name);
	knobText[k] = str(text);
	knobMem[k] = mem === undefined ? -1 : mem;
	knobPushed[k] = pushed ? 1 : 0;
	mgraphics.redraw();
}

function fader(n, value, pos, name, text) {
	if (n < 0 || n >= N) return;
	faderVal[n] = value;
	faderPos[n] = pos;
	faderName[n] = str(name);
	faderText[n] = str(text);
	mgraphics.redraw();
}

function btn(cc, text) {
	label[cc] = str(text);
	mgraphics.redraw();
}

function mode() {
	var a = [];
	for (var i = 0; i < arguments.length; i++) a.push(str(arguments[i]));
	modeName = a.join(" ");
	mgraphics.redraw();
}

function caption() {
	var a = [];
	for (var i = 0; i < arguments.length; i++) a.push(str(arguments[i]));
	captionText = a.join(" ");
	mgraphics.redraw();
}

function dim(cc, on) {
	dimmed[cc] = on ? 1 : 0;
	mgraphics.redraw();
}

function groupdim(on) {
	groupDim = on ? 1 : 0;
	mgraphics.redraw();
}

function group() {
	var a = [];
	for (var i = 0; i < arguments.length; i++) a.push(str(arguments[i]));
	groupText = a.join(" ");
	mgraphics.redraw();
}

// LED: "value cc"
function list(v, cc) {
	if (cc === undefined) return;
	led[cc] = v > 0;
	mgraphics.redraw();
}

// ---- drawing ----

function setc(c) {
	mgraphics.set_source_rgba(c[0], c[1], c[2], c[3]);
}

function ctext(s, cx, y, size, c) {
	if (!s) return;
	mgraphics.set_font_size(size);
	var m = mgraphics.text_measure(s);
	setc(c);
	mgraphics.move_to(cx - m[0] / 2, y);
	mgraphics.show_text(s);
}

function rrect(x, y, w, h, r, c) {
	setc(c);
	mgraphics.rectangle_rounded(x, y, w, h, r, r);
	mgraphics.fill();
}

function tri(x1, y1, x2, y2, x3, y3) {
	mgraphics.move_to(x1, y1);
	mgraphics.line_to(x2, y2);
	mgraphics.line_to(x3, y3);
	mgraphics.close_path();
	mgraphics.fill();
}

// transport-style icons, centred on (cx, cy), about s pixels across
function drawIcon(icon, cx, cy, s, c) {
	setc(c);
	var h = s / 2;
	if (icon === "play") {
		tri(cx - h * 0.7, cy - h, cx - h * 0.7, cy + h, cx + h * 0.9, cy);
	} else if (icon === "stop") {
		mgraphics.rectangle(cx - h * 0.85, cy - h * 0.85, h * 1.7, h * 1.7);
		mgraphics.fill();
	} else if (icon === "rec") {
		mgraphics.arc(cx, cy, h * 0.95, 0, 2 * Math.PI);
		mgraphics.fill();
	} else if (icon === "ff") {
		tri(cx - h, cy - h * 0.8, cx - h, cy + h * 0.8, cx, cy);
		tri(cx, cy - h * 0.8, cx, cy + h * 0.8, cx + h, cy);
	} else if (icon === "rew") {
		tri(cx + h, cy - h * 0.8, cx + h, cy + h * 0.8, cx, cy);
		tri(cx, cy - h * 0.8, cx, cy + h * 0.8, cx - h, cy);
	} else if (icon === "left" || icon === "right") {
		var d = icon === "left" ? 1 : -1;
		mgraphics.set_line_width(2.5);
		mgraphics.move_to(cx + d * h * 0.45, cy - h * 0.8);
		mgraphics.line_to(cx - d * h * 0.45, cy);
		mgraphics.line_to(cx + d * h * 0.45, cy + h * 0.8);
		mgraphics.stroke();
	} 
}

var A0 = 0.75 * Math.PI, A1 = 2.25 * Math.PI;

function drawKnob(o) {
	var k = o.k;
	var p = knobParam[k];
	var active = p >= 0;
	if (p <= -2) {
		// hidden: no ring, just the labels
		ctext(knobName[k], o.cx, o.cy - o.r - 10, 10, C_DIM);
		ctext(knobText[k], o.cx, o.cy + 4, 10, C_DIM);
		return;
	}
	mgraphics.set_line_width(4);
	setc(C_TRACK);
	mgraphics.arc(o.cx, o.cy, o.r, A0, A1);
	mgraphics.stroke();
	if (active) {
		var av = A0 + (A1 - A0) * Math.max(0, Math.min(1, p));
		setc(C_VALUE);
		mgraphics.arc(o.cx, o.cy, o.r, A0, av);
		mgraphics.stroke();
		// a dot at the value, so the knob shows a value even at 0
		mgraphics.arc(o.cx + Math.cos(av) * o.r, o.cy + Math.sin(av) * o.r, 3.5, 0, 2 * Math.PI);
		mgraphics.fill();
	}
	// where the hardware knob physically is
	if (knobPhys[k] >= 0) {
		var a = A0 + (A1 - A0) * knobPhys[k];
		mgraphics.set_line_width(2.5);
		setc(C_HW);
		mgraphics.move_to(o.cx + Math.cos(a) * (o.r - 9), o.cy + Math.sin(a) * (o.r - 9));
		mgraphics.line_to(o.cx + Math.cos(a) * (o.r + 5), o.cy + Math.sin(a) * (o.r + 5));
		mgraphics.stroke();
	}
	ctext(knobName[k], o.cx, o.cy - o.r - 10, 10, active ? C_TEXT : C_DIM);
	ctext(knobText[k], o.cx, o.cy + o.r + 20, 11, active ? C_VALUE : C_DIM);
}

function drawFader(o) {
	var n = o.n;
	rrect(o.x, o.y, o.w, o.h, 3, C_TRACK);
	// blue bar: the level (same colour as a knob's value arc)
	// (a value below 0 means the fader is unused in this mode: no bar)
	if (faderVal[n] >= 0) {
		var vh = o.h * Math.max(0, Math.min(1, faderVal[n]));
		rrect(o.x + 3, o.y + o.h - vh, o.w - 6, vh, 2, C_VALUE);
	}
	// yellow line: where the hardware fader physically is (same colour as a
	// knob's hardware tick), once it has moved. It reaches the top of the blue
	// bar when the fader picks up.
	if (faderPos[n] >= 0) {
		var py = o.y + o.h - o.h * Math.max(0, Math.min(1, faderPos[n]));
		setc(C_HW);
		mgraphics.rectangle(o.x, py - 1.5, o.w, 3);
		mgraphics.fill();
	}
	ctext(faderText[n], o.x + o.w / 2, o.y + o.h + 14, 10, C_VALUE);
	ctext(faderName[n], o.x + o.w / 2 - 10, o.y + o.h + 30, 10, C_TEXT);
}

function drawButton(o) {
	var off = dimmed[o.cc];
	var lit = led[o.cc] && !off;
	rrect(o.x, o.y, o.w, o.h, 4, lit ? C_LIT : (off ? C_OFFBTN : C_BTN));
	var lab = label[o.cc] || "";
	var cx = o.x + o.w / 2;
	var fg = lit ? C_BG : (off ? C_DIM : C_TEXT);
	if (o.big) {
		// icon (or the button's name) on top, mode label in caps below
		// a "|" in the label splits it over two lines, with a smaller icon to make room
		var lines = lab ? lab.toUpperCase().split("|") : [];
		var two = lines.length > 1;
		var top = lab ? o.y + (two ? 10 : 14) : o.y + o.h / 2;
		if (o.icon) drawIcon(o.icon, cx, top, two ? 9 : 13, lit ? C_BG : C_DIM);
		else ctext(o.name, cx, top + 4, 10, lit ? C_BG : C_DIM);
		if (two) {
			ctext(lines[0], cx, o.y + o.h - 16, 9.5, fg);
			ctext(lines[1], cx, o.y + o.h - 6, 9.5, fg);
		} else if (lab) ctext(lines[0], cx, o.y + o.h - 7, 10.5, fg);
	} else {
		// S / M / R: big letter, small mode label below
		ctext(o.name, cx, o.y + (lab ? 19 : o.h / 2 + 6), 16, lit ? C_BG : C_DIM);
		if (lab) ctext(lab, cx, o.y + o.h - 6, 9, fg);
	}
}

// a box around STOP, PLAY and REC with a label under them
function drawGroup() {
	var x0 = 1e9, x1 = -1e9, y0 = 1e9, y1 = -1e9;
	for (var i = 0; i < controls.length; i++) {
		var o = controls[i];
		if (o.type !== "btn" || GROUP_CCS.indexOf(o.cc) < 0) continue;
		x0 = Math.min(x0, o.x); x1 = Math.max(x1, o.x + o.w);
		y0 = Math.min(y0, o.y); y1 = Math.max(y1, o.y + o.h);
	}
	if (x0 > x1) return;
	var gc = groupDim ? C_DIM : C_VALUE;
	setc(gc);
	mgraphics.set_line_width(1.5);
	mgraphics.rectangle_rounded(x0 - 3, y0 - 4, x1 - x0 + 6, y1 - y0 + 22, 6, 6);
	mgraphics.stroke();
	ctext(groupText.toUpperCase(), (x0 + x1) / 2, y1 + 13, 9, gc);
}

var scaleS = 1, offX = 0, offY = 0;

function paint() {
	var size = mgraphics.size;
	var w = size[0], h = size[1];
	setc(C_BG);
	mgraphics.rectangle(0, 0, w, h);
	mgraphics.fill();

	scaleS = Math.min(w / DW, h / DH);
	offX = (w - DW * scaleS) / 2;
	offY = (h - DH * scaleS) / 2;
	mgraphics.save();
	mgraphics.translate(offX, offY);
	mgraphics.scale(scaleS, scaleS);

	mgraphics.select_font_face("Arial");
	rrect(4, 4, STRIP_X - 8, DH - 8, 6, C_PANEL);
	for (var n = 0; n < N; n++) {
		rrect(STRIP_X + n * STRIP_W + 2, 4, STRIP_W - 4, DH - 8, 6, C_PANEL);
		// channel number
		ctext("" + (n + 1), STRIP_X + n * STRIP_W + STRIP_W / 2, 30, 22, C_TEXT);
	}

	if (groupText) drawGroup();

	for (var g = 0; g < groupLabels.length; g++) {
		ctext(groupLabels[g].text, groupLabels[g].cx, groupLabels[g].y, 9, C_DIM);
	}

	for (var i = 0; i < controls.length; i++) {
		var o = controls[i];
		if (o.type === "btn") drawButton(o);
		else if (o.type === "knob") drawKnob(o);
		else if (o.type === "fader") drawFader(o);
	}

	ctext(captionText.toUpperCase(), 128, 222, 10, C_DIM);
	// the mode line shrinks to fit the panel (e.g. EUCLIDEAN WINDOW - 3)
	var mtxt = modeName.toUpperCase(), msize = 22;
	mgraphics.set_font_size(msize);
	var mw = mgraphics.text_measure(mtxt)[0];
	if (mw > 236) msize = msize * 236 / mw;
	ctext(mtxt, 128, 256, msize, C_TEXT);

	mgraphics.restore();
}

// ---- mouse ----

var active = null;

function toDesign(x, y) {
	return [(x - offX) / scaleS, (y - offY) / scaleS];
}

function hit(dx, dy) {
	for (var i = 0; i < controls.length; i++) {
		var o = controls[i];
		if (dx >= o.x && dx <= o.x + o.w && dy >= o.y && dy <= o.y + o.h) return o;
	}
	return null;
}

function faderFromY(o, dy) {
	return Math.max(0, Math.min(1, (o.y + o.h - dy) / o.h));
}

function onclick(x, y, but, cmd, shift) {
	var d = toDesign(x, y);
	var o = hit(d[0], d[1]);
	if (!o) return;
	if (o.type === "btn") {
		active = { o: o };
		outlet(0, "screen", 127, o.cc);
	} else if (o.type === "knob") {
		if (knobParam[o.k] < 0) return;
		active = { o: o, y0: d[1], v0: knobParam[o.k] };
	} else if (o.type === "fader") {
		active = { o: o };
		var v = faderFromY(o, d[1]);
		faderVal[o.n] = v;
		outlet(0, "screen", v * 127, o.n);
		mgraphics.redraw();
	}
}

function ondrag(x, y, but, cmd, shift) {
	if (!active) return;
	var o = active.o;
	var d = toDesign(x, y);
	if (!but) {
		// mouse released
		if (o.type === "btn") outlet(0, "screen", 0, o.cc);
		active = null;
		return;
	}
	if (o.type === "knob") {
		var range = shift ? 600 : 150; // design pixels for the full range
		var v = Math.max(0, Math.min(1, active.v0 + (active.y0 - d[1]) / range));
		outlet(0, "screen", v * 127, 8 + o.k);
	} else if (o.type === "fader") {
		var fv = faderFromY(o, d[1]);
		faderVal[o.n] = fv;
		outlet(0, "screen", fv * 127, o.n);
		mgraphics.redraw();
	}
}

function onresize() {
	mgraphics.redraw();
}