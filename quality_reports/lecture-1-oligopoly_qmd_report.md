# Proofreading Report: lecture-1-oligopoly.qmd

**File:** `lecture-slides/slides/lecture-1-oligopoly.qmd`
**Date:** 2026-02-07
**Reviewer:** Claude Code (Proofreader Agent)

---

## HIGH Severity

### Issue 1: Salop date mismatch — "Salop 1985" vs actual publication
- **Location:** Line 444, slide "MFN as Self-Enforcement"
- **Current:** "Free Rider Effect in Reverse (Salop 1985)"
- **Proposed:** Change to "(Salop 1986)". The Salop chapter in Stiglitz & Mathewson (eds.) was published in 1986 (confirmed on References slide, line 556).
- **Category:** Academic Quality
- **Severity:** High

### Issue 2: Salop missing from references.bib
- **Location:** Line 444 (callout) and line 556 (References slide)
- **Current:** Salop is cited but has no entry in `references.bib` (only `salopMonopolisticCompetitionOutside1979` exists).
- **Proposed:** Add `@incollection` entry for Salop, S. C. (1986). "Practices that (Credibly) Facilitate Oligopoly Co-ordination." In Stiglitz & Mathewson (eds.), *New Developments in the Analysis of Market Structure*, Palgrave Macmillan.
- **Category:** Academic Quality
- **Severity:** High

### Issue 3: Cooper (1986) missing from references.bib
- **Location:** Line 555 (References slide)
- **Current:** Cooper, T. E. (1986) is listed manually but has no bib entry.
- **Proposed:** Add `@article` entry for Cooper, T. E. (1986). "Most-Favored-Customer Pricing and Tacit Collusion." *The RAND Journal of Economics*, 17(3), 377–388.
- **Category:** Academic Quality
- **Severity:** High

### Issue 4: Shy publication year — 1996 on slide vs 1995 in bib
- **Location:** Line 557 (References slide)
- **Current:** "Shy, O. (1996). *Industrial Organization: Theory and Applications*. MIT Press."
- **Proposed:** Change to "Shy, O. (1995)." The `references.bib` entry (`shyIndustrialOrganizationTheory1995`) lists `year = 1995`, which is the correct MIT Press first edition date.
- **Category:** Typo
- **Severity:** High

### Issue 5: Notation inconsistency — cost function $c(q_i)$ vs $c'(q_i)$ vs $c(Q/n)$
- **Location:** Lines 84, 90, 167/188
- **Current:** Line 84 uses $q_i(P - c(q_i))$, treating $c(q_i)$ as unit cost. Line 90 uses $c'(q_i)$ as marginal cost (implying $c$ is a total cost function). Lines 167/188 use $nc(Q/n)$ as total industry cost.
- **Proposed:** If $c(q_i)$ is total cost, line 84 should read $\max_{q_i} \{P(q_i + q_{-i}) \cdot q_i - c(q_i)\}$. The current form conflicts with $c'(q_i)$ as marginal cost.
- **Category:** Consistency
- **Severity:** High

### Issue 6: Welfare maximand — potential error in total cost term
- **Location:** Lines 167 and 188
- **Current:** `$n\big[P(Q)Q - nc(Q/n)\big]$` — the outer $n$ times the inner expression including $nc(Q/n)$ yields $n^2 c(Q/n)$, which is incorrect for standard Cournot welfare.
- **Proposed:** Verify against Belleflamme & Peitz, Ch. 3. The standard result weights CS by $(n-1)$ and PS by $n$. If the inner expression is meant to be per-firm profit, it should be $P(Q)(Q/n) - c(Q/n)$.
- **Category:** Academic Quality
- **Severity:** High

---

## MEDIUM Severity

### Issue 7: Duplicate section heading "Market Structures"
- **Location:** Lines 20 and 49
- **Current:** Both section dividers use `# Market Structures {background-color="#00539b"}`
- **Proposed:** Rename the second one, e.g., `# Market Power and Structure` or `# Sources of Market Power`.
- **Category:** Consistency
- **Severity:** Medium

### Issue 8: References slide mixes Quarto citation and manual bibliography
- **Location:** Lines 550–557
- **Current:** Line 552 uses `[@belleflammeIndustrialOrganizationMarkets2015]` (Quarto citation), followed by manually typed references.
- **Proposed:** Use consistent format — either all Quarto citations or all manual entries.
- **Category:** Consistency
- **Severity:** Medium

### Issue 9: Potential overflow on Alcoa slide — 6 dense bullet points
- **Location:** Lines 51–66, slide "Case: Alcoa as a Natural Monopoly"
- **Current:** Six bullet points with bold headers and substantial text, plus a callout box.
- **Proposed:** Split into two slides or condense text.
- **Category:** Overflow
- **Severity:** Medium

### Issue 10: Potential overflow on "Can Firm 1 Deviate from MFN?" slide
- **Location:** Lines 497–520
- **Current:** Three separate mathematical calculations with display equations, plus a callout box, all on one slide.
- **Proposed:** Split the derivation and conclusion into two slides.
- **Category:** Overflow
- **Severity:** Medium

### Issue 11: Potential overflow on Welfare Weights slide
- **Location:** Lines 183–199
- **Current:** Long inline math in the PS weight line risks horizontal overflow.
- **Proposed:** Break the parenthetical into a separate bullet.
- **Category:** Overflow
- **Severity:** Medium

### Issue 12: Unsourced historical claims about Alcoa
- **Location:** Lines 51–66, slide "Case: Alcoa as a Natural Monopoly"
- **Current:** Detailed historical claims (patent in 1886, Niagara Falls 1893, bauxite foreclosure) with no citation.
- **Proposed:** Add a citation (e.g., US v. Alcoa 1945, or Church & Ware 2000).
- **Category:** Academic Quality
- **Severity:** Medium

### Issue 13: No in-text citations throughout the body slides
- **Location:** Throughout (lines 20–548)
- **Current:** Claims and models presented without in-text citations.
- **Proposed:** Add citations where appropriate, e.g., `[@belleflammeIndustrialOrganizationMarkets2015, ch. 3]` for Cournot results.
- **Category:** Academic Quality
- **Severity:** Medium

---

## LOW Severity

### Issue 14: Triplicate slide title "Welfare Weights Across Market Structures"
- **Location:** Lines 183, 201, 209
- **Current:** Three consecutive slides all titled "Welfare Weights Across Market Structures"
- **Proposed:** Differentiate titles, e.g., "Welfare Weights: Overview", "...Monopoly Case", "...Oligopoly Case".
- **Category:** Consistency
- **Severity:** Low

### Issue 15: Awkward phrasing "why cannot both firms"
- **Location:** Line 375, slide "Why Coordination Fails"
- **Current:** "why cannot both firms coordinate on $(p_H, p_H)$?"
- **Proposed:** "why can both firms not coordinate on $(p_H, p_H)$?" or "why is it not possible for both firms to coordinate?"
- **Category:** Grammar
- **Severity:** Low

### Issue 16: Missing article before "mark-up rate"
- **Location:** Line 97, slide "Cournot Quantity Competition"
- **Current:** "LHS is the Lerner index (mark-up rate)"
- **Proposed:** "LHS is the Lerner index (the mark-up rate)" or remove the parenthetical.
- **Category:** Grammar
- **Severity:** Low

### Issue 17: Informal language — "deals" in scare quotes
- **Location:** Line 335/336, slide "The Coordination Challenge"
- **Current:** "Constant temptation to cheat on \"deals\""
- **Proposed:** "Constant temptation to deviate from agreements"
- **Category:** Academic Quality
- **Severity:** Low

### Issue 18: Informal first-person phrasing
- **Location:** Lines 271 and 299
- **Current:** "my optimal response is to decrease output" / "my optimal response is to raise price"
- **Proposed:** "the firm's optimal response is to decrease output" / "...to raise price"
- **Category:** Academic Quality
- **Severity:** Low

### Issue 19: Missing period at end of References slide entry
- **Location:** Line 557
- **Current:** "...Chapters 3.2, 6.1" (no trailing period)
- **Proposed:** "...Chapters 3.2, 6.1."
- **Category:** Typo
- **Severity:** Low

### Issue 20: Abrupt transition from heterogeneous to identical firms
- **Location:** Line 167, slide "Cournot Welfare Maximand"
- **Current:** Transitions from heterogeneous costs (line 143: $c_1=0, c_2=5, c_3=7$) back to identical firms without signposting.
- **Proposed:** Add a brief note such as "Returning to the symmetric case" for clarity.
- **Category:** Consistency
- **Severity:** Low

### Issue 21: PS = 0 under perfect competition is imprecise
- **Location:** Line 128, slide "Equilibrium Welfare Comparison"
- **Current:** Table shows PS = 0 under Perfect Competition.
- **Proposed:** Add footnote: "Assumes constant marginal cost" (correct only in that case; with upward-sloping MC, firms earn inframarginal rents).
- **Category:** Academic Quality
- **Severity:** Low

---

## Summary

| Category | High | Medium | Low | Total |
|----------|------|--------|-----|-------|
| Academic Quality | 3 | 2 | 3 | 8 |
| Consistency | 1 | 1 | 2 | 4 |
| Overflow | 0 | 3 | 0 | 3 |
| Grammar | 0 | 0 | 2 | 2 |
| Typo | 1 | 0 | 1 | 2 |
| **Total** | **6** | **6** | **9** | **21** |

## Priority Actions

1. **Fix notation inconsistency** in cost function (Issue 5) and verify welfare maximand formula (Issue 6)
2. **Add missing bib entries** for Salop 1986 and Cooper 1986 (Issues 2, 3)
3. **Fix Salop year** from 1985 to 1986 (Issue 1) and **Shy year** from 1996 to 1995 (Issue 4)
4. **Standardise References slide** citation format (Issue 8)
5. **Review overflow candidates** — Alcoa slide, MFN deviation slide, Welfare Weights slide (Issues 9–11)
