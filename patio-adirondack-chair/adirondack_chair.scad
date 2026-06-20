include <BOSL2/std.scad>

// ── Lumber actual sizes ───────────────────────────────────────────────────────
board_t = 1.5;   // 2× nominal thickness
board_w = 3.5;   // 2×4 wide face
slat_t  = 0.75;  // 1× nominal thickness
slat_w  = 3.5;   // 1×4 wide face

// ── Chair parameters ──────────────────────────────────────────────────────────
chair_w      = 28;   // overall width
seat_h       = 14;   // floor to seat surface (front)
arm_h        = 25;   // floor to arm top surface
back_top_h   = 40;   // floor to top of back posts
seat_angle   = 12;   // seat tilt: front high, back low (degrees)
arm_overhang =  4;   // arm extends this far in front of front leg
front_leg_d  = 24;   // seat depth (front leg to back leg foot)
back_leg_h   = seat_h - board_w;   // Z height where back legs meet the front legs (bottom of cross rail)

// ── Derived ───────────────────────────────────────────────────────────────────
inner_w         = chair_w - 2 * board_t;
stretcher_w     = chair_w - 2 * board_w;

// Back legs: top at front leg at seat_h, foot on ground behind seat
back_leg_foot_y = front_leg_d + board_w;      // foot Y
back_leg_a      = atan(front_leg_d / back_leg_h);
back_leg_len    = back_leg_h / cos(back_leg_a) + board_w;
back_leg_extra  = board_w * sin(back_leg_a);  // overshoot for flat floor cut

arm_rear_y  = front_leg_d;       // arms extend to back of seat area
rail_rear_y = back_leg_foot_y;   // seat rails extend to back leg foot

wood_col = [0.76, 0.60, 0.42];
module wood() { color(wood_col) children(); }

// ── Front legs ────────────────────────────────────────────────────────────────
wood() {
    cube([board_t, board_w, arm_h]);
    translate([chair_w - board_t, 0, 0]) cube([board_t, board_w, arm_h]);
}

// ── Back legs: top at front leg (seat_h), foot on ground behind chair ─────────
wood()
for (x = [0, chair_w - board_t])
    intersection() {
        translate([x, back_leg_foot_y, 0])
        rotate([back_leg_a, 0, 0])
        translate([0, 0, -back_leg_extra])
            cube([board_t, board_w, back_leg_len + back_leg_extra]);
        translate([0, board_w, 0]) cube([chair_w, 200, arm_h]);
    }

// ── Arms (front leg → back of seat area) ─────────────────────────────────────
arm_len = arm_rear_y + arm_overhang;
wood() {
    translate([0, -arm_overhang, arm_h - board_t])
        cube([board_w, arm_len, board_t]);
    translate([chair_w - board_w, -arm_overhang, arm_h - board_t])
        cube([board_w, arm_len, board_t]);
}

// ── Arm back stretcher ────────────────────────────────────────────────────────
wood()
    translate([0, arm_rear_y - board_w, arm_h - 2*board_t])
    cube([chair_w, board_w, board_t]);

// ── Front cross rail ──────────────────────────────────────────────────────────
wood()
    translate([board_t, 0, seat_h - board_w])
    cube([chair_w - 2*board_t, board_t, board_w]);

// ── Seat rails (front leg → back leg foot, horizontal, 2×4 on edge) ──────────
//wood()
//for (x = [board_t, chair_w - 2*board_t])
//    translate([x, board_w, seat_h - board_w])
//    cube([board_t, rail_rear_y - board_w, board_w]);

// ── Seat slat 1 (on top of front cross rail) ──────────────────────────────────
wood()
    translate([board_t, 0, seat_h])
    cube([chair_w - 2*board_t, slat_w, slat_t]);
