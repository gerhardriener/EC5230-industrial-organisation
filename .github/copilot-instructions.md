# Copilot Instructions for EC5230 – Industrial Organisation

These are **course-authoring rules** for EC5230 (MSc-level Industrial Organisation, University of St Andrews).
Output must be **exam-usable lecture notes**: theory-first, canonical notation, minimal but complete.

---

## Non-negotiables (always)

- **No hallucinated theory**: do **not** invent equilibrium concepts, welfare criteria, strategic effects, or non-standard terminology.
- **Textbook IO standards** only (Tirole, Vives, Shy, Cabral, Belleflamme & Peitz).
- **One primary object per slide** (model / equilibrium / intuition / comparative statics / evidence / implication).
- **Math hygiene**
  - Inline math uses `$...$`
  - Display math uses `$$ ... $$`
  - Define all symbols when first introduced
  - Classify variables: **choice**, **parameter**, **equilibrium outcome**
- **No narrative fluff**: no anecdotes; no untethered policy commentary.
- **Model-consistent examples** only (numerical examples must satisfy the model logic).

---

## Slide grammar (required structure)

Each slide must follow:

- Slide title uses `##` and **names the economic object**
- Slide body is one of: **Definition / Model / Result / Intuition / Implication**

**Do not** use rhetorical titles (“Why this matters”, “A surprising fact”, etc.).

---

## Density limits (hard)

Choose exactly one of the following patterns:

- **Bullets**: 4–10 bullets (max 12)
- **Equations**: 1–2 equations + 2–5 bullets
- **Figure**: 1-2 figure + 3–5 bullets

Hard limits per slide:

- max 12 bullets
- max 2 equations
- max 2 figure

If you exceed limits, split into multiple slides.

---

## Formatting rules (Markdown/Quarto)

- Always leave a blank line **before and after lists**.
- Keep paragraphs short; prefer bullets.
- Use consistent notation across slides; do not rename objects mid-lecture.

---

## Callout boxes (allowed, but controlled)

Callouts are permitted when they **reduce clutter** and highlight one key point.

Recommended callouts:

- `::: {.callout-note}` for definitions/assumptions
- `::: {.callout-important}` for key results/comparative statics
- `::: {.callout-warning}` for caveats (e.g., existence, knife-edge assumptions)

Rules:

- Max **one** callout per slide (exception: a second _very short_ callout if it replaces ≥2 bullets).
- Callouts must not introduce new theory: only restate/interpret what is already on the slide.

---

## Lecture endings (required)

For every **lecture slide deck**:

- **Pre-but-last slide**: `## Summary and next week`
  - Include `**Summary**` (3–6 bullets)
  - Include `**Next week:**` (3–6 bullets)

- **Last slide**: `## References`
  - Use only references / citations.
  - Keep the heading exactly `## References` so the bibliography tool can detect it.

---

## Citations, bibliography, and clickable links

- Use Pandoc citekeys in text: `[@key]` (or `Following @key` when appropriate).
- Ensure bibliographic entries include **DOI or URL when available** so students can click.
- If a CSL style is used, prefer one that prints `https://doi.org/...` when `DOI` exists, otherwise prints `URL`.

---

## University of St Andrews visual identity

### Typefaces

- Use **PT Sans** for all headings and body text.
- Secondary serif fonts only for long text blocks (avoid in slides).

### Colour palette (restricted)

Use only official colours:

**Primary**

- St Andrews Blue `#00539b`
- St Andrews Red `#ee312a`
- St Andrews Yellow `#ffdf00`
- St Andrews Black `#231f20`

**Secondary (plots only)**

- Mid Blue `#007dc5`
- Burgundy `#c60c46`
- Green `#54b948`
- Dark Green `#005953`
- Optional Purple `#7b439a`
- Optional Orange `#f5842b`

Use white generously.

---

## ggplot2 standards (R)

Use the course theme:

```r
theme_econ <- theme_minimal() + theme(
  panel.grid.major = element_line(color = "gray90"),
  panel.grid.minor = element_blank(),
  plot.title = element_text(size = 14, face = "bold"),
  axis.title = element_text(size = 11)
)
```

Rules:

- Use only St Andrews palette (≤4 colours)
- Do **not** rely on colour alone: also use linetype/shape/labels
- Must remain interpretable in grayscale

---

## TikZ diagrams

Use the template in `lecture-slides/diagram-templates.qmd` for consistency.

---

## Shiny apps (if requested)

Each app must:

- illustrate one model
- show equilibrium and formulas
- label all curves and equilibria
- use `theme_econ`

---

## File structure (conventions)

- Slides: `lecture-slides/`
- Theme: `lecture-slides/theme/`
- Apps: `shiny-apps/`
- Exercises: `exercises/`

---

## Quarto rendering

Use:

```bash
quarto preview
quarto render
```

All `.qmd` must be listed in `_quarto.yml`.

---

## Exercises (tutorial handouts)

Use the template: `exercises/exercise-template.qmd`.

Requirements:

- Provide **both** HTML and PDF outputs.
- Math delimiters must be `$` and `$$`.
- Set the **solution toggle in YAML** to `false`.
- Exercises must align with the lecture’s learning objectives.
- Include a mix of:
  - a short derivation/check question
  - a numerical computation question
  - an interpretation/comparative statics question
- Keep instructions concise and error-free.

---

## Final integrity checklist (must pass)

Before accepting output, verify:

- no hallucinated theory
- equations standard or derived later
- all symbols defined and classified
- examples consistent with equilibrium logic
- slide density and structure correct
- colours/typography compliant
- blank lines around lists
- ending slides: `## Summary and next week` then `## References`

**End of EC5230 Copilot Instructions**
