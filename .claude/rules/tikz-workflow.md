# TikZ Diagram Workflow — Single Source of Truth

**This document is the authoritative guide for creating, modifying, and deploying TikZ diagrams in this project.**

Referenced by:
- [tikz-reviewer.md](../agents/tikz-reviewer.md)
- [extract-tikz SKILL.md](../skills/extract-tikz/SKILL.md)
- [copilot-instructions.md](../../.github/copilot-instructions.md)
- [beamer-translator.md](../agents/beamer-translator.md)

---

## Overview

This project uses a **dual-format rendering pipeline** for TikZ diagrams:

- **Beamer PDF:** TikZ compiled natively via LaTeX
- **Quarto HTML:** Pre-generated SVG files

**Single Source of Truth:** `lecture-slides/figs/source/*.tex`

All modifications to diagrams MUST be made to the `.tex` source files. SVG files are generated artifacts and should NEVER be edited directly.

---

## File Locations

```
lecture-slides/
├── figs/
│   ├── source/              # TikZ source files (SINGLE SOURCE OF TRUTH)
│   │   ├── fig-innovation-replacement-effect.tex
│   │   ├── fig-innovation-drastic-threshold.tex
│   │   └── fig-innovation-inverted-u.tex
│   └── *.svg                # Generated SVG files (DO NOT EDIT)
│       ├── fig-innovation-replacement-effect.svg
│       ├── fig-innovation-drastic-threshold.svg
│       └── fig-innovation-inverted-u.svg
└── slides/
    └── lecture-3-innovation.qmd
```

---

## The TikZ Source Format

Each `.tex` file in `lecture-slides/figs/source/` contains ONLY a TikZ picture environment:

```latex
\begin{tikzpicture}
\begin{axis}[
  width=11cm, height=7cm,
  xmin=0, xmax=22,
  % ... axis options ...
]

% Plot commands, nodes, annotations

\end{axis}
\end{tikzpicture}
```

**No preamble, no `\documentclass`, no `\begin{document}`.** The conversion script wraps the tikzpicture in a standalone document automatically.

### Required Packages (Automatically Included)

The `scripts/tikz2pdf.py` script wraps each tikzpicture with:

```latex
\documentclass[tikz,border=2pt]{standalone}
\usepackage{pgfplots}
\usetikzlibrary{decorations.pathreplacing}
\pgfplotsset{compat=1.18}
```

If your diagram needs additional TikZ libraries or packages, you must:
1. Add them to the wrapper in `scripts/tikz2pdf.py`, OR
2. Use a standalone `.tex` file with full preamble and modify the extraction regex in the script

---

## Conversion Pipeline

### Step 1: Edit the Source

Modify the `.tex` file in `lecture-slides/figs/source/`:

```bash
# Example
vim lecture-slides/figs/source/fig-innovation-replacement-effect.tex
```

### Step 2: Run the Conversion Script

From the project root:

```bash
python scripts/tikz2pdf.py
```

**What it does:**

1. Finds all `.tex` files in `lecture-slides/figs/source/`
2. For each file:
   - Extracts the `\begin{tikzpicture}...\end{tikzpicture}` block
   - Wraps it in a standalone LaTeX document
   - Compiles to PDF using `pdflatex`
   - Converts PDF → SVG using `pdftocairo` (from poppler-utils)
   - Saves SVG to `lecture-slides/figs/[name].svg`
   - Cleans up auxiliary files (`.aux`, `.log`, `.tex` wrapper, optionally `.pdf`)

**Output:**

```
Found 11 TikZ source files.

[OK] lecture-slides/figs/fig-innovation-replacement-effect.svg
[OK] lecture-slides/figs/fig-innovation-drastic-threshold.svg
[OK] lecture-slides/figs/fig-innovation-inverted-u.svg
...

[OK] Generated 11 SVG diagrams.
```

### Step 3: Verify SVG Generation

```bash
ls -lh lecture-slides/figs/*.svg
```

Check:
- All expected SVG files exist
- File sizes are reasonable (5-50 KB typical)
- Timestamps are recent

### Step 4: Render Slides

```bash
quarto render lecture-slides/slides/lecture-N-topic.qmd
```

Open the HTML output and verify diagrams display correctly.

---

## Conditional Rendering in QMD Files

Quarto slides use **format-conditional blocks** to reference the correct file format for each output:

```markdown
## Slide Title

::: {.content-visible when-format="beamer"}
\resizebox{0.8\textwidth}{!}{\includestandalone{../figs/source/fig-name}}
:::

::: {.content-visible when-format="revealjs"}
![](../figs/fig-name.svg){fig-alt="Description" fig-align="center" width="70%"}
:::
```

### Format Tags

- **Beamer (PDF):** `when-format="beamer"`
  - Uses `\includestandalone{}` pointing to `.tex` source
  - LaTeX compiles the TikZ natively during PDF rendering

- **RevealJS (HTML):** `when-format="revealjs"` or `when-format="html"`
  - Uses the pre-generated `.svg` from `lecture-slides/figs/`
  - Browsers cannot render PDF inline, so SVG is required

**Both formats reference the SAME source** (the `.tex` file), but access it differently.

---

## Quality Standards

All TikZ diagrams MUST pass the `tikz-reviewer` agent standards:

### Visual Requirements

- **No label overlaps** — labels must not intersect curves, dots, or other labels
- **Geometric accuracy** — parallel lines must have identical slopes; dot alignment exact
- **Visual semantics** — solid=observed, dashed=counterfactual; filled=observed, hollow=counterfactual
- **Consistent colors** — use project palette (see `.github/copilot-instructions.md`)
- **Readable at distance** — font sizes and line weights suitable for lecture hall projection

### Code Requirements

- **Anchoring consistency** — similar labels use same anchor (e.g., all x-axis labels `anchor=north`)
- **Arrow direction** — arrows point FROM annotation TO feature
- **Whitespace balance** — no cramped regions, no excessive dead space
- **Axis ranges** — extend sufficiently beyond data points

**Review protocol:** Run `/tikz-reviewer` after ANY diagram modification. Iterate until APPROVED.

See [tikz-reviewer.md](../agents/tikz-reviewer.md) for full quality checklist.

---

## Common Issues and Solutions

### Issue: "pdflatex not found"

**Solution:** Install a LaTeX distribution:
- macOS: `brew install --cask mactex-no-gui`
- Linux: `sudo apt-get install texlive-full`
- Windows: Install MiKTeX or TeX Live

### Issue: "pdftocairo not found"

**Solution:** Install poppler-utils:
- macOS: `brew install poppler`
- Linux: `sudo apt-get install poppler-utils`
- Windows: Download from [poppler releases](https://github.com/oschwartz10612/poppler-windows/releases/)

### Issue: "PDF not produced"

**Cause:** LaTeX compilation error in the `.tex` file.

**Solution:**
1. Run `pdflatex` manually on the source to see full error log
2. Common issues:
   - Missing `\usetikzlibrary{...}` for a feature you used
   - Wrong `pgfplots` syntax
   - Unescaped special characters
   - Missing closing braces

### Issue: SVG looks wrong (fonts missing, shapes distorted)

**Cause:** Font embedding or coordinate conversion issues.

**Solution:**
1. Verify the PDF renders correctly first: compile `.tex` manually and open PDF
2. If PDF is correct but SVG is wrong: try `pdf2svg` instead of `pdftocairo`
3. Check `pgfplotsset{compat=...}` version matches your installed pgfplots

### Issue: Diagram looks different in Beamer vs Quarto

**Cause:** Different rendering engines or missing packages.

**Solution:**
1. Ensure both formats reference the SAME `.tex` source
2. Check that `\includestandalone{}` path is correct in Beamer block
3. Verify SVG was regenerated after latest `.tex` edit (check timestamp)
4. Run visual comparison via `/qa-quarto`

---

## Workflow Summary

**Creating a new diagram:**

1. Create `.tex` file in `lecture-slides/figs/source/fig-name.tex`
2. Write TikZ code (tikzpicture environment only, no preamble)
3. Run `python scripts/tikz2pdf.py`
4. Add conditional rendering blocks to QMD file
5. Run `/tikz-reviewer` and iterate until APPROVED
6. Render slides and verify both PDF and HTML outputs

**Modifying an existing diagram:**

1. Edit `.tex` file in `lecture-slides/figs/source/`
2. Run `python scripts/tikz2pdf.py` to regenerate SVG
3. Run `/tikz-reviewer` to verify changes
4. Re-render slides to verify both formats

**NEVER:**
- Edit SVG files directly (changes will be overwritten)
- Duplicate TikZ code in multiple locations
- Commit both `.tex` and PDF to git (only `.tex` and `.svg` are tracked)

---

## Git Tracking

**Tracked:**
- `lecture-slides/figs/source/*.tex` (source files)
- `lecture-slides/figs/*.svg` (generated artifacts, for deployment)

**Ignored:**
- `lecture-slides/figs/*.pdf` (temporary, regenerated from `.tex`)
- `*.aux`, `*.log`, `*.synctex.gz` (LaTeX auxiliary files)

SVG files are committed so that GitHub Pages deployment doesn't require LaTeX/poppler installation.

---

## Related Documentation

- **Visual quality standards:** [tikz-reviewer.md](../agents/tikz-reviewer.md)
- **Conversion script:** [scripts/tikz2pdf.py](../../scripts/tikz2pdf.py)
- **Extract-tikz skill:** [extract-tikz SKILL.md](../skills/extract-tikz/SKILL.md)
- **Beamer→Quarto translation:** [beamer-translator.md](../agents/beamer-translator.md)
- **Course authoring rules:** [copilot-instructions.md](../../.github/copilot-instructions.md)
