---
paths:
  - ".claude/skills/**/*.md"
  - ".claude/agents/**/*.md"
  - ".claude/rules/**/*.md"
  - "CLAUDE.md"
---

# Audit Report Conventions (Canonical)

**Purpose:** Keep all review workflows consistent for report generation, persistence, and synthesis.

---

## Execution Model

1. Review agents are read-only by default and return report content in response text.
2. The invoking skill or orchestrator persists report files in `quality_reports/`.
3. Multi-agent workflows persist component reports first, then produce one synthesized report.
4. Write-capable implementer agents may modify source files but still return review/fix reports in response text; the invoking workflow persists artifacts.

---

## Naming Placeholders

- `FILE_STEM`: input filename without extension (e.g., `lecture-3-innovation`)
- `LECTURE_ID`: lecture identifier used in QA loops (e.g., `Lecture3`)
- `ROUND`: 1-based loop iteration index

Use these placeholders consistently across skills/agents.

---

## Standard Artifact Patterns

- Single-agent review:
  - `quality_reports/[FILE_STEM]_<report_type>.md`
- Multi-agent review:
  - Component reports in `quality_reports/`
  - One synthesized report in `quality_reports/[FILE_STEM]_<workflow>_synthesis.md`
- Iterative QA loops:
  - `quality_reports/[LECTURE_ID]_qa_critic_round[ROUND].md`
  - `quality_reports/[LECTURE_ID]_qa_fixer_round[ROUND].md`
  - `quality_reports/[LECTURE_ID]_qa_final.md`

---

## Verdict Vocabulary

Use domain-appropriate verdict sets, but avoid ad-hoc variants:

- Deck/exercise synthesis:
  - `EXCELLENT / GOOD / NEEDS REVISION / POOR`
- Quarto critic loop:
  - `APPROVED / NEEDS REVISION / REJECTED`
- Solution correctness:
  - `CORRECT / MINOR ERRORS / NEEDS REVISION / INCORRECT`

`NEEDS WORK` should not be used in new or updated templates.
