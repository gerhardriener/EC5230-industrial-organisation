---
paths:
  - "exercises/**/*.qmd"
  - ".claude/agents/exercise-reviewer.md"
  - ".claude/skills/create-exercise/SKILL.md"
  - ".claude/skills/review-exercise/SKILL.md"
  - ".claude/EXERCISE_WORKFLOW.md"
---

# Exercise Quality Rubric (Canonical)

**Purpose:** Single source of truth for exercise timing bands, score bands, severity, and release gate.

---

## Targets

- **Live exercises:** 20 minutes target
- **Take-home exercises:** 60 minutes target

---

## Timing Bands

### Live (20-minute target)

- **EXCELLENT:** 18-22 minutes (90-110%)
- **GOOD:** 15-25 minutes (75-125%)
- **NEEDS REVISION:** 12-30 minutes (60-150%)
- **POOR:** <12 or >30 minutes

### Take-home (60-minute target)

- **EXCELLENT:** 54-66 minutes (90-110%)
- **GOOD:** 48-72 minutes (80-120%)
- **NEEDS REVISION:** 40-85 minutes (67-142%)
- **POOR:** <40 or >85 minutes

---

## Score Bands

| Score | Rating | Meaning |
| --- | --- | --- |
| 85-100 | EXCELLENT | Teaching-ready with minimal or no edits |
| 70-84 | GOOD | Minor revisions recommended |
| 50-69 | NEEDS REVISION | Significant fixes required |
| <50 | POOR | Major restructuring required |

---

## Severity Interpretation

- **Critical:** Incorrect math/logic, missing solutions, or prerequisite gaps that block use
- **Medium:** Fixable clarity, pacing, or consistency issues that materially affect quality
- **Low:** Style and polish improvements

---

## Minimum Gate for Release

Before presenting an exercise as ready:

- Timing at least **GOOD**
- Solution correctness: **CORRECT** or **MINOR ERRORS**
- No unresolved **Critical** issues
- Overall score **>= 80/100**
