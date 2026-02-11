# Plan: create-lecture-lecture-4-patents
**Date:** 2026-02-11 16:26
**Status:** COMPLETED
**Task:** create lecture: Lecture 4 patents (based on lecture-4-patents.qmd)

## Approach
1. Audit the base draft for structure bugs (accidental slide breaks), notation conflicts, and missing end-matter.
2. Add missing lecture scaffolding: learning objectives, roadmap, and a running application thread (pharma patents) tied to each model block.
3. Tighten model blocks to match course standards: motivation before formalism, worked example near definitions, and consistent notation.
4. Verify render + citations and then run a quick review pass (pedagogy/substance focus).

## Proposed Lecture Outline (3-Part)

1. **Motivation and instruments**
   - Why patents exist: non-rival ideas + appropriability problem
   - Policy trade-off: dynamic incentives vs static DWL
   - Running application introduced: pharmaceuticals (fixed R&D cost, generic entry after expiry)
2. **Patent length and screening (ideas model)**
   - Primitives: $(\\nu, F)$, $r$, discounted length $T$
   - Private investment condition vs planner objective
   - Worked numerical example (existing A/B slide)
3. **Breadth and races**
   - Breadth as product-space exclusion and elasticity channel
   - Endogenous R&D response to duration (Shy reduced-form model)
   - Patent races: private vs social entry thresholds + numeric region example

## Notation Decisions

- Use $\\lambda$ for the per-period DWL intensity in the ideas model to avoid conflict with $\\ell$ (Hotelling location) in earlier lectures.

## Files to Modify
- `lecture-slides/slides/lecture-4-patents.qmd`
- `.claude/rules/knowledge-base-template.md` (only if notation registry needs alignment)

## Verification
- [ ] `quarto render lecture-slides/slides/lecture-4-patents.qmd`
- [ ] Confirm `_site/lecture-slides/slides/lecture-4-patents.html` exists
- [ ] Confirm `_site/lecture-slides/slides/lecture-4-patents.pdf` exists
- [ ] Confirm no undefined citations in render output
