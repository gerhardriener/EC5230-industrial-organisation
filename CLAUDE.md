# CLAUDE.MD — Academic Project Development with Claude Code

**Project:** EC5230 — Industrial Organisation (MSc-level course)
**Institution:** University of St Andrews
**Working Branch:** main

---

## Canonical Sources (No Duplication)

- `.github/copilot-instructions.md` — thin pointer to canonical `.claude/rules/` sources
- `.claude/rules/plan-first-workflow.md` — plan-first workflow and session logging
- `.claude/rules/single-source-of-truth.md` — source chain and TikZ freshness rules
- `.claude/rules/quality-gates.md` — commit/PR thresholds
- `.claude/rules/audit-report-conventions.md` — report naming, persistence, and synthesis pattern
- `.claude/rules/authoring-standards.md` — slide authoring standards
- `.claude/rules/exercise-standards.md` — exercise requirements
- `.claude/rules/exercise-quality-rubric.md` — exercise timing and scoring
- `.claude/rules/proofreading-protocol.md` — proofreading gate
- `.claude/rules/callout-box-guidelines.md` — callout usage rules
- `.claude/rules/tikz-workflow.md` — TikZ pipeline
- `.claude/rules/st-andrews-visual-identity.md` — palette and typography
- `.claude/rules/verification-protocol.md` — verification requirements

---

## Quick Reference: Skills & Agents

| Command                                     | What It Does                                                         |
| ------------------------------------------- | -------------------------------------------------------------------- |
| **Lecture Slides**                          |                                                                      |
| `/deploy [LectureN]`                        | Render Quarto slides and sync to GitHub Pages                        |
| `/extract-tikz [LectureN]`                  | TikZ diagrams to PDF to SVG with 0-based indexing                    |
| `/proofread [filename]`                     | Grammar/typo/overflow review and report                              |
| `/visual-audit [filename]`                  | Slide layout audit for overflow and consistency                      |
| `/pedagogy-review [filename]`               | Pedagogical review (read-only)                                       |
| `/review-r [file or LectureN]`              | R code review: quality, reproducibility, correctness                 |
| `/qa-quarto [LectureN]`                     | Adversarial Quarto vs Beamer QA: critic finds issues, fixer resolves |
| `/slide-excellence [filename]`              | Combined visual + pedagogical + proofreading + citation audit review |
| `/create-lecture`                           | Full lecture creation workflow                                       |
| `/devils-advocate`                          | Challenge slide design with pedagogical questions                    |
| **Exercises**                               |                                                                      |
| `/review-exercise <file>`                   | Exercise review: timing, pedagogy, solutions, clarity                |
| `/create-exercise --type --lecture --topic` | Generate new exercise from specifications with quality checks        |
| **Bibliography**                            |                                                                      |
| `/validate-bib`                             | Cross-reference citations vs bibliography file                       |

**Agents** (available for delegation):

| Agent               | Model   | Purpose                                      |
| ------------------- | ------- | -------------------------------------------- |
| `proofreader`       | inherit | Grammar, typos, overflow, consistency        |
| `slide-auditor`     | inherit | Visual layout, spacing, overflow             |
| `pedagogy-reviewer` | inherit | Narrative arc, pedagogical patterns          |
| `exercise-reviewer` | inherit | Exercise timing and pedagogical review       |
| `solution-checker`  | inherit | Mathematical correctness verification        |
| `r-reviewer`        | sonnet  | R code quality and reproducibility           |
| `tikz-reviewer`     | inherit | TikZ diagram visual quality                  |
| `beamer-translator` | opus    | Beamer->Quarto translation                    |
| `quarto-critic`     | opus    | Adversarial QA (read-only)                   |
| `quarto-fixer`      | sonnet  | Implements critic fixes                      |
| `verifier`          | inherit | Compilation and rendering checks             |
| `domain-reviewer`   | inherit | Substantive domain correctness               |

**Note:** Citation audit is built into `/slide-excellence` (not a standalone agent).

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
│   └── copilot-instructions.md       # Pointer to canonical `.claude/rules/`
├── _quarto.yml                        # Project-level Quarto config
├── _extensions/                       # Quarto extensions
│   ├── grantmcdermott/clean/         # Clean theme (Beamer)
│   └── pandoc-ext/diagram/           # Diagram filter
├── index.qmd                          # Course homepage
├── references.bib                     # Centralized bibliography
├── scripts/
│   ├── tikz2pdf.py                   # TikZ -> PDF -> SVG pipeline
│   ├── quality_score.py              # Slide quality scoring
│   └── sync_to_docs.sh               # Render and publish to gh-pages branch
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

- **You drive the theory** — provide papers, pedagogical goals, and assessment criteria.
- **Claude proposes structures** — aligned with canonical `.claude/rules/` sources.
- **Iterate together** — refine until excellent; you keep final control.
- **Devil's advocate mode** — challenge assumptions and explore alternative presentations.
- **Reference validation** — citations and claims are verified for accuracy.
- **Aesthetic and pedagogical quality** — visual clarity and teaching effectiveness matter.
- **Understanding > speed** — correctness and clarity outrank velocity.
- **Plan-first and source-of-truth** — follow `.claude/rules/plan-first-workflow.md` and `.claude/rules/single-source-of-truth.md`.

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
- Added 3 pedagogical improvements (early Socratic question on growth, full alpha notation, assumption clarifications)
- Quality score: GOOD -> EXCELLENT (teaching-ready)
- See: `quality_reports/session_logs/2026-02-08_lecture-3-review-and-fixes.md` for full details

---

## Operational Notes

- **Rendering and deployment:** Use `/deploy` or see `.claude/skills/deploy/SKILL.md`.
- **TikZ pipeline:** See `.claude/rules/tikz-workflow.md`.
- **Exercise workflow index:** `.claude/EXERCISE_WORKFLOW.md`.
- **Rendered outputs:** `_site/lecture-slides/slides/lecture-*.html` and `lecture-*.pdf`.

---

## Known Issues
