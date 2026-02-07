---
paths:
  - "lecture-slides/figs/**/*"
  - "lecture-slides/**/*.qmd"
---

# Single Source of Truth: Enforcement Protocol

**The quarto `.qmd` and the tikz `.tex` files are the authoritative source for ALL content.** Everything else is derived.

---

## TikZ Freshness Protocol (MANDATORY)

**Before using ANY TikZ SVG in a Quarto slide, verify it matches the current source.**

### The Diff-Check Procedure

```
Step 1: Read the TikZ block from the .tex file
Step 2: Read the corresponding block from Figures/LectureN/extract_tikz.tex
Step 3: Compare EVERY coordinate, label, color, opacity, and anchor point
Step 4: If ANY difference exists → update extract_tikz.tex from Beamer → recompile → regenerate SVGs
Step 5: Only then reference the SVG in the QMD
```

### When to Re-Extract

Re-extract ALL TikZ diagrams when:

- The Beamer `.tex` file has been modified since the last extraction
- Starting a new Quarto translation
- Any TikZ-related quality issue is reported
- Before any commit that includes QMD changes

---

## Environment Parity Protocol (MANDATORY)

**Every Beamer environment MUST have a CSS equivalent before translation begins.**

Before translating ANY lecture to Quarto:

1. **Scan the Beamer source** for all custom environments
2. **Check each against your theme SCSS file**
3. **If ANY environment is missing from SCSS → create it BEFORE translating**

---

## The Single Source of Truth Chain

```
Quarto .qmd (SOURCE OF TRUTH)
  ├── extract_tikz.tex → PDF → SVGs (derived)
  ├── Quarto → HTML (derived)
  ├── Quarto → pdf (derived)
  ├── references.bib (shared)

NEVER edit derived artifacts independently.
ALWAYS propagate changes from source → derived.
```
