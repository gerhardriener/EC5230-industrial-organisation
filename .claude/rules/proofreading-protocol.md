---
paths:
  - "lecture-slides/**/*.qmd"
  - "quality_reports/**"
---

# Proofreading Protocol (Core)

**Rule:** Every modified lecture file must be reviewed by the `proofreader` agent before commit or PR.

---

## What the Proofreader Checks

- Grammar
- Typos
- Overflow risk
- Consistency (notation, citations, terminology)
- Academic tone

---

## Workflow (Read-Only)

1. Run `proofreader` on each modified lecture file.
2. The agent returns a report in response text (no edits).
3. Invoking workflow saves it to:

`quality_reports/[FILENAME_WITHOUT_EXT]_report.md`

---

## Apply Fixes

Edits are applied only after review/approval, and only to the approved items.
