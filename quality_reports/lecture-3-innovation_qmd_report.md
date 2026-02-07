# Proofreading Report: lecture-3-innovation.qmd

**File:** `lecture-slides/slides/lecture-3-innovation.qmd`
**Date:** 2026-02-07
**Reviewer:** Claude Code (Proofreader Agent)

---

## HIGH Severity

### Issue 1: Severely overloaded slide — 2 callouts, 2 equations, dense text
- **Location:** Lines 124–164, slide "Perfect competition benchmark (innovation creates rents)"
- **Current:** 4 bullet points, 2 display equations (cases environment + drastic condition), 1 explanatory paragraph, and 2 callout boxes ("Key idea (replacement effect)" and "Appropriability (important!)"). Exceeds hard limits of max 1 callout and max 2 equations per slide.
- **Proposed:** Split into at least two slides: (1) competition benchmark with innovator profit formula and drastic condition, (2) replacement effect and appropriability discussion.
- **Category:** Overflow
- **Severity:** High

### Issue 2: Slide with 4 display equations — double the limit
- **Location:** Lines 387–415, slide "Free entry and concentration"
- **Current:** Four display equation blocks (zero-profit condition, rearranged form, innovative potential definition, equilibrium concentration formula) plus a callout box.
- **Proposed:** Split into two slides: (1) free entry condition and rearrangement, (2) innovative potential and equilibrium concentration result with callout.
- **Category:** Overflow
- **Severity:** High

---

## MEDIUM Severity

### Issue 3: Slide with 3 display equations exceeds limit
- **Location:** Lines 100–122, slide "Monopoly benchmark (exclusive access before and after)"
- **Current:** Three display equations (maximisation problem, solution, WTP formula) plus a callout box.
- **Proposed:** Split into two slides: one for the monopoly problem and solution, one for WTP calculation and interpretation.
- **Category:** Overflow
- **Severity:** Medium

### Issue 4: Slide with 3 display equations exceeds limit
- **Location:** Lines 362–385, slide "Dasgupta-Stiglitz (1980): symmetric oligopoly"
- **Current:** Three display equation blocks plus 3 groups of bullet points.
- **Proposed:** Move the elasticity definition inline, or split into "setup" and "equilibrium conditions" slides.
- **Category:** Overflow
- **Severity:** Medium

### Issue 5: Empirical slide uses different formatting from other empirical slides
- **Location:** Lines 184–188, slide "Empirical example: competition and innovation"
- **Current:** Starts with orphan line "Inverted-U evidence (QJE)" followed by bare paragraph with `@aghionCompetitionInnovationInvertedU2005`. The other three empirical slides (lines 228, 314, 358) all use a `::: {.callout-note title="..."}` box.
- **Proposed:** Wrap in a callout matching the other empirical slides.
- **Category:** Consistency
- **Severity:** Medium

### Issue 6: Summary and next-week content on separate slides
- **Location:** Lines 453–465
- **Current:** Summary on slide "## Summary" (line 453), next-week preview on separate slide "## Next week: patents and IPRs" (line 460).
- **Proposed:** Combine into a single slide titled "## Summary and next week" with subsections.
- **Category:** Consistency
- **Severity:** Medium

### Issue 7: Notation ambiguity — generic $c$ not clearly linked to $c_0$/$c_1$
- **Location:** Line 93 (setup slide) and line 105 (monopoly benchmark)
- **Current:** Line 93 says "Constant marginal cost $c$" as standalone bullet, then line 94 introduces $c_0$ and $c_1$. Monopoly benchmark uses generic $c$ without connecting to specific cost levels.
- **Proposed:** Clarify on line 93: "Constant marginal cost $c \in \{c_0, c_1\}$" or "Initially at marginal cost $c_0$".
- **Category:** Consistency
- **Severity:** Medium

---

## LOW Severity

### Issue 8: Inconsistent citation format — bare `@key` vs `[@key]`
- **Location:** Line 187 uses bare `@aghionCompetitionInnovationInvertedU2005`; lines 159, 229, 315, 359 use parenthetical `[@key]`.
- **Proposed:** Use `[@aghionCompetitionInnovationInvertedU2005]` for consistency, or ensure all empirical slides use the same narrative approach.
- **Category:** Consistency
- **Severity:** Low

### Issue 9: Redundant inline DOI in callout text (3 instances)
- **Location:** Lines 229, 315, 359 (empirical example slides)
- **Current:** DOI strings included alongside `[@key]` citations.
- **Proposed:** Remove inline DOIs — they are already in `references.bib` and will render automatically in the bibliography.
- **Category:** Consistency
- **Severity:** Low

### Issue 10: Abbreviation "v" should be "vs." or "versus"
- **Location:** Line 462, slide "Next week: patents and IPRs"
- **Current:** "Patents as incentives: monopoly rights v dynamic efficiency"
- **Proposed:** "Patents as incentives: monopoly rights vs. dynamic efficiency"
- **Category:** Typo
- **Severity:** Low

### Issue 11: Missing article "the" before "demand elasticity"
- **Location:** Line 380, slide "Dasgupta-Stiglitz (1980): symmetric oligopoly"
- **Current:** "is demand elasticity"
- **Proposed:** "is the demand elasticity."
- **Category:** Grammar
- **Severity:** Low

### Issue 12: Missing full stop at end of sentence
- **Location:** Line 380
- **Current:** No period after "is demand elasticity"
- **Proposed:** Add period.
- **Category:** Typo
- **Severity:** Low

### Issue 13: Rhetorical slide title "Why innovation is central in IO"
- **Location:** Line 23
- **Proposed:** "Innovation as a margin of competition" (name the economic object, not a rhetorical question).
- **Category:** Consistency
- **Severity:** Low

### Issue 14: Rhetorical slide title "Two-way relationship to keep in mind"
- **Location:** Line 61
- **Proposed:** "Two-way relationship: market structure and innovation"
- **Category:** Consistency
- **Severity:** Low

### Issue 15: Rhetorical slide title "Why Dasgupta-Stiglitz matters"
- **Location:** Line 320
- **Proposed:** "Dasgupta-Stiglitz (1980): endogenous R&D and market structure"
- **Category:** Consistency
- **Severity:** Low

---

## Summary

| Category | High | Medium | Low | Total |
|----------|------|--------|-----|-------|
| Overflow | 2 | 2 | 0 | 4 |
| Consistency | 0 | 3 | 5 | 8 |
| Grammar | 0 | 0 | 1 | 1 |
| Typo | 0 | 0 | 2 | 2 |
| **Total** | **2** | **5** | **8** | **15** |

## Priority Actions

1. **Split overloaded slides** — "Perfect competition benchmark" (Issue 1) and "Free entry and concentration" (Issue 2) both far exceed equation/callout limits
2. **Split 3-equation slides** — "Monopoly benchmark" (Issue 3) and "Dasgupta-Stiglitz" (Issue 4)
3. **Standardise empirical slide format** — one of four uses bare text instead of callout box (Issue 5)
4. **Combine Summary and Next Week** into single slide (Issue 6)
5. **Clarify cost notation** — connect generic $c$ to $c_0$/$c_1$ in setup (Issue 7)
