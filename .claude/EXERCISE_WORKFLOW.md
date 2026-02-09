# Exercise Creation & Review Workflow

**Purpose:** Quality-assured development of live (20-min) and take-home (60-min) exercises for EC5230

**Last Updated:** 2026-02-09

---

## Quick Reference

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/create-exercise` | Generate new exercise from scratch | Creating new problem sets |
| `/review-exercise <file>` | Comprehensive quality review | Before deploying exercises to students |
| `/proofread <file>` | Quick proofreading only | Minor edits after creation |

---

## The Exercise Review Stack

### Agents (Specialized Reviewers)

| Agent | Model | Purpose | Output |
|-------|-------|---------|--------|
| **exercise-reviewer** | Inherit | Timing analysis, pedagogical alignment, difficulty calibration | `*_exercise_review.md` |
| **solution-checker** | Inherit | Algebraic correctness, numerical accuracy, economic logic | `*_solution_check.md` |
| **proofreader** | Inherit | Grammar, typos, clarity | `*_proofreading.md` |
| **citation-auditor** | Built-in | Citation format verification | `*_citation_audit.md` |

### Skills (Workflows)

| Skill | Agents Used | Output |
|-------|-------------|--------|
| `/review-exercise` | All 4 agents (parallel) | Synthesis report + 4 individual reports |
| `/create-exercise` | Includes automatic `/review-exercise` after generation | New exercise file + quality reports |

---

## Exercise Types & Targets

### Live Exercises (`exercises/live/`)

**Target:** 15-20 minutes group work
**Format:** 1 focused problem with 3-5 sub-questions
**Structure:**
- Part (a): 3-5 min (warm-up: setup, define notation)
- Part (b): 5-8 min (main derivation: equilibrium, FOC)
- Part (c): 4-6 min (computation or comparative statics)
- Part (d): 2-4 min (interpretation or numerical check)
- Part (e) - optional: challenge extension

**Quality gates:**
- Estimated time: 12-25 min (60-125% of 20-min target)
- Reinforces 1-2 lecture concepts
- Solutions correct
- Group-friendly (divisible work)

### Take-Home Exercises (`exercises/sheets/`)

**Target:** 45-60 minutes individual work
**Format:** 2-3 problems covering different concepts
**Structure:**
- Problem 1 (routine): 15-20 min
- Problem 2 (standard): 25-30 min
- Problem 3 (challenge - optional): 15-20 min

**Quality gates:**
- Estimated time: 40-80 min (67-133% of 60-min target)
- Reinforces 2-3 lecture topics
- Solutions detailed and verified
- Includes written explanations

---

## Creating a New Exercise

### Workflow Overview

```
1. Specify requirements (/create-exercise --type=live --lecture=2)
   ↓
2. [Plan Mode] Design structure, estimate timing, plan solutions
   ↓
3. User approves plan
   ↓
4. Generate exercise file (.qmd with questions + solutions)
   ↓
5. Automatically run /review-exercise
   ↓
6. Fix any critical issues found
   ↓
7. Render HTML + PDF outputs
   ↓
8. Ready for deployment ✅
```

### Example: Creating a Live Exercise

```bash
/create-exercise --type=live --lecture=2 --topic="Hotelling with quadratic costs"
```

**What happens:**

1. **Planning phase** (Plan Mode):
   - Analyzes Lecture 2 content (Hotelling model)
   - Designs 4 sub-questions:
     - (a) Marginal consumer and demands
     - (b) Best responses
     - (c) Nash equilibrium
     - (d) Numerical check
   - Estimates timing: 18 min
   - Presents plan for approval

2. **Implementation** (after approval):
   - Creates `exercises/live/live-exercise-N.qmd`
   - Writes problem statement with clear setup
   - Derives solutions step-by-step
   - Adds numerical example

3. **Quality review** (automatic):
   - **exercise-reviewer:** Timing ✓ (18 min = 90% of target), Pedagogy ✓ (reinforces Lecture 2)
   - **solution-checker:** All derivations correct ✓
   - **proofreader:** No typos, notation consistent ✓
   - **Overall score:** 88/100 (EXCELLENT)

4. **Finalize:**
   - Renders HTML + PDF
   - Updates `exercises/index.qmd`
   - Ready for use ✅

---

## Reviewing an Existing Exercise

### Workflow Overview

```bash
/review-exercise exercises/live/live-exercise-1.qmd
```

**What happens:**

1. **Detect exercise type:** Live (from path) → 20-min target
2. **Launch 4 agents in parallel:**
   - exercise-reviewer → timing, pedagogy, difficulty
   - solution-checker → algebraic correctness
   - proofreader → grammar, clarity
   - citation-auditor → citation format
3. **Generate synthesis report** combining all findings
4. **Present summary** with quality score and recommended actions

### Example Output

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
  - live-exercise-1_exercise_review.md (timing + pedagogy analysis)
  - live-exercise-1_solution_check.md (correctness verification)
  - live-exercise-1_proofreading.md (grammar + clarity)
  - live-exercise-1_citation_audit.md (citation review)
  - live-exercise-1_exercise_synthesis.md (combined summary)

✅ Ready to deploy with minor fixes
```

---

## Quality Dimensions

### 1. Timing Analysis

**Goal:** Ensure exercises fit within target time constraints.

**How it's checked:**
- exercise-reviewer estimates completion time based on:
  - Number of algebraic steps
  - FOC derivations
  - System of equations complexity
  - Numerical computations
  - Conceptual discussions

**Quality gates:**
- **EXCELLENT:** Within ±10% of target
- **GOOD:** Within ±20%
- **NEEDS REVISION:** >20% deviation
- **POOR:** >50% deviation

### 2. Pedagogical Alignment

**Goal:** Ensure exercises reinforce lecture content appropriately.

**How it's checked:**
- exercise-reviewer verifies:
  - Concepts used are covered in specified lecture(s)
  - Notation matches lecture slides
  - Technique difficulty matches course level
  - Clear scaffolding from easier to harder parts

**Quality gates:**
- **HIGH:** All concepts from stated lectures, notation consistent
- **MEDIUM:** Minor notation variations, mostly aligned
- **LOW:** Requires techniques not yet taught OR concepts unclear

### 3. Solution Correctness

**Goal:** Ensure solutions are mathematically accurate and economically sound.

**How it's checked:**
- solution-checker independently verifies:
  - FOC calculations (derivatives, simplifications)
  - Algebraic manipulations (expanding, factoring, solving)
  - Numerical computations (substitutions, arithmetic)
  - Economic logic (comparative statics, interpretations)

**Quality gates:**
- **CORRECT:** All derivations verified, no errors
- **MINOR ERRORS:** 1-2 typos or missing steps, core logic sound
- **NEEDS REVISION:** 1+ critical algebraic error
- **INCORRECT:** Multiple fundamental errors

### 4. Clarity & Instructions

**Goal:** Ensure students understand what is being asked.

**How it's checked:**
- proofreader + exercise-reviewer verify:
  - Instruction verbs clear ("Derive" vs "State" vs "Explain")
  - Parameters fully defined
  - Setup complete (no missing assumptions)
  - Notation consistent throughout

**Quality gates:**
- **EXCELLENT:** Unambiguous, complete, clear
- **GOOD:** Minor clarifications possible
- **NEEDS WORK:** Ambiguous instructions or missing definitions

### 5. Citation Quality

**Goal:** Proper citation syntax for references.

**How it's checked:**
- citation-auditor scans for:
  - Hardcoded "Author (Year)" vs `@citationKey` syntax
  - Bibliography cross-reference
  - References to lecture materials

**Quality gates:**
- **EXCELLENT:** All citations use `@key` syntax
- **GOOD:** 1-2 hardcoded citations
- **NEEDS FIX:** Multiple hardcoded citations

---

## Quality Score Rubric

### Overall Rating

| Score | Critical | Medium | Timing | Solutions | Meaning |
|-------|----------|--------|--------|-----------|---------|
| **EXCELLENT** (85-100) | 0 | 0-2 | ±10% | CORRECT | Ready to deploy |
| **GOOD** (70-84) | 0-1 | 3-5 | ±20% | MINOR ERRORS | Minor fixes |
| **NEEDS REVISION** (50-69) | 2-3 | 6-10 | >20% | NEEDS REVISION | Significant work |
| **POOR** (<50) | 4+ | 11+ | >50% | INCORRECT | Major restructuring |

---

## Common Issues & Fixes

### Issue: Exercise takes too long

**Symptoms:**
- Estimated time >25 min for live (>80 min for takehome)
- Too many sub-questions
- Derivations too complex

**Fixes:**
1. **Reduce scope:** Remove one sub-question
2. **Simplify setup:** Use symmetric costs instead of asymmetric
3. **Provide hints:** Add scaffolding to reduce discovery time
4. **Split problem:** Make it two separate exercises

### Issue: Solutions have algebraic errors

**Symptoms:**
- solution-checker finds wrong FOC or incorrect derivation
- Numerical check doesn't match analytical solution

**Fixes:**
1. **Re-derive independently:** Start from problem setup
2. **Verify FOC:** Differentiate profit/utility function explicitly
3. **Check algebra:** Expand step-by-step, verify each line
4. **Validate numerically:** Substitute parameter values, confirm answer

### Issue: Pedagogy misalignment

**Symptoms:**
- Exercise uses techniques not covered in stated lecture
- Notation differs from lecture slides
- Difficulty level inappropriate

**Fixes:**
1. **Verify lecture content:** Re-read lecture slides to confirm coverage
2. **Adjust notation:** Match symbols used in lectures
3. **Add prerequisites:** Reference earlier exercises or concepts
4. **Recalibrate difficulty:** Add warm-up sub-question OR remove advanced extension

### Issue: Instructions unclear

**Symptoms:**
- Ambiguous phrasing ("Find the equilibrium" — which one?)
- Missing parameter definitions
- Incomplete problem setup

**Fixes:**
1. **Use precise verbs:** "Derive," "Compute," "Show that," "Explain why"
2. **Define all symbols:** State domain, parameter ranges
3. **Complete setup:** Specify market structure, timing, information structure
4. **Add hints:** Guide students toward solution approach if novel

---

## Best Practices

### When Creating Exercises

1. **Start with lecture content** — Review slides first to identify key concepts
2. **Plan difficulty progression** — Part (a) should be accessible warm-up
3. **Include numerical checks** — Helps students verify their algebra
4. **Write solutions immediately** — Don't create questions without solutions
5. **Test timing estimate** — Walk through solution yourself to validate time
6. **Add economic interpretation** — Don't end with pure algebra

### When Reviewing Exercises

1. **Run full review** — Use `/review-exercise`, not just proofreading
2. **Fix critical issues first** — Solution errors > timing > clarity
3. **Verify solutions independently** — Don't trust unverified derivations
4. **Test with students** — If possible, pilot with small group
5. **Iterate based on feedback** — Update exercises after first deployment

### For Live Exercises

1. **Make it group-friendly** — Divisible tasks (one person does part (a), another part (b))
2. **Provide structure** — "Step 1: ..., Step 2: ..., Step 3: ..."
3. **Target 15-18 minutes** — Leaves buffer for discussion and variations in group speed
4. **End with quick check** — Numerical example or limiting case to validate work
5. **Include discussion question** — Economic interpretation, policy implication

### For Take-Home Exercises

1. **Mix difficulty levels** — Start with routine, build to challenge
2. **Require written explanations** — Not just algebra, interpret results
3. **Connect to policy/welfare** — Show why the model matters
4. **Show all steps in solutions** — Model good practice for students
5. **Include optional extensions** — For stronger students

---

## File Locations

```
exercises/
├── index.qmd                    # Exercise landing page with links
├── live/
│   ├── live-exercise-1.qmd     # Live exercise (20-min)
│   ├── live-exercise-2.qmd
│   └── ...
└── sheets/
    ├── exercises-1.qmd          # Take-home problem set (60-min)
    ├── exercises-2.qmd
    └── ...

quality_reports/
├── live-exercise-1_exercise_review.md      # Timing + pedagogy
├── live-exercise-1_solution_check.md        # Correctness verification
├── live-exercise-1_proofreading.md          # Grammar + clarity
├── live-exercise-1_citation_audit.md        # Citation review
├── live-exercise-1_exercise_synthesis.md    # Combined summary
└── plans/
    └── 2026-02-09_exercise-live-hotelling.md  # Creation plan

.claude/
├── agents/
│   ├── exercise-reviewer.md     # Timing + pedagogy agent spec
│   ├── solution-checker.md      # Correctness verification agent spec
│   └── proofreader.md           # (existing) grammar/clarity agent
└── skills/
    ├── create-exercise/SKILL.md  # Exercise generation workflow
    └── review-exercise/SKILL.md  # Exercise review workflow
```

---

## Example Session

### Creating a Live Exercise

```bash
> /create-exercise --type=live --lecture=1 --topic="Cournot with asymmetric costs"

📋 Entering plan mode...

[Reads Lecture 1 slides, identifies Cournot model, checks notation]

📝 Exercise Plan Draft:

Problem: Cournot duopoly with cost asymmetry
  - Firm 1: c₁ = 0
  - Firm 2: c₂ = 4
  - Demand: P = 20 - Q

Sub-questions:
  (a) Derive best response functions (FOC + simplify) — 4 min
  (b) Solve for Nash equilibrium (q₁*, q₂*, P*) — 5 min
  (c) Compute equilibrium profits — 3 min
  (d) Numerical check: verify BR_1(q₂*) = q₁* — 2 min
  (e) Discuss: How does c₂ affect market shares? — 3 min

Estimated total: 17 minutes ✓ (85% of 20-min target)

Approve plan? [y/n]
> y

✅ Plan approved. Creating exercise...

[Writes exercise file with questions + solutions]

📊 Running quality review...

✅ Quality Review Complete

  ⏱️ Timing: 17 min (85% of target) — EXCELLENT
  📚 Pedagogy: HIGH (reinforces Lecture 1: Cournot model)
  ✔️ Solutions: CORRECT (all derivations verified)
  📝 Clarity: No issues

  Overall Score: 92/100 (EXCELLENT)

📁 Created: exercises/live/live-exercise-2.qmd
📁 Reports: quality_reports/live-exercise-2_*.md

✅ Ready for classroom use!
```

---

## Related Documentation

- **Slide workflows:** `.claude/SLIDE_EXCELLENCE.md` (similar quality stack for lectures)
- **Plan-first workflow:** `.claude/rules/plan-first-workflow.md` (planning protocol)
- **Agent specifications:** `.claude/agents/exercise-reviewer.md`, `solution-checker.md`
- **Skill specifications:** `.claude/skills/create-exercise/SKILL.md`, `review-exercise/SKILL.md`

---

**Created:** 2026-02-09
**Status:** Ready for use
**Next Steps:** Test `/create-exercise` with first new exercise, iterate based on feedback
