# Exercise Workflow Index

**Purpose:** Entry point for creating and reviewing exercises without duplicating rule logic.

**Last Updated:** 2026-02-09

---

## Core Commands

| Command | Purpose | Canonical Spec |
| --- | --- | --- |
| `/create-exercise` | Generate a new exercise and run quality checks | `.claude/skills/create-exercise/SKILL.md` |
| `/review-exercise <file>` | Run timing, pedagogy, and correctness review | `.claude/skills/review-exercise/SKILL.md` |
| `/proofread <file>` | Run language and clarity review only | `.claude/skills/proofread/SKILL.md` |

---

## Canonical Rules

- **Exercise rubric (single source):** `.claude/rules/exercise-quality-rubric.md`
- **Proofreading protocol:** `.claude/rules/proofreading-protocol.md`
- **Plan-first workflow:** `.claude/rules/plan-first-workflow.md`
- **General verification:** `.claude/rules/verification-protocol.md`

---

## Review Stack

| Agent | Responsibility | Output Artifact |
| --- | --- | --- |
| `exercise-reviewer` | Timing, scaffolding, alignment, difficulty progression | `*_exercise_review.md` |
| `solution-checker` | Algebra, numerics, and economic logic correctness | `*_solution_check.md` |
| `proofreader` | Grammar, clarity, and consistency | `*_report.md` |

All three agents are **read-only** and return reports in response text. The invoking workflow persists these reports into `quality_reports/`.

---

## Required Quality Gate

Use `.claude/rules/exercise-quality-rubric.md` for all evaluations.

Minimum release gate:

- Timing in at least **GOOD** band
- No unresolved **Critical** issues
- Solution correctness no worse than **MINOR ERRORS**
- Overall score **>= 80/100**

---

## Output Convention

A completed review cycle should produce:

- `quality_reports/[exercise]_exercise_review.md`
- `quality_reports/[exercise]_solution_check.md`
- `quality_reports/[exercise]_report.md`
- `quality_reports/[exercise]_exercise_synthesis.md`

---

## Notes

- This file is intentionally concise and index-like.
- Detailed procedures live in the linked skills and rule files above.