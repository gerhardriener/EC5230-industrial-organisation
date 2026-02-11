---
name: qa-quarto
description: Adversarial QA profile for Quarto vs Beamer parity using the canonical orchestrator loop.
disable-model-invocation: true
argument-hint: "[LectureN, e.g., Lecture1]"
---

# Adversarial Quarto vs Beamer QA Workflow

Compare Quarto HTML slides against their Beamer PDF benchmark using the canonical orchestrator loop.
Use `.claude/rules/audit-report-conventions.md` for naming/persistence conventions.
Loop ownership: `.claude/rules/orchestrator-protocol.md`.

**Philosophy (translation parity mode):** The Beamer PDF is the parity benchmark during Beamer -> Quarto translation QA. This scope does not override Quarto-first maintenance authority after parity approval (see `.claude/rules/single-source-of-truth.md`).

---

## Execution Model (Loop Owned by Orchestrator)

```
Phase 0: Pre-flight (this skill)
  -> Hand off to orchestrator main loop
      REVIEW: quarto-critic
      FIX: quarto-fixer (if needed)
      RE-VERIFY + SCORE
  -> Repeat per orchestrator limits until APPROVED or limits exhausted

Initialize workflow logging before Phase 0:
- `python scripts/workflow_log.py init --task "qa-quarto: $ARGUMENTS" --slug "qa-quarto-$ARGUMENTS"`
```

## Hard Gates (Non-Negotiable)

| Gate | Condition |
|------|-----------|
| **Overflow** | NO content cut off |
| **Plot Quality** | Interactive charts >= static plots |
| **Content Parity** | No missing slides/equations/text |
| **Visual Regression** | Quarto >= Beamer in all dimensions |
| **Slide Centering** | Content centered, no jumping |
| **Notation Fidelity** | All math verbatim from Beamer |

## Phase 0: Pre-flight

1. Locate Beamer (.tex/.pdf) and Quarto (.qmd/.html) files
2. Run `verifier` pre-flight checks (freshness, renderability, SVG validity)
3. Verify TikZ SVGs if applicable

## Phase 1: Initial Audit

Launch the `quarto-critic` agent to compare Beamer vs Quarto comprehensively, then persist the returned report to:

- `quality_reports/[LECTURE_ID]_qa_critic_round[ROUND].md` (use `ROUND=1` for the first audit)

## Phase 2: Fix Cycle

If not APPROVED, launch `quarto-fixer` agent to apply fixes (Critical → Major → Minor), re-render, and run `verifier`. Persist fixer round reports to:

- `quality_reports/[LECTURE_ID]_qa_fixer_round[ROUND].md`

## Phase 3: Re-Audit

Re-launch critic to verify fixes. The orchestrator decides whether another fix round is required under canonical limits.

## Iteration and Retry Limits

Use the limits in `.claude/rules/orchestrator-protocol.md` (main loop, critic/fixer sub-loop, and verification retries).  
This skill does not define separate loop ceilings.

## Final Report

Persist the synthesized final report to:

- `quality_reports/[LECTURE_ID]_qa_final.md`

Include hard gate status, iteration summary, and remaining issues.

Close workflow log:
- `python scripts/workflow_log.py close --slug "qa-quarto-$ARGUMENTS" --summary "qa-quarto loop complete"`
