# Citation Audit: lecture-3-innovation.qmd

**Date:** 2026-02-09 (updated)
**Auditor:** Claude Code (Citation Audit)

---

## Summary

- **Critical issues:** 0
- **Medium issues:** 1 (Scherer reference missing from bib)
- **Low issues:** 2 (acceptable hardcoded model names)

---

## Properly Cited References (using `@key`)

| Citation Key | Line(s) | Present in `references.bib` |
|---|---|---|
| `@arrowEconomicWelfareAllocation1972` | 34, 186 | Yes |
| `@dasguptaIndustrialStructureNature1980` | 35, 41, 375, 379 | Yes |
| `@aghionCompetitionInnovationInvertedU2005` | 220 | Yes |
| `@trajtenbergWelfareAnalysisProduct1989` | 274 | Yes |
| `@gilbertPreemptivePatentingPersistence1982` | 339 | Yes |
| `@blundellMarketShareMarket1999` | 372 | Yes |
| `@acemogluMarketSizeInnovation2004` | 428 | Yes |

**All 7 citation keys resolve correctly in `references.bib`.**

---

## Hardcoded Author Names Without `@key`

| Line | Text | Severity | Recommendation |
|---|---|---|---|
| 577 | "Scherer-style inverse-U" | **MEDIUM** | Scherer has no entry in `references.bib`. Add a bib entry (e.g., Scherer 1967 *Market Structure and the Employment of Scientists and Engineers*) and use `@key`, or rephrase to avoid the name |
| 475 | "Dasgupta-Stiglitz model" | LOW | Acceptable as a model name reference (already cited on lines 35, 41, 375, 379) |
| 228 | "Aghion et al. (2005)" in `fig-alt` | LOW | Acceptable — alt text for accessibility, not rendered citation |

---

## Previous Issue (Resolved)

The prior audit flagged a redundant hardcoded "Acemoglu and Linn (2004)" on line 428. This has been fixed — the current file uses proper `@acemogluMarketSizeInnovation2004` narrative citation syntax.
