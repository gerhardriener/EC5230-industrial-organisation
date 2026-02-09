---
paths:
  - "lecture-slides/figs/**/*"
  - "lecture-slides/**/*.qmd"
---

# Single Source of Truth (Canonical)

**The Quarto `.qmd` files and TikZ source `.tex` files are authoritative.** Everything else is derived.

---

## TikZ Freshness Protocol (MANDATORY)

**Before using ANY TikZ SVG in a Quarto slide, verify it was regenerated from current source.**

### The Source Regeneration Procedure

```
Step 1: Read the TikZ block from the .tex file
Step 2: Run `python scripts/tikz2pdf.py` from repo root
Step 3: Confirm SVG exists at `lecture-slides/figs/[name].svg`
Step 4: Confirm SVG timestamp is newer than source edit
Step 5: Only then reference the SVG in the QMD
```

### When to Regenerate

Regenerate SVGs when:

- A source `.tex` file was modified
- Starting a new Quarto conversion cycle
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
  ├── lecture-slides/figs/source/*.tex (TikZ source)
  ├── scripts/tikz2pdf.py → lecture-slides/figs/*.svg (derived)
  ├── Quarto → HTML (derived)
  ├── Quarto → PDF (derived)
  ├── references.bib (shared)

NEVER edit derived artifacts independently.
ALWAYS propagate changes from source → derived.
```
