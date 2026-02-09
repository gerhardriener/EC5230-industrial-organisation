# Citation Key Audit: lecture-3-innovation.qmd

**File:** `lecture-slides/slides/lecture-3-innovation.qmd`
**Date:** 2026-02-09
**Auditor:** Claude Code (Citation Audit)
**Lines Reviewed:** 621

---

## Executive Summary

This audit scans for hardcoded author-year citations that should use `@citationKey` syntax instead. Hardcoded citations prevent automated bibliography generation, break citation links, and create maintenance burdens.

**Findings:** 1 hardcoded citation detected (Major severity, -10 quality points)

**Status:** One fix required before deployment

---

## Hardcoded Citations Found

### Issue 1: Redundant hardcoded citation with citation key (Line 428)

- **Location:** Line 428 (inside callout box)
- **Current text:**
  ```markdown
  Acemoglu and Linn (2004) show that larger potential markets lead to more pharmaceutical innovation (new drugs/new molecular entities), consistent with models where the return to innovation rises with **scale**. [@acemogluMarketSizeInnovation2004]
  ```

- **Problem:** The sentence includes both a hardcoded "Acemoglu and Linn (2004)" AND a citation key at the end. This is redundant and violates Quarto citation conventions.

- **Suggested fix (Option 1 - Narrative citation):**
  ```markdown
  @acemogluMarketSizeInnovation2004 show that larger potential markets lead to more pharmaceutical innovation (new drugs/new molecular entities), consistent with models where the return to innovation rises with **scale**.
  ```

- **Suggested fix (Option 2 - Parenthetical citation):**
  ```markdown
  Larger potential markets lead to more pharmaceutical innovation (new drugs/new molecular entities), consistent with models where the return to innovation rises with **scale** [@acemogluMarketSizeInnovation2004].
  ```

- **Recommendation:** Use Option 1 (narrative citation) since the authors are the grammatical subject of the sentence.

- **Severity:** Major (-10 points)
- **Bib entry exists:** ✓ Yes (`acemogluMarketSizeInnovation2004`)

---

## Citations Verified as Correct

The following citations were checked and confirmed to use proper `@citationKey` or `[@citationKey]` syntax:

| Line | Citation | Type | Status |
|------|----------|------|--------|
| 34 | `[@arrowEconomicWelfareAllocation1972]` | Parenthetical | ✓ Correct |
| 41 | `[@dasguptaIndustrialStructureNature1980]` | Parenthetical | ✓ Correct |
| 186 | `[@arrowEconomicWelfareAllocation1972]` | Parenthetical | ✓ Correct |
| 220 | `@aghionCompetitionInnovationInvertedU2005` | Narrative | ✓ Correct |
| 339 | `[@gilbertPreemptivePatentingPersistence1982]` | Parenthetical | ✓ Correct |
| 372 | `@blundellMarketShareMarket1999` | Narrative | ✓ Correct |
| 379 | `@dasguptaIndustrialStructureNature1980` | Narrative | ✓ Correct |
| 399 | `[@dasguptaIndustrialStructureNature1980]` | Parenthetical (with title) | ✓ Correct |
| 428 | `[@acemogluMarketSizeInnovation2004]` | Redundant with hardcoded | ✗ Fix needed |
| 431 | `[@dasguptaIndustrialStructureNature1980]` | Parenthetical (with title) | ✓ Correct |
| 474 | `[@dasguptaIndustrialStructureNature1980]` | Implicit (slide continues from prior) | ✓ Correct |
| 489 | `[@dasguptaIndustrialStructureNature1980]` | Parenthetical | ✓ Correct |
| 536 | `[@dasguptaIndustrialStructureNature1980]` | Parenthetical | ✓ Correct |
| 565 | `[@dasguptaTheoryTechnologicalCompetition1986]` | Parenthetical (with title) | ✓ Correct |
| 582 | `[@dasguptaTheoryTechnologicalCompetition1986]` | Parenthetical (with title) | ✓ Correct |

---

## Exempt Locations (Not Counted as Violations)

The following locations contain author-year patterns but are **exempt** from the hardcoded citation rule:

### Line 228: Figure alt-text
```markdown
![](../figs/fig-innovation-inverted-u.svg){fig-alt="Inverted-U relationship between competition and innovation, after Aghion et al. (2005)" fig-align="center" width="75%"}
```

**Exempt because:** This is inside a `fig-alt` attribute (accessibility text for screen readers). The skill description explicitly exempts "figure `fig-alt` strings" from citation key requirements. Alt text should be human-readable prose, not Quarto syntax.

---

## Bibliography Verification

All citation keys used in the file were cross-referenced against `references.bib`:

| Citation Key | Bib Entry Found | Authors | Year |
|--------------|-----------------|---------|------|
| `arrowEconomicWelfareAllocation1972` | ✓ | Arrow, K. J. | 1972 |
| `dasguptaIndustrialStructureNature1980` | ✓ | Dasgupta, P.; Stiglitz, J. | 1980 |
| `aghionCompetitionInnovationInvertedU2005` | ✓ | Aghion et al. (5 authors) | 2005 |
| `gilbertPreemptivePatentingPersistence1982` | ✓ | Gilbert, R.; Newbery, D. | 1982 |
| `blundellMarketShareMarket1999` | ✓ | Blundell, R.; Griffith, R.; Van Reenen, J. | 1999 |
| `acemogluMarketSizeInnovation2004` | ✓ | Acemoglu, D.; Linn, J. | 2004 |
| `dasguptaTheoryTechnologicalCompetition1986` | ✓ | Dasgupta, P. | 1986 |
| `trajtenbergWelfareAnalysisProduct1989` | ✓ | Trajtenberg, M. | 1989 |

**All 8 unique citation keys have matching bibliography entries.**

---

## Search Methodology

The audit used multiple regex patterns to detect potential hardcoded citations:

1. **Pattern 1:** `[A-Z][a-z]+ \(1[89]\d{2}|20\d{2}\)` — Single author with year
2. **Pattern 2:** `et al\.` — Multi-author shorthand
3. **Pattern 3:** `[A-Z][a-z]+ and [A-Z][a-z]+ \(` — Two-author format

**Manual review** of all matches confirmed exemptions and validated the violation on line 428.

---

## Quality Score Impact

| Metric | Value |
|--------|-------|
| Hardcoded citations found | 1 |
| Severity | Major |
| Quality penalty | -10 points |
| Recommended action | Fix before deployment |

---

## Recommended Action

**Fix line 428** before final deployment by replacing:

```markdown
Acemoglu and Linn (2004) show that larger potential markets lead to more pharmaceutical innovation (new drugs/new molecular entities), consistent with models where the return to innovation rises with **scale**. [@acemogluMarketSizeInnovation2004]
```

With:

```markdown
@acemogluMarketSizeInnovation2004 show that larger potential markets lead to more pharmaceutical innovation (new drugs/new molecular entities), consistent with models where the return to innovation rises with **scale**.
```

This change:
- Removes redundancy
- Uses proper Quarto narrative citation syntax
- Enables automatic bibliography formatting
- Maintains identical rendered output (Quarto will format as "Acemoglu and Linn (2004)")

---

**Report saved to:** `quality_reports/lecture-3-innovation_citation_audit.md`
**Next step:** Apply the fix and re-render to verify
