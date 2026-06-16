include <BOSL2/std.scad>

// ── Lumber actual sizes ──────────────────────────────────────────────────────
board_t = 1.5;   // 2× nominal thickness
board_w = 3.5;   // 2×4 wide face

// ── Sofa dimensions ──────────────────────────────────────────────────────────
sofa_width = 60;   // left-right overall
sofa_depth = 33;   // front-back overall
seat_h     = 18;   // floor to seat surface
back_h     = 36;   // floor to back top (vertical)
arm_h      = 25;   // floor to arm top surface
back_angle =  8;   // degrees back panel leans from vertical

// ── Slat counts ──────────────────────────────────────────────────────────────
seat_slat_n = 5;
back_slat_n = 2;

// ── Derived ──────────────────────────────────────────────────────────────────
// Legs are 2×4: board_w (3.5") wide in X, board_t (1.5") deep in Y
inner_w = sofa_width - 2 * board_w;   // 53"
inner_d = sofa_depth - 2 * board_t;   // 30"

leg_h         = arm_h - board_t;                                          // 23.5"
seat_rail_bot = seat_h - board_t - board_w;                               // 13"
back_panel_h  = back_h - seat_h;                                          // 18"
seat_slat_gap = (inner_d - seat_slat_n * board_w) / (seat_slat_n + 1);   // ~2.08"

back_slat_gap = (back_panel_h - (back_slat_n + 2) * board_w) / (back_slat_n + 1);

back_y = sofa_depth - board_t;   // 31.5" — front face of rear legs

wood_col = [0.76, 0.60, 0.42];
module wood() { color(wood_col) children(); }

// ── Side U-frame (∩): two 2×4 legs + 2×4 arm across the top ─────────────────
module u_frame() {
    cube([board_w, board_t, leg_h]);                                           // front leg
    translate([0, sofa_depth - board_t, 0]) cube([board_w, board_t, leg_h]);  // rear leg
    translate([0, 0, leg_h])                cube([board_w, sofa_depth, board_t]);  // arm
}

wood() {
    u_frame();
    translate([sofa_width - board_w, 0, 0]) u_frame();
}

// ── Seat frame ────────────────────────────────────────────────────────────────
wood() {
    translate([board_w, board_t,                        seat_rail_bot]) cube([inner_w, board_t, board_w]);
    translate([board_w, sofa_depth - board_t - board_t, seat_rail_bot]) cube([inner_w, board_t, board_w]);
    translate([sofa_width / 2 - board_t / 2, board_t,  seat_rail_bot]) cube([board_t, inner_d, board_w]);
}

// ── Seat slats (left-right, distributed along depth) ─────────────────────────
wood() for (i = [0 : seat_slat_n - 1]) {
    translate([board_w,
               board_t + seat_slat_gap * (i + 1) + board_w * i,
               seat_h - board_t])
        cube([inner_w, board_w, board_t]);
}

// ── Back panel (slatted rectangle, pivoting at seat height, angled backward) ──
module back_panel() {
    slat_w = inner_w - 2 * board_w;
    cube([board_w, board_t, back_panel_h]);
    translate([inner_w - board_w, 0, 0]) cube([board_w, board_t, back_panel_h]);
    translate([board_w, 0, 0])                    cube([slat_w, board_t, board_w]);
    translate([board_w, 0, back_panel_h - board_w]) cube([slat_w, board_t, board_w]);
    for (i = [0 : back_slat_n - 1]) {
        translate([board_w, 0, board_w + back_slat_gap * (i + 1) + board_w * i])
            cube([slat_w, board_t, board_w]);
    }
}

wood()
    translate([board_w, back_y, seat_h])
    rotate([-back_angle, 0, 0])
    back_panel();

// ── Cut list ─────────────────────────────────────────────────────────────────
// 2×4 lumber (actual 1.5"×3.5") — all parts:
//   Side frame legs:      4 @ 23.5"
//   Arms (U-frame top):   2 @ 33"
//   Front cross rail:     1 @ 53"
//   Rear cross rail:      1 @ 53"
//   Center support:       1 @ 30"
//   Seat slats:           5 @ 53"
//   Back stiles (L+R):    2 @ 18"
//   Back rails (top+bot): 2 @ 46"
//   Back slats:           2 @ 46"
