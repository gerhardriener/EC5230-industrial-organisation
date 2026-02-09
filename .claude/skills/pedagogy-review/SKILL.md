---
name: pedagogy-review
description: Run a pedagogical review on lecture slides (read-only).
disable-model-invocation: true
argument-hint: "[QMD or TEX filename]"
---

# Pedagogical Review Skill

**Purpose:** Run the `pedagogy-reviewer` agent and return a structured report.

---

## Steps

1. Resolve the file path from `$ARGUMENTS` (default under `lecture-slides/`).
2. Invoke `pedagogy-reviewer` with the full path.
3. Return the report in response text.

---

## Output Artifact

Invoking workflow saves to:

`quality_reports/[FILENAME_WITHOUT_EXT]_pedagogy_report.md`

---

## Notes

- Read-only review; no edits.
- For combined review, use `/slide-excellence`.
