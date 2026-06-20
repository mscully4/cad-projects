include <BOSL2/std.scad>

// ── Lumber actual sizes ───────────────────────────────────────────────────────
board_t = 1.5;   // 2× nominal thickness
board_w = 3.5;   // 2×4 wide face
slat_t  = 0.75;  // 1× nominal thickness
slat_w  = 3.5;   // 1×4 wide face

// ── Chair parameters ──────────────────────────────────────────────────────────
chair_w        = 28;   // overall width
seat_h         = 14;   // floor to seat surface (front)
arm_h          = 25;   // floor to arm top surface
back_top_h     = 40;   // floor to top of back legs
seat_angle     = 12;   // seat tilt: front high, back low (degrees)
back_leg_angle = 15;   // back legs lean rearward from vertical (degrees)
arm_overhang   =  4;   // arm extends this far in front of front leg
front_leg_d    = 24;   // front-to-back span between front and back legs (at floor)

// ── Derived ───────────────────────────────────────────────────────────────────
inner_w             = chair_w - 2 * board_t;
stretcher_w         = chair_w - 2 * board_w;

// Back leg: tall single piece, foot at front_leg_d, leans rearward at back_leg_angle
back_leg_foot_y     = front_leg_d;                                  // foot Y position
back_leg_len        = back_top_h / cos(back_leg_angle);             // full length along leg
back_leg_extra      = board_w * sin(back_leg_angle);                // overshoot for flat floor cut

// Arms extend to where back leg is at arm height
arm_rear_y          = back_leg_foot_y + arm_h * tan(back_leg_angle);

wood_col = [0.76, 0.60, 0.42];
module wood() { color(wood_col) children(); }

// ── Front legs ────────────────────────────────────────────────────────────────
wood() {
    cube([board_t, board_w, arm_h]);
    translate([chair_w - board_t, 0, 0]) cube([board_t, board_w, arm_h]);
}

// // ── Back legs: angled brace, flat-cut bottom flush with floor ─────────────────
// back_leg_extra = board_w * tan(back_leg_a);
// wood()
// for (x = [board_t, chair_w - 2*board_t])
//     translate([x, back_foot_y, 0])
//     intersection() {
//         rotate([back_leg_a, 0, 0])
//             translate([0, 0, -back_leg_extra])
//             cube([board_t, board_w, back_leg_len + back_leg_extra]);
//         translate([0, -back_foot_y - board_w, 0])
//             cube([board_t, back_foot_y + board_w * 3, seat_h + 100]);
//     }

// ── Arms (front leg → back leg) ───────────────────────────────────────────────
arm_len = arm_rear_y + arm_overhang;
wood() {
    translate([0, -arm_overhang, arm_h - board_t])
        cube([board_w, arm_len, board_t]);
    translate([chair_w - board_w, -arm_overhang, arm_h - board_t])
        cube([board_w, arm_len, board_t]);
}

// ── Arm back stretcher ────────────────────────────────────────────────────────
wood()
    translate([board_w, arm_rear_y - board_w, arm_h - 2*board_t])
    cube([stretcher_w, board_w, board_t]);

// ── Back legs: tall single piece, lean rearward, flat floor cut ───────────────
// wood()
// for (x = [board_t, chair_w - 2*board_t])
//     intersection() {
//         translate([x, back_leg_foot_y, 0])
//         rotate([-back_leg_angle, 0, 0])
//         translate([0, 0, -back_leg_extra])
//             cube([board_t, board_w, back_leg_len + back_leg_extra]);
//         cube([chair_w, 200, back_top_h + 10]);
//     }

// ── Seat (solid block) ────────────────────────────────────────────────────────
// wood()
//     translate([board_t, 0, seat_h])
//     rotate([-seat_angle, 0, 0])
//     cube([inner_w, front_leg_d + board_w, slat_t]);
