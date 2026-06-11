# Claude Guidance — Patio Storage Shelf

## Rendering

Always render with `--autocenter --viewall` so the full model fits in frame:

```bash
openscad --render --autocenter --viewall -o <output>.png --imgsize=1200,900 \
  --camera=0,0,0,<rx>,0,<rz>,1 patio_shelf.scad
```

Common camera angles:

| View | rx | rz |
|------|----|----|
| Front | 90 | 0 |
| Back | 90 | 180 |
| Right side | 90 | 90 |
| Top | 0 | 0 |
| Iso front | 55 | 25 |
| Iso back | 55 | 200 |

Run multiple renders in parallel with `&` / `wait`.

## BOSL2

Installed at `~/.local/share/OpenSCAD/libraries/BOSL2/`. Include via:

```scad
include <BOSL2/std.scad>
```

Edge rounding (`rounding=`) must be less than half the smallest dimension of the object. Back panel is 0.25" thick — don't apply rounding to it.

## Conventions

- All units in inches (actual lumber sizes, not nominal)
- Parameters at top of file; derived values below
- Keep cut list comment at bottom of SCAD file in sync with any geometry changes
- PNGs are committed to git — regenerate and re-commit after any geometry changes
