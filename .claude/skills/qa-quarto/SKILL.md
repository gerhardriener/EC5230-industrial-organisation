---
name: qa-quarto
description: Adversarial QA profile for Quarto RevealJS vs Typst PDF parity using the canonical orchestrator loop.
disable-model-invocation: true
argument-hint: "[LectureN, e.g., Lecture1]"
---

# Adversarial Quarto vs Typst QA Workflow

Compare Quarto RevealJS HTML slides against their **Typst PDF** (`clean-typst`) benchmark using the canonical orchestrator loop.
Use `.claude/rules/audit-report-conventions.md` for naming/persistence conventions.
Loop ownership: `.claude/rules/orchestrator-protocol.md`.

**Philosophy (parity mode):** The **Typst PDF** (`clean-typst`) is the parity benchmark. Beamer is no longer an active format — do not reference Beamer `.tex` files. This scope does not override Quarto-first maintenance authority after parity approval (see `.claude/rules/single-source-of-truth.md`).

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
| **Visual Regression** | Quarto >= Typst PDF in all dimensions |
| **Slide Centering** | Content centered, no jumping |
| **Notation Fidelity** | All math verbatim from Typst PDF |

## Phase 0: Pre-flight

1. Locate Typst PDF (render via `quarto render --to clean-typst`) and Quarto `.qmd`/`.html` files
2. Run `verifier` pre-flight checks (freshness, renderability, SVG validity)
3. Verify TikZ SVGs and CeTZ/Typst sources if applicable

## Phase 1: Initial Audit

Launch the `quarto-critic` agent to compare Typst PDF vs Quarto comprehensively, then persist the returned report to:

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
