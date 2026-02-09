# Create Exercise Skill

**Command:** `/create-exercise`

**Purpose:** Generate new course exercises (live or take-home) with automatic quality review

**Scope:** Creates exercises from specifications, generates solutions, and runs comprehensive quality checks.

---

## Usage

```bash
/create-exercise --type=live|takehome --lecture=N --topic="..."
/create-exercise --type=live --lecture=2 --topic="Hotelling with quadratic costs"
/create-exercise --type=takehome --lecture=1,2 --topic="Cournot oligopoly and product differentiation"
```

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

## Workflow

### Phase 1: Planning (Plan Mode)

**Objective:** Design exercise structure before writing

1. **Enter Plan Mode** — Use `EnterPlanMode` to activate planning workflow
2. **Analyze lecture content** — Read relevant lecture slides to identify:
   - Key concepts covered
   - Notation used
   - Examples shown
   - Techniques taught
3. **Design exercise structure:**
   - Determine number of sub-questions (3-5 for live, 2-4 problems for takehome)
   - Plan difficulty progression
   - Estimate timing per sub-question
   - Identify scaffolding opportunities
4. **Draft problem statement:**
   - Define setup (parameters, assumptions, market structure)
   - Write sub-questions with clear instructions
   - Add hints where appropriate
5. **Plan solution approach:**
   - Outline derivation steps
   - Identify potential student errors
   - Plan numerical check (if applicable)
6. **Save plan** to `quality_reports/plans/YYYY-MM-DD_exercise-[type]-[topic].md`
7. **Present plan to user** for approval
8. **Exit Plan Mode** after approval

### Phase 2: Implementation

**After plan approval:**

9. **Create exercise file:**
   - File path: `exercises/live/live-exercise-N.qmd` or `exercises/sheets/exercises-N.qmd`
   - Follow template structure (see below)
   - Write question sections based on plan
10. **Write solutions:**
    - Derive solutions step-by-step
    - Show intermediate algebraic steps
    - Include numerical checks
    - Add economic interpretations
    - Gate with `{.content-hidden unless-meta="solutions"}`
11. **Add metadata:**
    - Title, format options, solution toggle
    - Instructions (group work for live, "show steps" for takehome)

### Phase 3: Quality Review

**Automatically run `/review-exercise` on the created file:**

12. **Launch review agents in parallel:**
    - Exercise reviewer (timing, pedagogy)
    - Solution checker (correctness)
    - Proofreader (clarity)
    - Citation auditor (if references present)
13. **Fix critical issues** identified by agents
14. **Re-run verification** until quality score ≥ GOOD (80/100)

### Phase 4: Finalize

15. **Render outputs:**
    - `quarto render exercises/[type]/[file].qmd` (HTML + PDF)
    - Verify both student version (no solutions) and instructor version (with solutions)
16. **Update exercise index:**
    - Add entry to `exercises/index.qmd` with link and description
17. **Present summary to user:**
    - Exercise file path
    - Quality score
    - Estimated completion time
    - Key concepts reinforced

---

## Exercise Templates

### Live Exercise Template

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
    colorlinks: true
    number-sections: false
solutions: false
---

::: {.content-hidden unless-meta="solutions"}

# Solutions

:::

**Group exercise (≈15-20 minutes)**

- Work in groups of 3–4.
- Show your steps (the algebra is the point).
- [Any additional instructions]

## Problem: [Title]

[Setup paragraph: market structure, parameters, assumptions]

### (a) [First sub-question]

[Question text with clear instruction verb: Derive/Compute/Show/Explain]

[Optional hint]

### (b) [Second sub-question]

...

### (c) [Challenge question - optional]

...

::: {.content-hidden unless-meta="solutions"}

## Suggested solution (sketch)

### (a)

[Solution with intermediate steps]

### (b)

...

:::
```

### Take-Home Exercise Template

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
    colorlinks: true
    number-sections: false
solutions: false
---

::: {.content-hidden unless-meta="solutions"}

# Solutions

:::

**Instructions**

- Answer all questions.
- Show intermediate steps.
- [Submission instructions if applicable]

## Problem 1: [Title]

[Setup and context, possibly referencing lecture examples]

### (a)

[Sub-question]

### (b)

[Sub-question]

### (c)

[Sub-question]

::: {.content-hidden unless-meta="solutions"}

## Solution

### (a)

[Detailed solution]

### (b)

...

:::

\newpage

## Problem 2: [Title]

...
```

---

## Exercise Design Principles

### For Live Exercises (20-minute target)

**Structure:**

- **1 focused problem** with 3-5 sub-questions
- **Progressive difficulty:** warm-up → main derivation → interpretation/extension
- **Group-friendly:** can be divided among group members, then synthesized

**Timing guidelines:**

- Part (a): 3-5 min (warm-up: define notation, set up FOC)
- Part (b): 5-8 min (main derivation: equilibrium, best response)
- Part (c): 4-6 min (computation or comparative statics)
- Part (d): 2-4 min (interpretation or quick numerical check)
- Optional part (e): challenge extension (for advanced groups)

**Content:**

- Reinforce 1-2 lecture concepts
- Use familiar market structure with a twist
- Include numerical check for validation
- End with economic interpretation (not just algebra)

### For Take-Home Exercises (60-minute target)

**Structure:**

- **2-3 problems** covering different concepts
- **Each problem** has 2-4 sub-questions
- **Mix:** routine applications + deeper analysis

**Timing guidelines:**

- Problem 1 (routine): 15-20 min
- Problem 2 (standard): 25-30 min
- Problem 3 (challenge - optional): 15-20 min

**Content:**

- Reinforce 2-3 lecture topics
- Include at least one problem that combines concepts
- Require written explanations, not just algebra
- Include policy/welfare analysis where appropriate

---

## Common Exercise Types

### Cournot Oligopoly Variants

- Asymmetric costs
- N firms with free entry
- Sequential quantity choice (Stackelberg)
- Welfare comparisons

### Product Differentiation

- Hotelling with different cost functions (linear, quadratic)
- Hotelling with asymmetric locations
- Salop with heterogeneous firms
- Vertical differentiation

### Innovation & R&D

- Process innovation value (monopoly vs competition)
- Drastic vs non-drastic innovations
- Patent races
- R&D spillovers

### Strategic Entry/Exit

- Entry deterrence pricing
- Capacity commitments
- Market foreclosure

---

## Quality Gates

**Before presenting to user, exercise must achieve:**

- **Timing:** Within ±20% of target (15-25 min for live, 48-72 min for takehome)
- **Solutions:** Algebraically correct (verified by solution-checker)
- **Pedagogy:** Reinforces stated lecture concepts (verified by exercise-reviewer)
- **Clarity:** No ambiguous instructions (verified by proofreader)
- **Overall score:** ≥80/100 (GOOD or better)

If quality gates not met → return to implementation phase and fix issues.

---

## Output

```
✅ Exercise Created: exercises/live/live-exercise-2.qmd

📚 Topic: Cournot duopoly with asymmetric costs
🎯 Reinforces: Lecture 1 (Oligopoly theory)
⏱️ Estimated time: 18 minutes (90% of target)

📊 Quality Score: 88/100 (EXCELLENT)
  ✓ Solutions correct (verified)
  ✓ Timing on target
  ✓ Pedagogical alignment high
  ✓ No critical issues

📁 Files created:
  - exercises/live/live-exercise-2.qmd
  - quality_reports/live-exercise-2_exercise_synthesis.md

🔍 Rendered outputs:
  - _site/exercises/live/live-exercise-2.html (student version)
  - _site/exercises/live/live-exercise-2.pdf (student version)

✅ Ready for classroom use
```

---

## Interactive Mode

The skill prompts for missing parameters:

```
> /create-exercise

🎓 Create New Exercise

Exercise type?
  1. Live (20-minute group exercise)
  2. Take-home (60-minute problem set)

> 1

Which lecture(s) to reinforce? (e.g., 2 or 1,2,3)
> 2

Main topic? (e.g., "Hotelling with quadratic costs")
> Salop model with free entry

Difficulty level?
  1. Routine (apply formulas directly)
  2. Standard (multi-step derivations) [Recommended]
  3. Challenge (novel setup or deeper analysis)

> 2

Any extensions or special requirements? (optional)
> [Enter to skip]

✅ Creating exercise plan...
```

---

## Related Skills

- `/review-exercise` — Quality review for existing exercises (subset of this skill's Phase 3)
- `/slide-excellence` — Similar workflow for lectures
- `/translate-to-quarto` — Convert Beamer exercises to Quarto (if needed)

---

## Implementation Notes

### Plan Mode Integration

The skill uses the plan-first workflow:

1. Automatically enters plan mode
2. Creates plan file in `quality_reports/plans/`
3. Presents plan to user
4. Only proceeds to implementation after approval

### Solution Generation Strategy

When writing solutions:

- Start from problem setup
- Show FOCs explicitly (don't skip differentiation)
- Show algebraic simplification steps (don't jump to final form)
- Verify numerical examples independently (recalculate)
- Add economic interpretation after each mathematical result

### Iteration Protocol

If quality review finds critical issues:

1. Identify issue type (algebra error, timing issue, unclear instruction)
2. Fix in exercise file
3. Re-run affected review agent
4. Continue until all critical issues resolved

Maximum 3 iterations before presenting to user with remaining issues flagged.

---

**Created:** 2026-02-09
**Last Updated:** 2026-02-09
