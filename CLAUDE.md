# CLAUDE.MD — Academic Project Development with Claude Code

<!-- ============================================================
     HOW TO USE THIS TEMPLATE:
     1. Replace all [BRACKETED PLACEHOLDERS] with your project info
     2. Delete sections that don't apply to your project
     3. Add domain-specific sections as needed
     4. This file is read by Claude at the start of every session
     ============================================================ -->

**Last Updated:** February 2026
**Project:** EC5230 — Industrial Organisation (MSc-level course)
**Institution:** University of St Andrews
**Working Branch:** main

---

## Quick Reference: Available Skills & Agents

| Command                           | What It Does                                                         |
| --------------------------------- | -------------------------------------------------------------------- |
| `/deploy [LectureN]`              | Render Quarto slides and sync to GitHub Pages                        |
| `/extract-tikz [LectureN]`        | TikZ diagrams to PDF to SVG with 0-based indexing                    |
| `/proofread [filename]`           | Grammar/typo/overflow review and report                              |
| `/visual-audit [filename]`        | Slide layout audit for overflow and consistency                      |
| `/pedagogy-review [filename]`     | PhD-student lens: narrative, notation, pacing review                 |
| `/review-r [file or LectureN]`    | R code review: quality, reproducibility, correctness                 |
| `/qa-quarto [LectureN]`           | Adversarial Quarto vs Beamer QA: critic finds issues, fixer resolves |
| `/slide-excellence [filename]`    | Combined visual + pedagogical + proofreading review                  |
| `/translate-to-quarto [filename]` | Full Beamer to Quarto translation workflow                           |
| `/validate-bib`                   | Cross-reference citations vs bibliography file                       |
| `/devils-advocate`                | Challenge slide design with pedagogical questions                    |
| `/create-lecture`                 | Full lecture creation workflow                                       |

**Agents** (available for delegation): `proofreader`, `slide-auditor`, `pedagogy-reviewer`, `r-reviewer`, `tikz-reviewer`, `beamer-translator`, `quarto-critic`, `quarto-fixer`, `verifier`, `domain-reviewer`

**Rules** (auto-loaded): See `.claude/rules/` for domain-specific rules on LaTeX, Quarto, R, verification, proofreading, and quality gates.

---

## Project Overview

**EC5230 Industrial Organisation** is an MSc-level course at the University of St Andrews covering firm behavior in imperfectly competitive markets, strategic interactions, and industrial economics policy.

**Course structure:**

- 10 × 2-hour lectures + 5 × 1-hour tutorials
- Weeks 1–5, 7–9, 11–12 (Spring semester)
- Assessment: class test (20%), policy recommendation (5%), final exam (75%)

**Deliverables:**

- Lecture slides (HTML via RevealJS for interactive viewing, PDF via Beamer for printing)
- Take home Exercise sets with solutions
- Live Exercise sets with solution
- Interactive Shiny applications (optional)
- Comprehensive bibliography with DOI/URL links

This repository is designed for multi-platform collaboration using:

- **GitHub** for version control and cross-computer synchronization
- **Quarto** for slide rendering (HTML + PDF)
- **Claude Code** for slide development, content creation, and pedagogical refinement

---

## Folder Structure

```
EC5230-industrial-organisation/
├── CLAUDE.MD                          # This file — Claude's guide
├── .github/
│   └── copilot-instructions.md       # Course-specific authoring rules
├── _quarto.yml                        # Project-level Quarto config
├── index.qmd                          # Course homepage
├── references.bib                     # Centralized bibliography
├── lecture-slides/
│   ├── _quarto.yml                   # Subsite config (formats, templates)
│   ├── index.qmd                     # Lecture landing page
│   ├── slides/
│   │   ├── lecture-1-oligopoly.qmd
│   │   ├── lecture-2-product-differentiation.qmd
│   │   ├── lecture-3-innovation.qmd
│   │   ├── lecture-4-patents.qmd
│   │   ├── lecture-5-multistage.qmd
│   │   ├── lecture-7-cooperative-rd.qmd
│   │   ├── lecture-8-bundling.qmd
│   │   ├── lecture-9-advertising.qmd
│   │   ├── lecture-11-mergers.qmd
│   │   └── lecture-12-sustainability.qmd
│   ├── figs/
│   │   ├── source/                   # TikZ source files (.tex)
│   │   └── *.svg                     # Generated SVG diagrams
│   ├── theme/
│   │   └── st-andrews.scss          # Custom Quarto theme
│   ├── diagram-templates.qmd        # TikZ rendering helpers
│   ├── generate-diagrams.py         # TikZ → PDF → SVG pipeline
│   └── extract-tikz.py              # Extract TikZ code from diagrams
├── exercises/
│   ├── exercise-template.qmd        # Template for exercise sets
│   ├── exercises-1-oligopoly.qmd
│   └── solutions/
├── apps/                             # Optional Shiny applications
│   ├── cournot-duopoly/
│   ├── monopolist-profits/
│   └── salop-circular-city/
├── _site/                            # Rendered output (HTML + PDF)
├── quality_reports/
│   ├── plans/                        # Implementation plans
│   └── session_logs/                 # Session notes
└── master_supporting_docs/
    ├── supporting_papers/            # Academic references
    └── supporting_slides/            # Existing lecture materials
```

---

## Working Philosophy

### Collaborative Partnership Approach

Claude serves as your **collaborative partner** in developing exam-usable lecture notes:

- **You drive the theory** — provide papers, pedagogical goals, and assessment criteria
- **Claude proposes structures** — organizes content per `.github/copilot-instructions.md`
- **You iterate together** — refine until excellent
- **You maintain control** — all final decisions rest with you

### Communication Style

- **Devil's advocate mode** — challenge assumptions and explore alternative presentations
- **Reference validation** — every citation and claim verified for accuracy
- **Aesthetic excellence** — all slides should be visually compelling
- **Understanding > speed** — getting it right matters more than getting it fast

### Plan-First Approach

For any non-trivial task, Claude enters **plan mode first** before writing code:

1. **Plan** — draft approach, list files, identify risks
2. **Save** — write plan to `quality_reports/plans/` for persistence
3. **Review** — present and await your approval
4. **Implement** — only then make changes

### Single Source of Truth

**NEVER duplicate content:**

| Content       | Source of Truth                    | Derived From                     |
| ------------- | ---------------------------------- | -------------------------------- |
| Slide content | `lecture-slides/slides/*.qmd`      | Generated to HTML/PDF            |
| TikZ diagrams | `lecture-slides/figs/source/*.tex` | → SVG via `generate-diagrams.py` |
| Bibliography  | `references.bib`                   | All slides reference it          |
| Figures       | `lecture-slides/figs/`             | Deployed to `_site/`             |

> **Modify source, regenerate derived versions.**

---

## Current Project State

| Lecture              | Status     | Content                        |
| -------------------- | ---------- | ------------------------------ |
| 1: Oligopoly         | ✓ Complete | Cournot, welfare, coordination |
| 2: Differentiation   | ✓ Complete | Hotelling, Salop, free entry   |
| 3: Innovation        | —          | [To develop]                   |
| 4: Patents           | —          | [To develop]                   |
| 5: Multi-stage Games | —          | [To develop]                   |
| 7: Cooperative R&D   | —          | [To develop]                   |
| 8: Bundling          | —          | [To develop]                   |
| 9: Advertising       | —          | [To develop]                   |
| 11: Mergers          | —          | [To develop]                   |
| 12: Sustainability   | —          | [To develop]                   |

---

## Quarto Rendering Workflow

```bash
# From project root:
quarto render                          # All HTML + PDF

# Specific lecture:
cd lecture-slides
quarto render slides/lecture-2-product-differentiation.qmd

# Preview:
quarto preview lecture-slides/
```

Output: `_site/lecture-slides/slides/lecture-*.html` (RevealJS) and `lecture-*.pdf` (Beamer)

---

## St Andrews Visual Identity

**Colour palette** (from `.github/copilot-instructions.md`):

- Primary: Blue `#00539b`, Red `#ee312a`, Yellow `#ffdf00`, Black `#231f20`
- Secondary: Mid Blue `#007dc5`, Burgundy `#c60c46`, Green `#54b948`, Dark Green `#005953`

**Typography:** PT Sans for all headings and body text

---

## Quick Reference Commands

```bash
# Compile LaTeX (3-pass)
cd Slides && TEXINPUTS=../Preambles:$TEXINPUTS xelatex file.tex

# Deploy Quarto to GitHub Pages
./scripts/sync_to_docs.sh LectureN

# Run quality score
python scripts/quality_score.py Quarto/file.qmd

# Add a paper (Claude auto-splits)
cp paper.pdf master_supporting_docs/supporting_papers/
```


