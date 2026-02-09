---
name: review-exercise
description: Comprehensive multi-dimensional review of course exercises, covering timing, pedagogy, correctness, and clarity.
disable-model-invocation: true
argument-hint: "<file> [--type=live|takehome]"
---

# Exercise Review Skill

**Command:** `/review-exercise`

**Purpose:** Comprehensive multi-dimensional review of course exercises (live or take-home problem sets)

**Scope:** Analyzes exercises for timing appropriateness, pedagogical alignment, solution correctness, and clarity.

---

## Usage

```bash
/review-exercise <file>
/review-exercise <file> --type=live|takehome
```

**Examples:**
```bash
/review-exercise exercises/live/live-exercise-1.qmd
/review-exercise exercises/sheets/exercises-2.qmd --type=takehome
/review-exercise @exercises/live/live-exercise-1.qmd
```

---

## Parameters

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `file` | Yes | — | Path to exercise `.qmd` file |
| `--type` | No | Auto-detect | Exercise type: `live` (20-min) or `takehome` (60-min). Auto-detected from file path. |

---

## Workflow

### Step 1: Identify File and Type

- Parse file path from argument
- Auto-detect type from path:
  - `exercises/live/` → `live` (20-minute target)
  - `exercises/sheets/` → `takehome` (60-minute target)
- Override with `--type` flag if provided

### Step 2: Run Review Agents in Parallel

Launch multiple review agents concurrently to maximize efficiency:

**Agent 1: Exercise Reviewer** (exercise-reviewer)
- Timing analysis (estimated completion time vs target)
- Pedagogical alignment (lecture dependencies, prerequisites)
- Difficulty calibration (progression, cognitive load)
- Clarity & instructions
- **Save:** `quality_reports/[FILE]_exercise_review.md`

**Agent 2: Solution Checker** (solution-checker)
- Algebraic correctness (FOCs, derivations, equilibria)
- Numerical accuracy (computations, substitutions)
- Economic logic (comparative statics, interpretations)
- **Save:** `quality_reports/[FILE]_solution_check.md`

**Agent 3: Proofreader** (proofreader, existing)
- Grammar, typos, consistency
- Academic quality
- **Save:** `quality_reports/[FILE]_report.md`

### Step 3: Synthesize Combined Summary

After all agents complete, generate a synthesis report:

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

**Exercise Type:** [Live / Take-home]
**Target Time:** [20 min / 60 min]
**Estimated Time:** [X min] ([Y% of target])
**Solution Correctness:** [CORRECT / MINOR ERRORS / NEEDS REVISION]

### Critical Issues

[List all critical issues across dimensions]

### Medium Issues

[List all medium issues]

### Recommended Actions

1. [Priority 1 fixes]
2. [Priority 2 improvements]
3. [Optional polish]

### Quality Score

**By dimension:**
- Timing: [score/reasoning]
- Pedagogy: [score/reasoning]
- Solutions: [score/reasoning]
- Clarity: [score/reasoning]

**Overall:** [X]/100 ([EXCELLENT/GOOD/NEEDS REVISION/POOR])
```

**Save:** `quality_reports/[FILE]_exercise_synthesis.md`

---

## Quality Score Rubric

Use `../../rules/exercise-quality-rubric.md` as the canonical rubric for:
- score bands
- timing windows
- severity thresholds
- rating interpretation

---

## Output

The skill produces:

1. **Individual agent reports** (3 files in `quality_reports/`)
2. **Synthesis report** (1 file summarizing all dimensions)
3. **Console summary** (brief text output with key findings)

### Console Summary Format

```
✅ Exercise Review Complete: exercises/live/live-exercise-1.qmd

📊 Overall Assessment: GOOD (85/100)

⏱️ Timing: 18 min (90% of 20-min target) ✓
📚 Pedagogy: HIGH alignment (reinforces Lecture 2)
✔️ Solutions: CORRECT (no errors found)
📝 Clarity: 2 medium issues (notation consistency)

🚨 Issues Found:
  • 0 Critical
  • 3 Medium
  • 2 Low

📁 Reports saved to quality_reports/:
  - live-exercise-1_exercise_review.md
  - live-exercise-1_solution_check.md
  - live-exercise-1_report.md
  - live-exercise-1_exercise_synthesis.md

✅ Ready to deploy with minor fixes
```

---

## Error Handling

### File Not Found
```
❌ Error: File not found
   Path: exercises/live/live-exercise-3.qmd

   Available exercises:
   • exercises/live/live-exercise-1.qmd
   • exercises/live/live-exercise-2.qmd
   • exercises/sheets/exercises-1.qmd
```

### No Solutions Section
```
⚠️ Warning: No solutions found in file
   The exercise file does not contain a solutions section.

   Skipping solution-checker agent.
   Add solutions with:

   ::: {.content-hidden unless-meta="solutions"}
   ## Solution
   ...
   :::
```

### Type Detection Failed
```
❌ Error: Could not auto-detect exercise type
   Path: exercises/misc/practice.qmd

   Please specify type manually:
   /review-exercise exercises/misc/practice.qmd --type=live
```

---

## Related Skills

- `/create-exercise` — Generate new exercise from specifications
- `/slide-excellence` — Comprehensive slide review (similar workflow for lectures)
- `/proofread` — Standalone proofreading (subset of this skill)

---

## Implementation Notes

### Timing Estimation Logic

The `exercise-reviewer` agent uses these heuristics:

| Task Type | Estimated Time |
|-----------|----------------|
| Simple substitution | 1 min |
| Algebraic manipulation (1-2 steps) | 2 min |
| FOC derivation | 3-4 min |
| Best response derivation | 3-5 min |
| System of 2 equations | 3-4 min |
| System of 3+ equations | 6-8 min |
| Numerical computation (multi-step) | 2-3 min |
| Conceptual discussion (short paragraph) | 2-3 min |
| Conceptual discussion (multi-paragraph) | 4-6 min |
| Graph/diagram sketching | 3-5 min |
| Comparative statics analysis | 3-5 min |

**Total = Sum across all sub-questions + 10% buffer for reading/setup**

### Parallel Execution

All three agents run in parallel (single message with multiple `Task` calls) to maximize performance. Agents are independent and don't depend on each other's output.

---
