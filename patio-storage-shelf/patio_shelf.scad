include <BOSL2/std.scad>

// Patio Storage Shelf — Covered Patio
// 36" W × 14" D × 48" H | 4 shelves | 3/4" plywood + 2×4 lumber

// ── Parameters ───────────────────────────────────────────
width        = 36;
depth        = 14;
height       = 48;
num_shelves  = 4;

post_w       = 1.5;   // 2×2 post actual size
shelf_t      = 0.75;  // 3/4" plywood
rail_h       = 3.5;   // 2×4 actual height
rail_t       = 1.5;   // 2×4 actual thickness
panel_t      = 0.25;  // 1/4" back panel plywood
edge_r       = 0.15;  // cosmetic edge rounding

// ── Derived ──────────────────────────────────────────────
function shelf_z(i) = i * (height - shelf_t) / (num_shelves - 1);

shelf_w     = width  - 2 * post_w;
side_rail_d = depth  - 2 * post_w;
back_rail_w = width  - 2 * post_w;

// ── Modules ──────────────────────────────────────────────

module post() {
    cuboid([post_w, post_w, height], anchor=BOTTOM, rounding=edge_r, edges="Z");
}

module shelf_panel() {
    cuboid([shelf_w, depth, shelf_t], anchor=BOTTOM, rounding=edge_r, edges="Z");
}

module side_rail() {
    cuboid([post_w, side_rail_d, rail_h], anchor=BOTTOM, rounding=edge_r, edges="Z");
}

module back_rail() {
    cuboid([back_rail_w, post_w, rail_h], anchor=BOTTOM, rounding=edge_r, edges="Z");
}

// ── Assembly ─────────────────────────────────────────────

// Corner posts
for (px = [post_w/2, width - post_w/2])
    for (py = [post_w/2, depth - post_w/2])
        translate([px, py, 0]) post();

// Shelf panels (centered in inner X, full depth)
for (i = [0 : num_shelves - 1])
    translate([width/2, depth/2, shelf_z(i)])
        shelf_panel();

// Side rails under shelves 1-3 (L and R)
for (i = [1 : num_shelves - 1]) {
    sz = shelf_z(i);
    for (rx = [post_w/2, width - post_w/2])
        translate([rx, depth/2, sz - rail_h])
            side_rail();
}

// Back rails under shelves 1-3 + toe-kick at floor
for (i = [0 : num_shelves - 1]) {
    sz = (i == 0) ? 0 : shelf_z(i) - rail_h;
    if (i == 0 || i >= 1)
        translate([width/2, depth - post_w/2, sz])
            back_rail();
}

// Back panel — 1/4" ply, screwed to back of frame
translate([width/2, depth + panel_t/2, height/2])
    cuboid([width, panel_t, height]);

// ── Cut List ─────────────────────────────────────────────
// Posts  : 4× 2×2 @ 48"
// Shelves: 4× plywood 33" × 14" × 3/4"
// Rails  : 6× 2×4 @ 11"  (side rails, L+R under shelves 2-4)
//          4× 2×4 @ 33"  (back: under shelves 2-4 + floor toe-kick)
// Back   : 1× 1/4" ply 36" × 48"
