include <BOSL2/std.scad>

// ── Lumber actual sizes ──────────────────────────────────────────────────────
post_w  = 3.5;   // 4×4 actual cross-section
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
inner_w = sofa_width - 2 * post_w;   // 53"
inner_d = sofa_depth - 2 * post_w;   // 26"

leg_h         = arm_h - board_t;                                          // 23.5"
seat_rail_bot = seat_h - board_t - board_w;                               // 13"
back_panel_h  = back_h - seat_h;                                          // 18"
seat_slat_gap = (inner_d - seat_slat_n * board_w) / (seat_slat_n + 1);   // ~1.42"

// Gaps between rails and slats — subtract top+bottom rails from available height
back_slat_gap = (back_panel_h - (back_slat_n + 2) * board_w) / (back_slat_n + 1);

back_y = sofa_depth - post_w;   // 29.5" — front face of rear legs

wood_col = [0.76, 0.60, 0.42];
module wood() { color(wood_col) children(); }

// ── Side U-frame (∩): two legs + arm across the top ──────────────────────────
module u_frame() {
    cube([post_w, post_w, leg_h]);                                          // front leg
    translate([0, sofa_depth - post_w, 0]) cube([post_w, post_w, leg_h]);  // rear leg
    translate([0, 0, leg_h])               cube([post_w, sofa_depth, board_t]);  // arm
}

wood() {
    u_frame();
    translate([sofa_width - post_w, 0, 0]) u_frame();
}

// ── Seat frame ────────────────────────────────────────────────────────────────
wood() {
    // Front and rear cross rails connecting the two U-frames
    translate([post_w, post_w,                        seat_rail_bot]) cube([inner_w, board_t, board_w]);
    translate([post_w, sofa_depth - post_w - board_t, seat_rail_bot]) cube([inner_w, board_t, board_w]);
    // Center support to prevent seat slat sag across 53"
    translate([sofa_width / 2 - board_t / 2, post_w,  seat_rail_bot]) cube([board_t, inner_d, board_w]);
}

// ── Seat slats (left-right, distributed along depth) ─────────────────────────
wood() for (i = [0 : seat_slat_n - 1]) {
    translate([post_w,
               post_w + seat_slat_gap * (i + 1) + board_w * i,
               seat_h - board_t])
        cube([inner_w, board_w, board_t]);
}

// ── Back panel (slatted rectangle, pivoting at seat height, angled backward) ──
module back_panel() {
    slat_w = inner_w - 2 * board_w;   // slat/rail span between stiles
    // Left and right stiles (vertical, full panel height)
    cube([board_w, board_t, back_panel_h]);
    translate([inner_w - board_w, 0, 0]) cube([board_w, board_t, back_panel_h]);
    // Bottom and top rails (between stiles)
    translate([board_w, 0, 0])               cube([slat_w, board_t, board_w]);
    translate([board_w, 0, back_panel_h - board_w]) cube([slat_w, board_t, board_w]);
    // Horizontal slats evenly distributed between rails
    for (i = [0 : back_slat_n - 1]) {
        translate([board_w, 0, board_w + back_slat_gap * (i + 1) + board_w * i])
            cube([slat_w, board_t, board_w]);
    }
}

wood()
    translate([post_w, back_y, seat_h])
    rotate([-back_angle, 0, 0])
    back_panel();

// ── Cut list ─────────────────────────────────────────────────────────────────
// 4×4 lumber (actual 3.5"×3.5"):
//   Side frame legs:   4 @ 23.5"  (2 per side × 2 sides)
//
// 2×4 lumber (actual 1.5"×3.5"):
//   Arms (U-frame top): 2 @ 33"
//   Front cross rail:   1 @ 53"
//   Rear cross rail:    1 @ 53"
//   Center support:     1 @ 26"
//   Seat slats:         5 @ 53"
//
// Back panel (2×4 @ 8° lean):
//   Back rails (top+bot): 2 @ 53"
//   Back slats:           3 @ 53"
