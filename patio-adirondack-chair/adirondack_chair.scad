include <BOSL2/std.scad>

// ── Lumber actual sizes ───────────────────────────────────────────────────────
board_t = 1.5;   // 2× nominal thickness
board_w = 3.5;   // 2×4 wide face
slat_t  = 0.75;  // 1× nominal thickness
slat_w  = 3.5;   // 1×4 wide face

// ── Chair parameters ──────────────────────────────────────────────────────────
chair_w      = 28;   // overall width
chair_d      = 32;   // overall depth (front to back)
seat_h       = 14;   // floor to seat surface
arm_h        = 25;   // floor to arm top surface
back_top_h   = 40;   // floor to back top
back_angle   = 20;   // back recline (degrees from vertical)
seat_angle   =  5;   // seat tilt from horizontal (front higher, back lower)
arm_overhang =  4;   // arm extends this far in front of front leg

// ── Slat counts ───────────────────────────────────────────────────────────────
seat_slat_n = 5;
back_slat_n = 4;

// ── Derived ───────────────────────────────────────────────────────────────────
inner_w      = chair_w - 2 * board_t;                                      // 25"
back_h       = back_top_h - seat_h;                                        // 26"
back_slat_span = inner_w - 2 * board_w;                                   // 18" (between stiles)
back_inner_h = back_h - 2 * board_w;                                      // 19"

seat_span  = chair_d - 2 * board_w - 2 * board_t;                         // 22.0"
slat_gap_s = (seat_span - seat_slat_n * slat_w) / (seat_slat_n - 1);     // 1.125"

slat_gap_b = (back_inner_h - back_slat_n * slat_w) / (back_slat_n - 1); // 1.667"

wood_col = [0.76, 0.60, 0.42];
module wood() { color(wood_col) children(); }

// ── Front legs (floor → arm height) ──────────────────────────────────────────
wood() {
    cube([board_t, board_w, arm_h]);
    translate([chair_w - board_t, 0, 0]) cube([board_t, board_w, arm_h]);
}

// ── Back legs (floor → arm height; back panel stiles carry the rest) ─────────
wood() {
    translate([0, chair_d - board_w, 0])
        cube([board_t, board_w, arm_h]);
    translate([chair_w - board_t, chair_d - board_w, 0])
        cube([board_t, board_w, arm_h]);
}

// ── Arms (run front-to-back, board_w wide, board_t thick) ────────────────────
wood() {
    translate([0, -arm_overhang, arm_h - board_t])
        cube([board_w, chair_d + arm_overhang, board_t]);
    translate([chair_w - board_w, -arm_overhang, arm_h - board_t])
        cube([board_w, chair_d + arm_overhang, board_t]);
}

// ── Seat assembly (pivots at front rail top; tilts back at seat_angle) ────────
module seat_assembly() {
    // local Z=0 is top of rails / bottom of slats; rails hang below at Z=-board_w
    translate([0, 0, -board_w])                          cube([inner_w, board_t, board_w]);  // front rail
    translate([0, board_t + seat_span, -board_w])        cube([inner_w, board_t, board_w]);  // rear rail
    translate([inner_w/2 - board_t/2, board_t, -board_w]) cube([board_t, seat_span, board_w]); // center support
    for (i = [0 : seat_slat_n - 1]) {
        translate([0, board_t + i * (slat_w + slat_gap_s), 0])
            cube([inner_w, slat_w, slat_t]);
    }
}

wood()
    translate([board_t, board_w, seat_h])
    rotate([-seat_angle, 0, 0])
    seat_assembly();

// ── Back panel (leans back at back_angle from vertical) ───────────────────────
module back_panel() {
    // Stiles — angle with the panel, eliminating need for separate vertical back posts
    cube([board_w, board_t, back_h]);                                                // left stile
    translate([inner_w - board_w, 0, 0]) cube([board_w, board_t, back_h]);          // right stile
    // Rails and slats span between stiles
    translate([board_w, 0, 0])               cube([back_slat_span, board_t, board_w]); // bottom rail
    translate([board_w, 0, back_h - board_w]) cube([back_slat_span, board_t, board_w]); // top rail
    for (i = [0 : back_slat_n - 1]) {
        translate([board_w, 0, board_w + i * (slat_w + slat_gap_b)])
            cube([back_slat_span, slat_t, slat_w]);
    }
}

wood()
    translate([board_t, chair_d - board_w - board_t, seat_h])
    rotate([-back_angle, 0, 0])
    back_panel();

// ── Cut list ──────────────────────────────────────────────────────────────────
// 2×4 lumber (actual 1.5"×3.5"):
//   Front legs:       2 @ 25"
//   Back legs:        2 @ 25"
//   Arms:             2 @ 36"  (32" depth + 4" overhang)
//   Front seat rail:  1 @ 25"
//   Rear seat rail:   1 @ 25"
//   Back stiles:      2 @ 26"
//   Back btm rail:    1 @ 18"
//   Back top rail:    1 @ 18"
// 1×4 lumber (actual 0.75"×3.5"):
//   Center support:   1 @ 22"
//   Seat slats:       5 @ 25"
//   Back slats:       4 @ 18"
