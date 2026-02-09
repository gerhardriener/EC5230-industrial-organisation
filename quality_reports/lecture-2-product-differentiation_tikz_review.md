# TikZ Review: lecture-2-product-differentiation

## Scope
- Referenced TikZ/standalone sources:
  - `lecture-slides/figs/source/fig-hotelling-fixed-location.tex`
  - `lecture-slides/figs/source/fig-hotelling-movement-location.tex`
  - `lecture-slides/figs/source/fig-hotelling-profit-function.tex`
  - `lecture-slides/figs/source/fig-salop-cycle.tex`
  - `lecture-slides/figs/source/fig-salop-demand-comp-mon.tex`

## Render Compatibility
- Beamer render succeeded with TikZ + pgfplots headers enabled.
- No TikZ compilation failure observed in the deck build.

## Findings

### Medium
- None.

### Low
1. Label style for marginal-consumer text differs across Hotelling figures.
   - Locations:
     - `lecture-slides/figs/source/fig-hotelling-fixed-location.tex:27` (`Marginal\\consumer`)
     - `lecture-slides/figs/source/fig-hotelling-movement-location.tex:17` (`Marginal consumer`)
   - Recommendation: standardize label formatting across related figures.

2. Demand figure uses unlabeled shorthand markers (`D`, `S`) that may be ambiguous without verbal cue.
   - Location: `lecture-slides/figs/source/fig-salop-demand-comp-mon.tex:8`
   - Recommendation: use fuller labels (`Demand`, `Supply/MC`) or define on-slide.

## Checks Passed
- No obvious overdraw/clipping directives likely to break at current slide widths.
- Figure source naming is consistent with reveal SVG counterparts.

