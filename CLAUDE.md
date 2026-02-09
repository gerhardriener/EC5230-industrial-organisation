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

| Command                                     | What It Does                                                         |
| ------------------------------------------- | -------------------------------------------------------------------- |
| **Lecture Slides**                          |                                                                      |
| `/deploy [LectureN]`                        | Render Quarto slides and sync to GitHub Pages                        |
| `/extract-tikz [LectureN]`                  | TikZ diagrams to PDF to SVG with 0-based indexing                    |
| `/proofread [filename]`                     | Grammar/typo/overflow review and report                              |
| `/visual-audit [filename]`                  | Slide layout audit for overflow and consistency                      |
| `/pedagogy-review [filename]`               | PhD-student lens: narrative, notation, pacing review                 |
| `/review-r [file or LectureN]`              | R code review: quality, reproducibility, correctness                 |
| `/qa-quarto [LectureN]`                     | Adversarial Quarto vs Beamer QA: critic finds issues, fixer resolves |
| `/slide-excellence [filename]`              | Combined visual + pedagogical + proofreading + citation audit review |
| `/translate-to-quarto [filename]`           | Full Beamer to Quarto translation workflow                           |
| `/create-lecture`                           | Full lecture creation workflow                                       |
| `/devils-advocate`                          | Challenge slide design with pedagogical questions                    |
| **Exercises**                               |                                                                      |
| `/review-exercise <file>`                   | Comprehensive exercise review: timing, pedagogy, solutions, clarity  |
| `/create-exercise --type --lecture --topic` | Generate new exercise from specifications with quality checks        |
| **Bibliography**                            |                                                                      |
| `/validate-bib`                             | Cross-reference citations vs bibliography file                       |

**Agents** (available for delegation):

| Agent               | Model   | Purpose                               |
| ------------------- | ------- | ------------------------------------- |
| `proofreader`       | inherit | Grammar, typos, overflow, consistency |
| `slide-auditor`     | inherit | Visual layout, spacing, overflow      |
| `pedagogy-reviewer` | inherit | Narrative arc, pedagogical patterns   |
| `r-reviewer`        | sonnet  | R code quality and reproducibility    |
| `tikz-reviewer`     | inherit | TikZ diagram visual quality           |
| `beamer-translator` | opus    | Beamer→Quarto translation             |
| `quarto-critic`     | opus    | Adversarial QA (read-only)            |
| `quarto-fixer`      | sonnet  | Implements critic fixes               |
| `verifier`          | inherit | Compilation and rendering checks      |
| `domain-reviewer`   | inherit | Substantive domain correctness        |

**Note:** Citation audit is built into the `/slide-excellence` skill (not a standalone agent).

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
├── CLAUDE.md                          # This file — Claude's guide
├── README.md
├── .github/
│   └── copilot-instructions.md       # Course-specific authoring rules
├── _quarto.yml                        # Project-level Quarto config
├── _extensions/                       # Quarto extensions
│   ├── grantmcdermott/clean/         # Clean theme (Beamer)
│   └── pandoc-ext/diagram/           # Diagram filter
├── index.qmd                          # Course homepage
├── references.bib                     # Centralized bibliography
├── scripts/
│   ├── tikz2pdf.py                   # TikZ → PDF → SVG pipeline
│   ├── quality_score.py              # Slide quality scoring
│   └── sync_to_docs.sh              # Render and publish to gh-pages branch
├── lecture-slides/
│   ├── index.qmd                     # Lecture landing page
│   ├── slides/
│   │   ├── lecture-0-intro.qmd
│   │   ├── lecture-1-oligopoly.qmd
│   │   ├── lecture-2-product-differentiation.qmd
│   │   ├── lecture-3-innovation.qmd
│   │   ├── lecture-4-patents.qmd
│   │   ├── lecture-5-repeated-games.qmd
│   │   └── lecture-6-corporate-rand.qmd
│   └── figs/
│       ├── source/                   # TikZ source files (.tex)
│       └── *.svg                     # Generated SVG diagrams
├── exercises/
│   ├── index.qmd                     # Exercises landing page
│   ├── sheets/
│   │   └── exercises-1.qmd
│   └── live/
│       └── live-exercise-1.qmd
├── apps/                              # Interactive Shiny applications
│   ├── cournot-duopoly/
│   ├── monopolist-profits/
│   ├── salop-circular-city/
│   ├── profit-possibility-cournot/
│   └── _original/                    # Original standalone R scripts
├── guide/
│   └── workflow-guide.qmd            # Development workflow guide
├── docs/                              # GitHub Pages deployment
├── _site/                             # Rendered output (HTML + PDF)
└── quality_reports/
    ├── plans/                         # Implementation plans
    └── session_logs/                  # Session notes
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

| Content       | Source of Truth                    | Derived From                    |
| ------------- | ---------------------------------- | ------------------------------- |
| Slide content | `lecture-slides/slides/*.qmd`      | Generated to HTML/PDF           |
| TikZ diagrams | `lecture-slides/figs/source/*.tex` | → SVG via `scripts/tikz2pdf.py` |
| Bibliography  | `references.bib`                   | All slides reference it         |
| Figures       | `lecture-slides/figs/`             | Deployed to `_site/`            |

> **Modify source, regenerate derived versions.**

---

## Current Project State

| Lecture            | Status     | Content                        | Last Updated |
| ------------------ | ---------- | ------------------------------ | ------------ |
| 0: Introduction    | ✓ Complete | Course overview                | —            |
| 1: Oligopoly       | ✓ Complete | Cournot, welfare, coordination | —            |
| 2: Differentiation | ✓ Complete | Hotelling, Salop, free entry   | —            |
| 3: Innovation      | ✓ Complete | Arrow, D-S, replacement effect | 2026-02-08   |
| 4: Patents         | —          | [To develop]                   | —            |
| 5: Repeated Games  | —          | [To develop]                   | —            |
| 6: Corporate R&D   | —          | [To develop]                   | —            |

**Recent Quality Improvements (Lecture 3, 2026-02-08):**

- Fixed 4 critical issues (TikZ compilation, overlapping fills, grammar, citations)
- Fixed 6 major issues (dense derivation split, TikZ visual clarity, disconnected labels)
- Added 3 pedagogical improvements (early Socratic question on growth, full α notation, assumption clarifications)
- Quality score: GOOD → EXCELLENT (teaching-ready)
- See: `quality_reports/session_logs/2026-02-08_lecture-3-review-and-fixes.md` for full details

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
# Generate SVGs from TikZ source files
python scripts/tikz2pdf.py

# Deploy Quarto to GitHub Pages
quarto publish gh-pages --no-browser

# Render specific lecture (PDF + HTML)
quarto render lecture-slides/slides/lecture-N-name.qmd

# Run quality score
python scripts/quality_score.py lecture-slides/slides/lecture-N-name.qmd
```

---

## Known Issues
