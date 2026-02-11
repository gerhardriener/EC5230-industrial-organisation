---
paths:
  - "lecture-slides/slides/**/*.qmd"
  - "lecture-slides/figs/source/**/*.tex"
  - "scripts/**/*.R"
---

# Task Completion Verification Protocol

**At the end of every write task, Claude MUST verify the output works correctly.** This is non-negotiable.

## Scope (MANDATORY)

Verification is required when the task **creates or modifies** project artifacts, especially:

- `lecture-slides/slides/**/*.qmd`
- `lecture-slides/figs/source/**/*.tex`
- `lecture-slides/figs/**/*.svg`
- `scripts/**/*.R`
- deployment/render outputs touched by those edits

Verification is **not required** for:

- Read-only review/report tasks
- Planning-only tasks
- Purely informational tasks

For non-write tasks, report verification status as `N/A (no files modified)`.

## For Quarto HTML Slides:
1. Run render/publish script for your shell:
   - PowerShell: `pwsh -File ./scripts/sync_to_docs.ps1` (or `pwsh -File ./scripts/sync_to_docs.ps1 lecture-N-name`)
   - Bash: `./scripts/sync_to_docs.sh` (or `./scripts/sync_to_docs.sh lecture-N-name`)
2. Open rendered output in `_site/lecture-slides/slides/` and verify slide rendering visually
3. Verify referenced SVG paths resolve from the rendered HTML
4. Check for overflow by scanning dense slides
5. Verify environment parity: every custom callout/class used in QMD has a CSS equivalent
6. Report verification results

## For TikZ Source and SVGs:
1. Treat `lecture-slides/figs/source/*.tex` as the single source of truth
2. Regenerate SVGs via `python scripts/tikz2pdf.py`
3. Verify generated SVG files exist in `lecture-slides/figs/`
4. Verify SVG files contain valid XML/SVG markup (`<svg` present)
5. Re-render affected lecture slides and confirm diagrams display correctly

## For R Scripts:
1. Run `Rscript path/to/script.R`
2. Verify output files (PDF, SVG, RDS) were created with non-zero size
3. Spot-check estimates for reasonable magnitude

## Common Pitfalls:
- **PDF images in HTML**: Browsers don't render PDFs inline → convert to SVG
- **Relative paths**: verify references from `lecture-slides/slides/*.qmd` resolve in `_site/`
- **Assuming success**: Always verify output files exist AND contain correct content
- **Stale TikZ SVGs**: `.tex` source changed but SVG not regenerated

## Verification Checklist:
```
[ ] Output file created successfully
[ ] No compilation/render errors
[ ] Images/figures display correctly
[ ] Paths resolve in deployment location (_site/)
[ ] Opened in browser/viewer to confirm visual appearance
[ ] Reported results to user
```
