# Patio Sofa (Loveseat)

Wooden loveseat for a covered patio. Two ∩-shaped side frames (4×4 legs + 2×4 arm), slatted seat, and a framed rectangular back panel angled 8° for comfort.

## Dimensions

| Property | Value |
|----------|-------|
| Width | 60" |
| Depth | 33" (seat area; back extends ~3" beyond) |
| Seat height | 18" |
| Arm height | 25" |
| Back height | 36" (vertical) |
| Back angle | 8° from vertical |

## Design

- **Side frames**: ∩-shaped — two 4×4 legs connected across the top by a 2×4 arm
- **Seat**: 5 horizontal 2×4 slats spanning the full 53" inner width, supported by front/rear cross rails and a center support
- **Back**: framed rectangle (2×4 stiles, rails, slats) pivoting at seat height and leaning 8° backward

## Cut List

| Part | Material | Qty | Length |
|------|----------|-----|--------|
| Side frame legs | 4×4 | 4 | 23.5" |
| Arms (U-frame top) | 2×4 | 2 | 33" |
| Front cross rail | 2×4 | 1 | 53" |
| Rear cross rail | 2×4 | 1 | 53" |
| Center support | 2×4 | 1 | 26" |
| Seat slats | 2×4 | 5 | 53" |
| Back stiles (L+R) | 2×4 | 2 | 18" |
| Back rails (top+bot) | 2×4 | 2 | 46" |
| Back slats | 2×4 | 2 | 46" |

**4×4 total:** 4 @ 23.5"

**2×4 total:** 2 @ 33" + 3 @ 53" + 5 @ 53" + 2 @ 18" + 4 @ 46" + 1 @ 26"

## Notes

- All dimensions are actual lumber sizes (not nominal)
- Seat slats span 53" width; center support rail prevents sag
- Back panel pivots at seat height; adjust `back_angle` in SCAD to change recline
- Back panel inner span is 46" (53" minus two 3.5" stiles)

## Files

- `patio_sofa.scad` — parametric OpenSCAD model (requires [BOSL2](https://github.com/BelfrySCAD/BOSL2))
- `front.png` — front view
- `back.png` — back view
- `side_right.png` — right side view
- `top.png` — top view
- `iso_front.png` — isometric front view
- `iso_back.png` — isometric back view
