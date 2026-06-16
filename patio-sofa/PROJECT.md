# Patio Sofa (Loveseat)

Wooden loveseat for a covered patio. Two ∩-shaped side frames (2×4 legs + 2×4 arm), slatted seat, and a framed rectangular back panel angled 8° for comfort.

## Dimensions

| Property | Value |
|----------|-------|
| Width | 60" |
| Depth | 33" |
| Seat height | 18" |
| Arm height | 25" |
| Back height | 36" (vertical) |
| Back angle | 8° from vertical |

## Design

- **Side frames**: ∩-shaped — two 2×4 legs (3.5" face outward, 1.5" deep) connected across the top by a 2×4 arm
- **Seat**: 5 horizontal 2×4 slats spanning the full 53" inner width, supported by front/rear cross rails and a center support
- **Back**: framed rectangle (2×4 stiles, rails, slats) pivoting at seat height and leaning 8° backward

## Cut List

| Part | Material | Qty | Length |
|------|----------|-----|--------|
| Side frame legs | 2×4 | 4 | 23.5" |
| Arms (U-frame top) | 2×4 | 2 | 33" |
| Front cross rail | 2×4 | 1 | 53" |
| Rear cross rail | 2×4 | 1 | 53" |
| Center support | 2×4 | 1 | 30" |
| Seat slats | 2×4 | 5 | 53" |
| Back stiles (L+R) | 2×4 | 2 | 18" |
| Back rails (top+bot) | 2×4 | 2 | 46" |
| Back slats | 2×4 | 2 | 46" |

**2×4 total:** 4 @ 23.5" + 2 @ 33" + 2 @ 53" + 5 @ 53" + 2 @ 18" + 4 @ 46" + 1 @ 30"

## Lumber Required

All **2×4** lumber (actual 1.5"×3.5"). Total: ~781 linear inches (~65 linear feet).

| Cut | Qty | Length | Subtotal |
|-----|-----|--------|----------|
| Legs | 4 | 23.5" | 94" |
| Arms | 2 | 33" | 66" |
| Cross rails | 2 | 53" | 106" |
| Center support | 1 | 30" | 30" |
| Seat slats | 5 | 53" | 265" |
| Back stiles | 2 | 18" | 36" |
| Back rails | 2 | 46" | 92" |
| Back slats | 2 | 46" | 92" |
| **Total** | | | **781"** |

Buy **10–11 × 8' 2×4s** (accounting for kerf and layout). Or **8–9 × 10' boards** for more flexibility on the 53" cuts.

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
