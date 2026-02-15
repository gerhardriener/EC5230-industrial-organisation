# Visual Layout Audit: lecture-4-patents.qmd

**Date:** 2026-02-15

## Summary

| Severity | Count |
|----------|-------|
| High     | 1     |
| Medium   | 5     |
| Low      | 6     |
| Pass     | 3     |

## High Severity

1. **Slide 24 ("Symmetric patent race: setup")** — 11 content elements + callout; overflow risk. Split into two slides: setup + welfare benchmarks.

## Medium Severity

1. **Slide 15 ("Example: ideas A and B")** — inline fraction $\frac{\nu}{r}$ readability. Promote to displayed equation.
2. **Slide 18 ("Breadth–length trade-off")** — notation definitions inside callout box violates callout-box-guidelines. Move regime definitions to main slide body.
3. **Slide 21 ("Shy model: firm's choice")** — wide maximization equation may overflow horizontally. Break across two lines or define $\rho$ separately.
4. **Slide 28 ("Numerical check: duplication region")** — wide arithmetic chains in displayed equations. Use `aligned` environment.
5. **Slide 29 ("Summary and next week")** — 7 full-sentence bullets risk vertical overflow. Shorten to fragment form.
6. **Global: no diagrams** — 0 figures across 30 slides. Add 2–3 diagrams (DWL triangle, product-space breadth, patent race payoff matrix).

## Low Severity

- Slide 25: `callout-warning` used for an interpretive result, not a caveat; consider `callout-important`.
- Repetitive "Interpretation" sub-headers across 8 consecutive slides (stylistic, not incorrect).
- Minor density observations on several slides (within limits).

## Passes

- Section transition slides present and correct (5 dividers).
- No `.smaller` class or font overrides.
- No overlay/fragment/pause directives.
