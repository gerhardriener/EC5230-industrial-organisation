---
name: create-tikz
description: Create TikZ diagrams from natural-language prompts and integrate them into lecture slides. Handles the full pipeline from prompt to rendered SVG embedded in QMD.
argument-hint: "<description of diagram> [--lecture <filename>] [--slide <slide-title>]"
---

# Create TikZ Diagram from Prompt

Create publication-quality TikZ diagrams from natural-language descriptions and integrate them into the course slide pipeline.

**Canonical reference:** `../../rules/tikz-workflow.md`

---

## CONSTRAINTS (Non-Negotiable)

1. **Source format:** Output a bare `\begin{tikzpicture}...\end{tikzpicture}` block — no preamble, no `\documentclass`, no `\begin{document}`.
2. **Available packages:** Only those in `scripts/tikz2pdf.py` wrapper: `pgfplots`, `decorations.pathreplacing`, `pgfplotsset{compat=1.18}`. If the diagram needs additional libraries, add them to the wrapper script first.
3. **Color palette:** Use St Andrews visual identity colors from `../../rules/st-andrews-visual-identity.md`:
   - St Andrews Blue: `{rgb,255:red,0;green,83;blue,155}` (define as `\definecolor{staBlue}{RGB}{0,83,155}`)
   - St Andrews Red: `{rgb,255:red,238;green,49;blue,42}` (define as `\definecolor{staRed}{RGB}{238,49,42}`)
   - Mid Blue: `{rgb,255:red,0;green,125;blue,197}` (define as `\definecolor{staMidBlue}{RGB}{0,125,197}`)
   - Green: `{rgb,255:red,84;green,185;blue,72}` (define as `\definecolor{staGreen}{RGB}{84,185,72}`)
   - For fills, use 15–25% opacity variants (e.g., `staBlue!20`).
4. **Naming convention:** `fig-<lecture-topic>-<description>.tex` (e.g., `fig-patents-dwl-triangle.tex`).
5. **Single source of truth:** Write only to `lecture-slides/figs/source/`. Never edit SVGs directly.
6. **Projection readability:** Minimum font `\small` for labels; prefer `\normalsize` for key annotations. Line widths `thick` or `very thick` for primary elements.
7. **Lecture-hall legibility:** `width=11cm, height=7cm` as default axis dimensions (adjust proportionally for panels).
8. **Visual semantics:** solid = observed/actual, dashed = counterfactual/reference; filled dots = observed, hollow = counterfactual.

---

## INPUTS

Parse `$ARGUMENTS` for:

- `<description>`: Natural-language description of the diagram (required).
- `--lecture <filename>`: QMD file to embed the diagram in (optional; e.g., `lecture-4-patents`).
- `--slide <slide-title>`: Target slide title for insertion (optional).

If `--lecture` is provided, resolve to `lecture-slides/slides/<filename>.qmd`.

---

## WORKFLOW

### Step 1: Design the Diagram

Before writing any TikZ code:

1. **Identify the economic concept** — what relationship, trade-off, or mechanism is being visualised?
2. **Determine diagram type:**
   - Axis plot (supply/demand, profit functions, comparative statics)
   - Game tree or payoff matrix
   - Spatial diagram (Hotelling line, Salop circle, product space)
   - Number line / region diagram (threshold comparisons)
   - Schematic / flow diagram
3. **List all elements:** curves, regions, labels, arrows, annotations.
4. **Decide on coordinates and scale** — compute key intersection points algebraically before coding.
5. **Check existing diagrams** for style consistency:
   ```bash
   ls lecture-slides/figs/source/
   ```
   Read 1–2 existing `.tex` files to match axis style, label conventions, and color usage.

### Step 2: Write the TikZ Source

Create the `.tex` file in `lecture-slides/figs/source/`:

**Template for axis-based diagrams:**

```latex
\begin{tikzpicture}
\begin{axis}[
  width=11cm, height=7cm,
  xmin=0, xmax=<VALUE>,
  ymin=0, ymax=<VALUE>,
  axis lines=left,
  axis line style={thick, ->},
  ticks=none,
  clip=false,
  xlabel={$Q$},
  ylabel={$P$},
  xlabel style={at={(axis description cs:1.02,0.02)}, anchor=west},
  ylabel style={at={(axis description cs:0.02,1.02)}, anchor=south},
]

% === Define colors (inside tikzpicture) ===
\definecolor{staBlue}{RGB}{0,83,155}
\definecolor{staRed}{RGB}{238,49,42}
\definecolor{staGreen}{RGB}{84,185,72}

% === Parameters ===
\pgfmathsetmacro{\paramA}{...}

% === Curves ===
% === Regions (fills BEFORE labels) ===
% === Labels (AFTER fills to ensure visibility) ===
% === Dashed guidelines ===

\end{axis}
\end{tikzpicture}
```

**Template for non-axis diagrams (game trees, number lines, etc.):**

```latex
\begin{tikzpicture}[
  every node/.style={font=\small},
  thick
]

\definecolor{staBlue}{RGB}{0,83,155}
\definecolor{staRed}{RGB}{238,49,42}
\definecolor{staGreen}{RGB}{84,185,72}

% === Diagram elements ===

\end{tikzpicture}
```

**Coding rules:**

- Define all parameters with `\pgfmathsetmacro` — no magic numbers in coordinates.
- Draw fills BEFORE labels so labels render on top.
- Use `fill=white, fill opacity=0.85, text opacity=1, inner sep=2pt` for labels over shaded regions.
- Use consistent anchoring for similar labels (e.g., all x-axis labels `anchor=north`).
- Add comments for each section (`% === Curves ===`, `% === Labels ===`, etc.).

### Step 3: Compile and Generate SVG

```bash
python scripts/tikz2pdf.py
```

Verify:

```bash
ls -lh lecture-slides/figs/<fig-name>.svg
```

Check that:

- SVG file exists and is non-zero (typically 5–50 KB).
- Timestamp is recent.

### Step 4: Run tikz-reviewer

Delegate to the `tikz-reviewer` agent:

> Review the TikZ diagram at `lecture-slides/figs/source/<fig-name>.tex` for visual quality.

**Iterate until the reviewer returns APPROVED.** Fix every CRITICAL and MAJOR issue before proceeding.

### Step 5: Embed in QMD (if `--lecture` provided)

Insert dual-format conditional rendering blocks at the target slide:

```markdown
::: {.content-visible when-format="beamer"}
\resizebox{0.8\textwidth}{!}{\includestandalone{../figs/source/<fig-name>}}
:::

::: {.content-visible when-format="revealjs"}
![](../figs/<fig-name>.svg){fig-alt="<description>" fig-align="center" width="70%"}
:::
```

**Placement rules:**

- Insert after the slide title and any introductory text.
- If the slide already has content, place the figure after the first motivating bullet and before interpretation bullets.
- Adjust `width` for RevealJS: use `70%` for full-width diagrams, `50%` for side-by-side panels.

### Step 6: Render and Verify

```bash
quarto render lecture-slides/slides/<lecture-file>.qmd --to clean-revealjs
```

Confirm:

- No render errors or warnings.
- Open the HTML output and verify the diagram displays correctly.
- Check that text, labels, and regions are legible.

---

## DIAGRAM TYPE RECIPES

### Monopoly / DWL Diagram

Key elements: demand curve, cost lines, profit rectangle ($\pi\nu$), DWL triangle ($\lambda\nu$), consumer surplus region.

- Use `\addplot` with `fill=staBlue!20` for profit, `fill=staRed!20` for DWL.
- Label with arrows: `\draw[->, staBlue, thick]` pointing from annotation to region.

### Number-Line / Threshold Diagram

Key elements: horizontal line with marked thresholds, shaded regions, labels above/below.

```latex
\draw[thick, ->] (0,0) -- (10,0) node[right] {$f$};
\fill[staRed!20] (3,0) rectangle (7,0.5);  % shaded region
\draw[thick, staBlue] (3,-0.1) -- (3,0.6) node[above] {$f_2^{\text{publ}}$};
\draw[thick, staRed] (7,-0.1) -- (7,0.6) node[above] {$f_2^{\text{priv}}$};
```

### 2x2 Payoff Matrix

Key elements: grid lines, row/column headers, payoff pairs in cells.

```latex
\draw (0,0) grid (4,4);
\node at (1,3) {payoff pair};
% Row headers left, column headers top
```

### Product-Space Diagram (Hotelling line, Salop circle)

Follow existing examples in `fig-hotelling-*.tex` and `fig-salop-*.tex` for style conventions.

### Comparative Statics / Function Plot

Key elements: curve with labelled shifts, tangent lines, marked equilibria.

- Use `domain=...` in `\addplot` for function plotting.
- Mark equilibria with `\node[circle, fill, inner sep=2pt]`.

---

## TROUBLESHOOTING

| Problem | Solution |
|---------|----------|
| `pdflatex` not found | Install TeX Live or MiKTeX; ensure `pdflatex` is in PATH |
| `pdftocairo` not found | Install poppler-utils (`brew install poppler` / `apt install poppler-utils`) |
| PDF not produced | Run `pdflatex` manually to see full error log; check for missing libraries |
| SVG looks wrong | Verify PDF is correct first; check `pgfplotsset{compat=1.18}` |
| Labels overlap | Fix coordinates; re-run tikz-reviewer |
| Need additional TikZ library | Add `\usetikzlibrary{...}` to `scripts/tikz2pdf.py` wrapper, then re-run |

---

## EXAMPLES

### Example 1: Simple DWL diagram

```
/create-tikz Monopoly diagram showing profit rectangle (pi*nu) and DWL triangle (lambda*nu) under patent protection --lecture lecture-4-patents --slide "Ideas model (Scotchmer): private returns and deadweight loss"
```

### Example 2: Number-line threshold diagram

```
/create-tikz Number line showing the socially excessive duplication region between f_2^publ and f_2^priv --lecture lecture-4-patents --slide "Socially excessive R&D (region)"
```

### Example 3: Standalone diagram (no embedding)

```
/create-tikz Hotelling line with two firms at endpoints, showing consumer indifference point
```

---

## RELATED FILES

- **TikZ workflow (canonical):** [tikz-workflow.md](../../rules/tikz-workflow.md)
- **Conversion script:** [scripts/tikz2pdf.py](../../../scripts/tikz2pdf.py)
- **TikZ reviewer agent:** [tikz-reviewer.md](../../agents/tikz-reviewer.md)
- **Extract-tikz skill:** [extract-tikz/SKILL.md](../extract-tikz/SKILL.md)
- **Visual identity:** [st-andrews-visual-identity.md](../../rules/st-andrews-visual-identity.md)
- **Existing TikZ sources:** `lecture-slides/figs/source/*.tex`
