---
name: visual-audit
description: Perform adversarial visual audit of Quarto or Beamer slides checking for overflow, font consistency, box fatigue, and layout issues.
disable-model-invocation: true
argument-hint: "[QMD filename]"
---

# Visual Audit of Slide Deck

Perform a thorough visual layout audit of a slide deck.
Use `.claude/rules/audit-report-conventions.md` for naming/persistence conventions.

## Steps

1. **Read the slide file** specified in `$ARGUMENTS`
   - Derive `FILE_STEM` from filename without extension.

2. **For Quarto (.qmd) files:**
   - Render with `quarto render lecture-slides/slides/$ARGUMENTS`
   - Open in browser to inspect each slide

3. **Audit every slide for:**

   **OVERFLOW:** Content exceeding slide boundaries
   **FONT CONSISTENCY:** Inline font-size overrides, inconsistent sizes
   **BOX FATIGUE:** More than 2 colored boxes on one slide, wrong box types
   **SPACING:** Missing negative margins, missing fig-align
   **LAYOUT:** Missing transitions, missing framing sentences, semantic colors

4. **Produce a report** organized by slide with severity and recommendations

5. **Return report text** for the invoking workflow to persist to:
   - `quality_reports/[FILE_STEM]_visual_audit.md`
6. **Follow the spacing-first principle:**
   1. Reduce vertical spacing with negative margins
   2. Consolidate lists
   3. Move displayed equations inline
   4. Reduce image/SVG size
   5. Last resort: font size reduction (never below 0.85em)
