---
name: review-exercise
description: Comprehensive review of exercises: timing, pedagogy, correctness, and clarity.
disable-model-invocation: true
argument-hint: "<file> [--type=live|takehome]"
---

# Exercise Review Skill

**Purpose:** Review an exercise for timing, pedagogy, correctness, and clarity.  
**Scope:** Read-only review; the invoking workflow persists reports.

---

## Parameters

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `file` | Yes | — | Path to exercise `.qmd` file |
| `--type` | No | Auto-detect | `live` (20-min) or `takehome` (60-min) |

Type auto-detect:
- `exercises/live/` → live
- `exercises/sheets/` → takehome
- Derive `FILE_STEM` from the exercise filename without extension.

---

## Review Agents (Run in Parallel)

1. **exercise-reviewer** — timing, scaffolding, alignment, difficulty
2. **solution-checker** — algebra, numerics, economic logic
3. **proofreader** — clarity and language

All agents are **read-only** and return reports in response text.

---

## Synthesis Output

Create a combined summary:

```markdown
# Exercise Review: [Filename]

## Overall Assessment: [EXCELLENT / GOOD / NEEDS REVISION / POOR]

| Dimension | Critical | Medium | Low |
|-----------|----------|--------|-----|
| Timing    |          |        |     |
| Pedagogy  |          |        |     |
| Solutions |          |        |     |
| Clarity   |          |        |     |

### Summary
- Exercise type: [Live / Take-home]
- Target time: [20 / 60 minutes]
- Estimated time: [X min] ([Y% of target])
- Solution correctness: [CORRECT / MINOR ERRORS / NEEDS REVISION]

### Critical Issues
### Medium Issues
### Recommended Actions
1. ...
2. ...
```

---

## Quality Rubric

Use the canonical rubric in `../../rules/exercise-quality-rubric.md` for:

- timing windows
- score bands
- severity interpretation

Use `../../rules/audit-report-conventions.md` for report naming and persistence pattern.

---

## Output Artifacts

Persist to `quality_reports/`:

- `[FILE_STEM]_exercise_review.md`
- `[FILE_STEM]_solution_check.md`
- `[FILE_STEM]_report.md`
- `[FILE_STEM]_exercise_synthesis.md`

---

## Error Handling

- If file not found → list closest matches in `exercises/`
- If no solutions section → skip solution-checker and warn
- If type auto-detect fails → require `--type`

---

## Related Skills

- `/create-exercise`
- `/proofread`
