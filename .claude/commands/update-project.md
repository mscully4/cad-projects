Update PROJECT.md for the specified sub-project directory to reflect current model state. If no directory is given in $ARGUMENTS, infer from context.

## What PROJECT.md must contain

Every PROJECT.md has these sections in this order:

### 1. Title + one-line description
`# Project Name` followed by a single sentence: what the piece is, material, key distinguishing features.

### 2. `## Dimensions`
Markdown table: Property | Value. Cover all top-level SCAD parameters (overall width/depth/height, seat height, arm height, back angle, etc.). Values include units (").

### 3. `## Design`
Bullet list describing structural approach: frame type, joinery style, slat layout, anything non-obvious from dimensions alone.

### 4. `## Cut List`
Table: Part | Material | Qty | Length. Derived from the cut list comment at the bottom of the .scad file. Keep in sync — if the comment changed, the table changes too.

Below the table: one summary line grouping by lumber type, e.g.:
`**2×4 total:** 4 @ 23.5" + 2 @ 33" + ...`

### 5. `## Lumber Required`
One sentence naming lumber type(s) and total linear inches/feet.

Table: Cut | Qty | Length | Subtotal — same rows as cut list but grouped/simplified if helpful.

Final row: **Total** with summed linear inches.

Closing line: recommended board count at standard stock lengths (8' and/or 10'), accounting for kerf and layout waste (~10%).

### 6. `## Notes`
Bullet list of build gotchas, parameter tuning tips, structural rationale. Anything a builder needs beyond the cut list.

### 7. `## Files`
Bullet list of every file in the directory: .scad file with one-line description, each .png with its view name. Do not list files that don't exist on disk.

---

## How to update

1. Read the current PROJECT.md
2. Read the .scad file — extract top-level parameters, derived values, and the cut list comment
3. List actual files in the directory (`ls`)
4. Rewrite any section that is stale or missing; leave accurate sections alone
5. Recalculate Lumber Required from scratch using the current cut list
6. Commit the updated PROJECT.md with a short message

$ARGUMENTS
