# EC5230 Claude Code Workflow

> Work in progress. This is not meant to be a polished guide for everyone. It is a practical record of how I use Claude Code for academic work (slides, exercises, figures, and review loops). I keep updating it as the workflow evolves.

**Live site:** [psantanna.com/claude-code-my-workflow](https://psantanna.com/claude-code-my-workflow/)

This repository contains the EC5230 course materials and the Claude Code workflow used to build and review slides, exercises, and figures. If you fork it, replace domain-specific content to fit your field.

---

## Start Here

1. `CLAUDE.md` - project context, commands, and current workflow index
2. `.github/copilot-instructions.md` - authoring rules for slides and exercises
3. `.claude/rules/` - canonical rules (plan-first, quality gates, callouts, TikZ, verification)
4. `guide/workflow-guide.qmd` - full workflow walkthrough (also on the live site)

---

## What This Repo Supports (Canonical Sources)

- Plan-first workflow and session logs: `.claude/rules/plan-first-workflow.md`
- Single source of truth and TikZ freshness: `.claude/rules/single-source-of-truth.md`
- TikZ pipeline: `.claude/rules/tikz-workflow.md`
- Orchestrator workflow: `.claude/rules/orchestrator-protocol.md`
- Adversarial Quarto vs Beamer QA: `.claude/skills/qa-quarto/SKILL.md`
- Beamer to Quarto translation support: `.claude/agents/beamer-translator.md`
- Quality gates: `.claude/rules/quality-gates.md`
- Exercise rubric and workflow: `.claude/rules/exercise-quality-rubric.md`, `.claude/EXERCISE_WORKFLOW.md`
- Proofreading gate: `.claude/rules/proofreading-protocol.md`
- Visual identity: `.claude/rules/st-andrews-visual-identity.md`
- Verification requirements: `.claude/rules/verification-protocol.md`

---

## Typical Commands

- `/create-lecture`
- `/slide-excellence`
- `/create-exercise`
- `/review-exercise`
- `/extract-tikz`
- `/deploy`

Full command and agent list lives in `CLAUDE.md`.

---

## Adapting for Your Field

- Fill the knowledge base: `.claude/rules/knowledge-base-template.md`
- Customize domain checks: `.claude/agents/domain-reviewer.md`
- Update palette/typography: `.claude/rules/st-andrews-visual-identity.md`
- Add R-specific pitfalls: `.claude/rules/r-code-conventions.md`

---

## Guide

For a comprehensive walkthrough, see:

- `guide/workflow-guide.qmd`
- The live site linked above

---

## Additional Resources

- Claude Code documentation: https://docs.anthropic.com/en/docs/claude-code
- Writing a good CLAUDE.md: https://docs.anthropic.com/en/docs/claude-code/memory

---

## Origin

This infrastructure was extracted from a production academic workflow (Econ 730: Causal Panel Data, Emory University) and adapted for EC5230. It produced multiple lecture decks, interactive Quarto versions, and R replication packages through a multi-agent review process.

---

## License

MIT License. Use freely for teaching, research, or any academic purpose.
