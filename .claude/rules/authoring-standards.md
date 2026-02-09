---
paths:
  - "lecture-slides/**/*.qmd"
  - "lecture-slides/**/*.tex"
  - "_quarto.yml"
---

# Authoring Standards (Canonical)

**Scope:** Slide authoring rules for EC5230. This file is the single source of truth for slide structure, density, and formatting.

---

## Non-Negotiables

- **No hallucinated theory**: do not invent equilibrium concepts, welfare criteria, strategic effects, or non-standard terminology.
- **Textbook IO standards only** (Tirole, Vives, Shy, Cabral, Belleflamme & Peitz).
- **One primary object per slide** (model / equilibrium / intuition / comparative statics / evidence / implication).
- **Math hygiene**
  - Inline math uses `$...$`
  - Display math uses `$$ ... $$`
  - Define all symbols when first introduced
  - Classify variables: **choice**, **parameter**, **equilibrium outcome**
- **No narrative fluff**: no anecdotes; no untethered policy commentary.
- **Model-consistent examples** only (numerical examples must satisfy the model logic).

---

## Slide Grammar

Each slide must follow:

- Slide title uses `##` and **names the economic object**
- Slide body is one of: **Definition / Model / Result / Intuition / Implication**
- **Allowed exceptions:** Motivation / Discussion slides used to set up formal content

Avoid rhetorical titles except for explicit Motivation/Discussion slides.

---

## Density Limits (Hard)

Choose exactly one of:

- **Bullets**: 4–10 bullets (max 12)
- **Equations**: 1–2 equations + 2–5 bullets
- **Figure**: 1–2 figures + 3–5 bullets

Hard limits:

- Max 12 bullets
- Max 2 equations
- Max 2 figures

If you exceed limits, split into multiple slides.

---

## Formatting Rules (Markdown/Quarto)

- Always leave a blank line **before and after lists**.
- Keep paragraphs short; prefer bullets.
- Use consistent notation across slides; do not rename objects mid-lecture.

---

## Callout Boxes

Use the canonical rules in `.claude/rules/callout-box-guidelines.md`.

---

## Lecture Endings (Required)

For every lecture slide deck:

- **Pre-but-last slide**: `## Summary and next week`
  - Include `**Summary**` (3–6 bullets)
  - Include `**Next week:**` (3–6 bullets)
- **Last slide**: `## References`
  - Use only references / citations.
  - Keep the heading exactly `## References` so the bibliography tool can detect it.

---

## Citations, Bibliography, and Clickable Links

- Use Pandoc citekeys in text: `[@key]` (or `Following @key` when appropriate).
- Ensure bibliographic entries include **DOI or URL when available** so students can click.
- If a CSL style is used, prefer one that prints `https://doi.org/...` when `DOI` exists, otherwise prints `URL`.

---

## Visual Identity

Canonical source: `.claude/rules/st-andrews-visual-identity.md`

---

## TikZ Diagrams

Canonical source: `.claude/rules/tikz-workflow.md`

---

## Shiny Apps (If Requested)

Each app must:

- Illustrate one model
- Show equilibrium and formulas
- Label all curves and equilibria
- Use the theme defined in `.claude/rules/r-code-conventions.md`

---

## File Structure (Conventions)

- Slides: `lecture-slides/`
- Exercises: `exercises/`

---

## Quarto Rendering

- Use `quarto preview` and `quarto render`
- All `.qmd` must be listed in `_quarto.yml`

---

## Final Integrity Checklist (Must Pass)

Before accepting output, verify:

- No hallucinated theory
- Equations standard or derived later
- All symbols defined and classified
- Examples consistent with equilibrium logic
- Slide density and structure correct
- Colours/typography compliant
- Blank lines around lists
- Ending slides: `## Summary and next week` then `## References`

---

## Beamer → Quarto Translation

When translating existing Beamer slides to Quarto format, all content standards above still apply. See `.claude/agents/beamer-translator.md` for environment mapping, citation conversion, and format-specific patterns. Translated slides must preserve pedagogical flow, mathematical precision, and visual quality.
