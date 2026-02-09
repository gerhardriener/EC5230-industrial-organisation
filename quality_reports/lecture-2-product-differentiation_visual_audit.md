# Visual Audit Report: lecture-2-product-differentiation.qmd

## Scope and Method
- File reviewed: `lecture-slides/slides/lecture-2-product-differentiation.qmd`
- Render checks completed:
  - `quarto render ... --to clean-revealjs` (success)
  - `quarto render ... --to beamer` (success)
- Inspection basis: source-level layout heuristics plus successful render output.

## Findings

### Medium
1. Long single-line callout sentence risks overflow on narrower projector layouts.
   - Location: `lecture-slides/slides/lecture-2-product-differentiation.qmd:277`
   - Recommendation: split into two shorter sentences or two bullets inside the callout.

2. The piecewise-profit slide is visually dense (text + multi-line equation), likely high cognitive load in live delivery.
   - Location: `lecture-slides/slides/lecture-2-product-differentiation.qmd:143`
   - Recommendation: move one branch interpretation to next slide or stage the equation reveal.

### Low
1. Some reveal figures omit `fig-alt`, reducing accessibility consistency.
   - Locations:
     - `lecture-slides/slides/lecture-2-product-differentiation.qmd:108`
     - `lecture-slides/slides/lecture-2-product-differentiation.qmd:189`
     - `lecture-slides/slides/lecture-2-product-differentiation.qmd:205`
   - Recommendation: add concise alt text to match other figure slides.

2. Mixed callout fence style (`::: callout-warning` vs `{.callout-*}`) is valid but inconsistent.
   - Locations:
     - `lecture-slides/slides/lecture-2-product-differentiation.qmd:78`
     - `lecture-slides/slides/lecture-2-product-differentiation.qmd:95`
   - Recommendation: standardize on one style for maintainability.

## Checks Passed
- No obvious box fatigue pattern (6 callouts over 29 `##` slides).
- Beamer/reveal figure pairing is complete where `content-visible` blocks are used.
- Width controls are present on all reveal figures.

