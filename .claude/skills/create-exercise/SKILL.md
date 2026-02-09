---
name: create-exercise
description: Generate new live or take-home exercises with solutions and quality review.
disable-model-invocation: true
argument-hint: "--type=live|takehome --lecture=N --topic=\"...\""
---

# Create Exercise Skill

**Purpose:** Create a new exercise (live or take-home), draft solutions, and run quality review.

---

## Parameters

| Parameter      | Required | Description                                    | Example                         |
| -------------- | -------- | ---------------------------------------------- | ------------------------------- |
| `--type`       | Yes      | Exercise type: `live` or `takehome`            | `live`                          |
| `--lecture`    | Yes      | Lecture number(s) to reinforce                 | `3` or `1,2,3`                  |
| `--topic`      | Yes      | Main topic/concept                             | `"Cournot with cost asymmetry"` |
| `--difficulty` | No       | Target difficulty (routine/standard/challenge) | `standard`                      |
| `--extensions` | No       | Optional extensions/twists                     | `"Add free entry condition"`    |

---

## Core Workflow

### 1. Plan (required)

Follow the plan-first workflow in `.claude/rules/plan-first-workflow.md`:

- Read relevant lecture slides for notation and examples.
- Define learning objectives and scope.
- Plan sub-questions and timing estimates.
- Identify likely student errors.
- Save the plan to `quality_reports/plans/YYYY-MM-DD_exercise-[type]-[topic].md`.
- Present plan for approval before drafting.
- Initialize plan/session logging helper:
  - `python scripts/workflow_log.py init --task "create exercise: $ARGUMENTS" --slug "exercise-$ARGUMENTS"`

### 2. Draft Exercise File

Create the exercise in:

- Live: `exercises/live/live-exercise-N.qmd`
- Take-home: `exercises/sheets/exercises-N.qmd`

Requirements:

- Set `solutions: false` in YAML.
- Use `{.content-hidden unless-meta="solutions"}` for solution blocks.
- Use clear instruction verbs: Derive/Compute/Show/Explain.
- Align notation with lecture slides.

### 3. Draft Solutions

- Step-by-step derivations (no jumps).
- Include numerical checks where possible.
- Add brief economic interpretation after key results.

### 4. Review and Fix

Run `/review-exercise` and address critical issues. Re-run until:

- Overall score >= 80/100
- No Critical issues
- Solution correctness: CORRECT or MINOR ERRORS
- Append key fix decisions while iterating:
  - `python scripts/workflow_log.py append --slug "exercise-$ARGUMENTS" --note "<fix applied>"`

### 5. Render and Index

- Render both student and instructor versions with:
  - PowerShell: `pwsh -File ./scripts/render_exercises.ps1`
  - Bash: `./scripts/render_exercises.sh`
- Update `exercises/index.qmd` with link and short description.
- Provide summary: file path, time estimate, key concepts.
- Close workflow log:
  - `python scripts/workflow_log.py close --slug "exercise-$ARGUMENTS" --summary "exercise created and reviewed"`

---

## Minimal Templates

### Live Exercise (20 minutes)

```markdown
---
title: "Live Exercise N: [Topic]"
format:
  html:
    toc: false
    embed-resources: true
    number-sections: false
  pdf:
    documentclass: article
    fontsize: 11pt
    geometry: margin=1in
    number-sections: false
solutions: false
---

::: {.content-hidden unless-meta="solutions"}
# Solutions
:::

**Group exercise (approx. 15-20 minutes)**

## Problem: [Title]
[Setup paragraph]

### (a) ...
### (b) ...
### (c) ...

::: {.content-hidden unless-meta="solutions"}
## Suggested solution (sketch)
### (a) ...
:::
```

### Take-Home Exercise (60 minutes)

```markdown
---
title: "Exercise N: [Topic]"
format:
  html:
    toc: false
    embed-resources: true
    number-sections: false
  pdf:
    documentclass: article
    fontsize: 11pt
    geometry: margin=1in
    number-sections: false
solutions: false
---

::: {.content-hidden unless-meta="solutions"}
# Solutions
:::

**Instructions**
- Answer all questions.
- Show intermediate steps.

## Problem 1: [Title]
[Setup]

### (a) ...
### (b) ...

::: {.content-hidden unless-meta="solutions"}
## Solution
### (a) ...
:::
```

---

## Quality Gates

Use the canonical rubric in `../../rules/exercise-quality-rubric.md`.

---

## Output Summary

Return:

- Exercise path
- Estimated completion time
- Key concepts reinforced
- Review status and score

---

## Related Skills

- `/review-exercise`
- `/slide-excellence`
- `/proofread`
