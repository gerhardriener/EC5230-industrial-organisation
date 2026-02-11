---
name: pedagogy-review
description: Run a pedagogical review on lecture slides (read-only).
disable-model-invocation: true
argument-hint: "[QMD or TEX filename]"
---

# Pedagogical Review Skill

**Purpose:** Run the `pedagogy-reviewer` agent and return a structured report.
Use `.claude/rules/audit-report-conventions.md` for naming/persistence conventions.

## Positioning

- This is a **diagnostic** baseline review for narrative, pacing, and notation clarity.
- For a teaching-ready release review, use `/slide-excellence` (it already includes `pedagogy-reviewer`).
- Avoid stacking `/pedagogy-review` and `/slide-excellence` back-to-back on the same revision unless doing a focused re-check. Both persist to `quality_reports/[FILE_STEM]_pedagogy_report.md` and will overwrite.

---

## Steps

1. Resolve the file path from `$ARGUMENTS` (default under `lecture-slides/`).
2. Invoke `pedagogy-reviewer` with the full path.
3. Return the report in response text.

---

## Output Artifact

Invoking workflow saves to:

`quality_reports/[FILE_STEM]_pedagogy_report.md`

---

## Notes

- Read-only review; no edits.
- For combined review, use `/slide-excellence`.
- Use `/devils-advocate` only for a focused challenge pass after this baseline report (or when explicitly requested by the user).
