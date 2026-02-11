# Orchestrator Protocol: Contractor Mode

**After a plan is approved, the orchestrator takes over.** It implements, verifies, reviews, fixes, and scores autonomously — presenting results only when the work meets quality standards or fix rounds are exhausted.

The plan-first workflow handles _what and why_. The orchestrator handles _how_, autonomously.

---

## Canonical Loop Ownership

This document defines the **only** iterative review-fix loop and retry policy.

- Skills may define setup inputs, artifacts, and review scope.
- Skills must **not** define independent loop counters, retry ceilings, or competing fix-order logic.
- `/qa-quarto` is a Quarto parity **profile** that runs on this loop, not a separate loop engine.

If a skill and this protocol disagree, this protocol wins for iteration behavior.

---

## When the Orchestrator Activates

The orchestrator kicks in under these conditions:

1. **After plan approval** — the standard trigger. The plan-first workflow hands off to the orchestrator after approval.
2. **"Just do it" mode** — when the user says "just do it", "you decide", or "handle it", skip the final presentation gate.
3. **Skill delegation** — when a skill like `/create-lecture` reaches its implementation phase, the orchestrator loop governs execution.

The orchestrator does NOT activate for:

- Single-file trivial edits (typo fix, add a citation)
- Purely informational questions
- Running a standalone skill like `/deploy`

---

## The Orchestrator Loop

```
Plan approved → orchestrator activates
  │
  Step 1: IMPLEMENT — Execute plan steps, create/modify files
  │
  Step 2: VERIFY — Run verifier (compile, render, check outputs)
  │         If verification fails → fix compilation errors → re-verify
  │
  Step 3: REVIEW — Select and run review agents (see Agent Selection)
  │
  Step 4: FIX — Apply fixes from reviews (Critical → Major → Minor)
  │
  Step 5: RE-VERIFY — Compile/render again to confirm fixes are clean
  │
  Step 6: SCORE — Apply quality-gates rubric
  │
  └── Score >= threshold?
        YES → Present summary to user
        NO  → Loop back to Step 3 (max 5 review-fix rounds)
              After max rounds → present summary with remaining issues
```

### Agent Selection

Select review agents based on **file types touched during implementation**:

| Files Modified          | Agents to Run                                 | Parallel?         |
| ----------------------- | --------------------------------------------- | ----------------- |
| `.qmd` (Quarto)         | proofreader, slide-auditor, pedagogy-reviewer | Yes               |
| `.qmd` with `.tex` pair | + quarto-critic (→ quarto-fixer if issues)    | After above       |
| `.R` scripts            | r-reviewer                                    | Yes (with others) |
| TikZ content present    | tikz-reviewer                                 | Yes (with others) |
| Domain-critical content | domain-reviewer (if configured)               | Yes (with others) |

**Run independent agents in parallel.** The quarto-critic runs after the parallel batch because it needs their context. If the quarto-critic finds issues, invoke quarto-fixer and re-run quarto-critic (up to 5 sub-rounds within the main loop).

---

## Avoid Duplicate Review Stacks (Hard Rule)

When the orchestrator is active, it already runs the standard review agents for modified `.qmd` files (proofreader + slide-auditor + pedagogy-reviewer).

Do not manually run a second full review stack (e.g., `/slide-excellence`, or stacking `/proofread` + `/visual-audit` + `/pedagogy-review`) on the same revision unless explicitly intended as a **milestone audit** to capture an independent snapshot.

---

## Fix Priority and Loop Limits

Within each fix round, apply fixes in strict order:

1. **Critical** — compilation failures, math errors, broken citations, hard gate violations
2. **Major** — overflow, content parity gaps, notation inconsistencies
3. **Minor** — spacing, style, polish

### Limits

- **Main loop:** max 5 review-fix rounds
- **Critic-fixer sub-loop:** max 5 rounds (within each main loop iteration)
- **Verification retries:** max 2 attempts per verification step
- **Skill wrappers:** cannot define higher limits than these ceilings
- After max rounds, present what remains. Never loop indefinitely.

---

## The Summary

When the loop completes (score >= threshold or max rounds), present a structured summary:

```
## Orchestrator Summary

**Task:** [from the plan]
**Quality Score:** [N]/100 (threshold: [80/90])
**Review Rounds:** [N]

### Files Created/Modified
- `path/to/file` — [what changed]

### Issues Found and Fixed
- [N] critical, [N] major, [N] minor resolved

### Remaining Issues (if any)
- [List with severity]

### Recommended Next Steps
- [e.g., "Run /slide-excellence as a milestone audit snapshot (optional)"]
```

Append the summary to the session log as required by `.claude/rules/plan-first-workflow.md`.

---

## "Just Do It" Mode

When the user signals blanket approval ("just do it", "you decide", "handle it"):

1. Skip the final presentation gate — do not pause for approval after the summary
2. Auto-commit if score >= 80 with a descriptive commit message
3. Still run the full verify-review-fix loop (quality is non-negotiable)
4. Still log everything to the session log
5. Still present the summary (the user should see what was done), but do not wait for approval to continue

"Just do it" does NOT skip the orchestrator loop itself — verification and review still happen. It only skips the approval pause at the end.
