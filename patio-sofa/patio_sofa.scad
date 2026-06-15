include <BOSL2/std.scad>

// ── Lumber actual sizes ──────────────────────────────────────────────────────
post_w  = 3.5;   // 4×4 actual cross-section
board_t = 1.5;   // 2× nominal thickness
board_w = 3.5;   // 2×4 wide face

// ── Sofa dimensions ──────────────────────────────────────────────────────────
sofa_width = 60;   // left-right overall
sofa_depth = 33;   // front-back overall
seat_h     = 18;   // floor to seat surface
back_h     = 36;   // floor to back top
arm_h      = 25;   // floor to arm top surface

// ── Slat counts ──────────────────────────────────────────────────────────────
seat_slat_n = 5;   // seat slats run left-right, distributed along depth
back_slat_n = 3;   // back slats run left-right, stacked vertically

// ── Derived ──────────────────────────────────────────────────────────────────
inner_w = sofa_width - 2 * post_w;   // 53"
inner_d = sofa_depth - 2 * post_w;   // 26"

front_leg_h = arm_h - board_t;       // 23.5" — arm piece sits on top
rear_leg_h  = back_h;                // 36"

// Seat rails: top of rail = seat_h - board_t (slat thickness)
seat_rail_bot = seat_h - board_t - board_w;   // 13"

// Back slat layout between lower and upper rails
back_slat_area = (back_h - board_w) - seat_h;   // 14.5"
back_slat_gap  = (back_slat_area - back_slat_n * board_w) / (back_slat_n + 1);   // 1"

// Seat slat layout along depth
seat_slat_gap = (inner_d - seat_slat_n * board_w) / (seat_slat_n + 1);   // ~1.42"

back_y = sofa_depth - post_w;   // 29.5" — front face of rear legs

wood_col = [0.76, 0.60, 0.42];

module wood() { color(wood_col) children(); }

// ── Legs ─────────────────────────────────────────────────────────────────────
wood() {
    translate([0,                   0,                   0]) cube([post_w, post_w, front_leg_h]);
    translate([sofa_width - post_w, 0,                   0]) cube([post_w, post_w, front_leg_h]);
    translate([0,                   sofa_depth - post_w, 0]) cube([post_w, post_w, rear_leg_h]);
    translate([sofa_width - post_w, sofa_depth - post_w, 0]) cube([post_w, post_w, rear_leg_h]);
}

// ── Seat frame ───────────────────────────────────────────────────────────────
wood() {
    // Side rails (front-to-back) on inside faces of left/right legs
    translate([post_w,                        post_w, seat_rail_bot]) cube([board_t, inner_d, board_w]);
    translate([sofa_width - post_w - board_t, post_w, seat_rail_bot]) cube([board_t, inner_d, board_w]);
    // Front and rear cross rails
    translate([post_w, post_w,                        seat_rail_bot]) cube([inner_w, board_t, board_w]);
    translate([post_w, sofa_depth - post_w - board_t, seat_rail_bot]) cube([inner_w, board_t, board_w]);
    // Center support rail — prevents 53" seat slat sag
    translate([sofa_width / 2 - board_t / 2, post_w, seat_rail_bot]) cube([board_t, inner_d, board_w]);
}

// ── Seat slats (left-right, distributed along depth) ─────────────────────────
wood() for (i = [0 : seat_slat_n - 1]) {
    translate([post_w,
               post_w + seat_slat_gap * (i + 1) + board_w * i,
               seat_h - board_t])
        cube([inner_w, board_w, board_t]);
}

// ── Arms ─────────────────────────────────────────────────────────────────────
wood() {
    translate([0,                   0, arm_h - board_t]) cube([post_w, sofa_depth, board_t]);
    translate([sofa_width - post_w, 0, arm_h - board_t]) cube([post_w, sofa_depth, board_t]);
}

// ── Back frame ───────────────────────────────────────────────────────────────
wood() {
    // Lower rail (top flush with seat_h)
    translate([post_w, back_y, seat_h - board_w]) cube([inner_w, board_t, board_w]);
    // Upper rail (top flush with back_h)
    translate([post_w, back_y, back_h - board_w]) cube([inner_w, board_t, board_w]);
    // Horizontal back slats
    for (i = [0 : back_slat_n - 1]) {
        translate([post_w,
                   back_y,
                   seat_h + back_slat_gap * (i + 1) + board_w * i])
            cube([inner_w, board_t, board_w]);
    }
}

// ── Cut list ─────────────────────────────────────────────────────────────────
// 4×4 lumber (actual 3.5"×3.5"):
//   Front legs:        2 @ 23.5"
//   Rear legs:         2 @ 36"
//
// 2×4 lumber (actual 1.5"×3.5"):
//   Side seat rails:   2 @ 26"
//   Front cross rail:  1 @ 53"
//   Rear cross rail:   1 @ 53"
//   Center support:    1 @ 26"
//   Arms:              2 @ 33"
//   Back lower rail:   1 @ 53"
//   Back upper rail:   1 @ 53"
//   Seat slats:        5 @ 53"
//   Back slats:        3 @ 53"
