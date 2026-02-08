---
name: extract-tikz
description: Generate SVG diagrams from TikZ source files using scripts/tikz2pdf.py. Use when creating or updating TikZ diagrams for lecture slides.
disable-model-invocation: true
argument-hint: "[optional: specific figure name]"
---

# Generate TikZ Diagrams to SVG

Generate SVG diagrams from TikZ source files for use in Quarto RevealJS slides.

## Current TikZ Pipeline

**See [.claude/rules/tikz-workflow.md](.claude/rules/tikz-workflow.md) for the complete workflow documentation.**

### Quick Summary

- **Source files:** `lecture-slides/figs/source/*.tex` (standalone `.tex` files, one per diagram)
- **Generated SVGs:** `lecture-slides/figs/*.svg`
- **Conversion script:** `scripts/tikz2pdf.py`
- **Pipeline:** `.tex` → PDF (pdflatex) → SVG (pdftocairo)

---

## Steps

### Step 1: Verify Source Files Exist

```bash
ls -la lecture-slides/figs/source/
```

Check that:
- Target `.tex` files exist
- Each file contains a `\begin{tikzpicture}...\end{tikzpicture}` environment
- Files use standalone format (no preamble needed — script wraps them)

### Step 2: Run the Conversion Script

**From project root:**

```bash
python scripts/tikz2pdf.py
```

The script will:
1. Find all `.tex` files in `lecture-slides/figs/source/`
2. Wrap each tikzpicture in a standalone document with required packages
3. Compile to PDF using `pdflatex`
4. Convert PDF to SVG using `pdftocairo`
5. Save SVG to `lecture-slides/figs/[name].svg`
6. Clean up auxiliary files (.aux, .log, .tex wrapper)

### Step 3: Verify SVG Generation

```bash
ls -lh lecture-slides/figs/*.svg
```

Check that:
- SVG files exist for all source `.tex` files
- File sizes are reasonable (not 0 bytes, typically 5-50 KB)
- Timestamp shows they were just generated

### Step 4: Verify SVG Content (Sample Check)

Read one or two SVG files to confirm they contain valid SVG markup:

```bash
head -n 20 lecture-slides/figs/fig-innovation-replacement-effect.svg
```

Should see `<svg` tags, `<path>` elements, etc.

### Step 5: Test in Slides

If updating existing diagrams, render the affected lecture slide:

```bash
quarto render lecture-slides/slides/lecture-N-topic.qmd
```

Open the HTML output and verify diagrams display correctly.

---

## Troubleshooting

### Error: "pdflatex not found"
- Install a LaTeX distribution (TeX Live, MiKTeX, etc.)
- Ensure `pdflatex` is in PATH

### Error: "pdftocairo not found"
- Install poppler-utils: `brew install poppler` (macOS) or `apt-get install poppler-utils` (Linux)
- Windows: Download from poppler releases

### Error: "PDF not produced"
- Check the `.tex` file for LaTeX errors
- Run `pdflatex` manually on the source file to see error messages
- Common issues: missing `\usetikzlibrary{}`, wrong `pgfplots` syntax

### SVG looks wrong or incomplete
- Check that the source `.tex` file compiles correctly as PDF first
- Verify `\pgfplotsset{compat=1.18}` is compatible with your pgfplots version
- Check for font embedding issues (pdftocairo converts fonts to paths)

---

## Source of Truth

**CRITICAL:** TikZ diagrams have a SINGLE source of truth: `lecture-slides/figs/source/*.tex`

- To modify a diagram: edit the `.tex` source file, then re-run `tikz2pdf.py`
- NEVER edit the generated SVG files directly — changes will be overwritten
- For dual-format rendering (Beamer PDF + Quarto HTML), see `.claude/rules/tikz-workflow.md`

---

## Related Files

- **Conversion script:** [scripts/tikz2pdf.py](scripts/tikz2pdf.py)
- **Full workflow guide:** [.claude/rules/tikz-workflow.md](.claude/rules/tikz-workflow.md)
- **Visual quality standards:** [.claude/agents/tikz-reviewer.md](.claude/agents/tikz-reviewer.md)
