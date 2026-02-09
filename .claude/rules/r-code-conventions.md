---
paths:
  - "**/*.R"
  - "lecture-slides/figs/**/*.R"
  - "scripts/**/*.R"
---

# R Code Standards

**Standard:** Senior Principal Data Engineer + PhD researcher quality

These standards apply to all R scripts in this repository.

---

## 1. Script Structure

Every script MUST follow this section layout:

```r
# ==============================================================================
# [Lecture N]: [Descriptive Title]
# ==============================================================================
#
# Author:   [Your Name]
# Source:   [Paper(s) replicated / adapted from]
#
# Purpose:
#   [2-4 sentence description]
#
# Inputs:
#   - [data source or URL]
#
# Outputs (saved to lecture-slides/figs/ or another repo-relative output folder):
#   - [file.pdf]  -- [description]
#   - [file.rds]  -- [description]
#
# Runtime: ~X min
# ==============================================================================
```

Numbered sections: 0. Setup, 1. Data/DGP, 2. Estimation, 3. Run, 4. Figures, 5. Export

## 2. Console Output Policy

**Scripts are NOT notebooks.**

- **Allowed:** `message()` for progress milestones only
- **Forbidden:** `cat()`, `print()`, ASCII banners, per-iteration output

## 3. Reproducibility

- `set.seed()` called ONCE at top (YYYYMMDD format)
- All packages loaded at top via `library()` (not `require()`)
- All paths relative to repository root
- `dir.create(..., recursive = TRUE)` for output directories

## 4. Function Design

- `snake_case` naming, verb-noun pattern
- Roxygen-style documentation
- Default parameters, no magic numbers
- Named return values (lists or tibbles)

## 5. Domain Correctness

- Verify estimator implementations match slide formulas
- Check known package bugs (document in Section 12 below)

## 6. Visual Identity

Canonical palette source: `st-andrews-visual-identity.md`
(`.claude/rules/st-andrews-visual-identity.md`)

```r
# --- St Andrews institutional palette ---
# Values below MUST match `.claude/rules/st-andrews-visual-identity.md`
primary_blue    <- "#00539b"
primary_red     <- "#ee312a"
primary_yellow  <- "#ffdf00"
primary_black   <- "#231f20"
mid_blue        <- "#007dc5"
burgundy        <- "#c60c46"
positive_green  <- "#54b948"
dark_green      <- "#005953"
accent_gray     <- "#525252"
```

### Custom Theme

```r
theme_custom <- function(base_size = 14) {
  theme_minimal(base_size = base_size) +
    theme(
      plot.title = element_text(face = "bold", color = primary_blue),
      legend.position = "bottom"
    )
}
```

### Figure Dimensions for Beamer

```r
ggsave(filepath, width = 12, height = 5, bg = "transparent")
```

## 7. RDS Data Pattern

**Heavy computations saved as RDS; slide rendering loads pre-computed data.**

```r
saveRDS(result, file.path(out_dir, "descriptive_name.rds"))
```

## 8. Code Quality Checklist

```
[ ] Header with all fields
[ ] Numbered sections
[ ] Packages at top via library()
[ ] set.seed() once at top
[ ] All paths relative
[ ] Functions documented
[ ] No cat/print output
[ ] Figures: transparent bg, explicit dimensions
[ ] RDS: every computed object saved
[ ] Comments explain WHY not WHAT
```

## 9. Common Pitfalls

| Pitfall                      | Impact                   | Prevention                 |
| ---------------------------- | ------------------------ | -------------------------- |
| Missing `bg = "transparent"` | White boxes on slides    | Always include in ggsave() |
| `cat()` for status           | Noisy stdout             | Use message() sparingly    |
| Hardcoded paths              | Breaks on other machines | Use relative paths         |
