# Plan-First Workflow (Canonical)

**Applies to:** all non-trivial tasks.

---

## Rule 1: Plan Before You Build

Enter plan mode before any non-trivial task. A task is non-trivial if it:

- Changes more than one file
- Implements a new workflow or feature
- Translates between formats (e.g., Beamer → Quarto)
- Has multiple steps or ambiguous approach

Skip plan mode only for:

- Single-file, small edits
- Running existing skills/commands
- Purely informational requests
- When user explicitly asks to proceed immediately

---

## Rule 2: Save Plans to Disk

Save plans to `quality_reports/plans/` using:

`YYYY-MM-DD_short-description.md`

Minimal plan format:

```markdown
# Plan: [Short Description]
**Date:** [YYYY-MM-DD HH:MM]
**Status:** DRAFT | APPROVED | IN PROGRESS | COMPLETED
**Task:** [User request]

## Approach
1. ...
2. ...

## Files to Modify
- path/to/file.ext

## Verification
- [ ] ...
```

---

## Rule 3: Session Logs

Session logs live at `quality_reports/session_logs/YYYY-MM-DD_description.md`.

Log entries:

- After plan approval (goal + plan summary)
- When a key decision changes
- At session end (summary + open questions)

---

## Rule 4: Avoid /clear

Do not use `/clear`. Rely on auto-compression and saved plans/logs.
