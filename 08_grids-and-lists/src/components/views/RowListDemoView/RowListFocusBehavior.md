# RowList Item Component Focus Behavior

## Available READ_ONLY Fields

| Field | Type | Description |
|-------|------|-------------|
| `focusPercent` | float | 0.0-1.0 fractional focus for this specific item |
| `rowFocusPercent` | float | 0.0-1.0 fractional focus for the entire row |
| `itemHasFocus` | boolean | Whether this item currently has focus |
| `rowHasFocus` | boolean | Whether this item's row currently has focus |
| `rowListHasFocus` | boolean | Whether the RowList has focus |
| `index` | integer | Column position within the row (0, 1, 2, ...) |
| `rowIndex` | integer | Row position (0, 1, 2, ...) |

## Same-Row Navigation (LEFT/RIGHT)

When moving from C0 to C1 within the same row:

```
focusPercent:  C0: 1.0 → 0.0 (smooth)    C1: 0.0 → 1.0 (smooth)
rowFocusPercent: 1.0 for ALL items (no change)
rowHasFocus:     true for ALL items
itemHasFocus:    false for ALL items during animation
                 (only true AFTER animation completes)
```

**Key insight**: `focusPercent` handles the entire animation. Only two items
are affected (leaving and entering). All other items stay at `focusPercent = 0`.

## Row-to-Row Navigation (UP/DOWN)

When moving from R0 C1 to R1 C0 (down):

### Leaving Row (R0)
```
focusPercent:     R0 C1: 1.0 → 0.0 (smooth, mirrors entering item)
                  Other R0 items: stays 0
rowFocusPercent:  1.0 → 0.0 for ALL items in R0
rowHasFocus:      true throughout transition
itemHasFocus:     false for ALL items
```

### Entering Row (R1)
```
focusPercent:     R1 C0: 0.0 → 1.0 (smooth, mirrors leaving item)
                  Other R1 items: stays 0
rowFocusPercent:  0.0 → 1.0 for ALL items in R1
rowHasFocus:      false throughout transition (→ true at very end)
itemHasFocus:     false for ALL items
```

**Key insight**: `focusPercent` treats cross-row navigation identically to
same-row navigation. The leaving item (R0 C1) decreases 1→0 while the
entering item (R1 C0) increases 0→1. Only these two items animate.

## Critical Findings

### 1. `focusPercent` is sufficient for scale animations
No need to use `rowFocusPercent` for per-item scale. `focusPercent` already
identifies and animates only the single focus target, for both horizontal
and vertical transitions.

### 2. `itemHasFocus` is false during ALL animations
Per the docs: "When scrolling starts, itemHasFocus for the currently focused
item is set to false. When scrolling ends, itemHasFocus for the newly focused
item is set to true." Cannot be used to identify the focus target mid-animation.

### 3. `rowFocusPercent` fires on ALL items in the row
Both entering and leaving rows receive callbacks for every item. The entering
row items all get increasing values (0→1), the leaving row items all get
decreasing values (1→0).

### 4. `rowHasFocus` lags behind the transition
The leaving row keeps `rowHasFocus = true` throughout. The entering row has
`rowHasFocus = false` until the transition completes. Can be used to
distinguish which row is entering vs leaving.

### 5. `focusPercent` identifies the focus target in any row
During row transitions, only the focus target item in the entering row gets
`focusPercent > 0`. All other items in that row have `focusPercent = 0`.
This naturally solves the "which item should scale up" problem.

## Recommended Pattern

```brighterscript
sub onFocusPercentChanged()
    focusPct = m.top.focusPercent
    scale = 1.0 + (focusPct * m.scaleFactor)
    m.top.scale = [scale, scale]
end sub
```

This single callback handles:
- Same-row focus transitions (LEFT/RIGHT)
- Cross-row focus transitions (UP/DOWN)
- Only affects the two relevant items (leaving and entering focus)
- Smooth animation in both directions

## When to Use `rowFocusPercent`

Use `rowFocusPercent` for **row-level** visual effects that should apply to
all items in a row equally, such as:
- Row opacity/dimming (fade unfocused rows)
- Row-level color shifts
- Row slide/translation effects

Do NOT use it for per-item effects like scale — `focusPercent` already
handles that correctly.
