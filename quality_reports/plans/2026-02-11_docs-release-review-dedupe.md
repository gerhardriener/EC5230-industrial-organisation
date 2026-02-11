# Plan: docs-release-review-dedupe
**Date:** 2026-02-11 17:47
**Status:** APPROVED
**Task:** docs: canonical lecture release review path + avoid duplicate review stacks

## Approach
1. Define a single canonical "teaching-ready" review path for lecture slides: `/slide-excellence`.
2. Mark `/proofread`, `/visual-audit`, `/pedagogy-review` as diagnostics-only to avoid stacking/duplicate work.
3. Add a hard rule clarifying orchestrator mode: don't manually run a second full review stack unless intentionally doing a milestone audit snapshot.
4. Remove/avoid duplicated agent-list specs in docs by pointing to canonical `SKILL.md` sources (keep only a short summary in the guide).
5. Verify the Quarto guide still renders successfully after edits.

## Files to Modify
- `guide/workflow-guide.qmd`
- `CLAUDE.md`
- `.claude/rules/orchestrator-protocol.md`
- `.claude/skills/proofread/SKILL.md`
- `.claude/skills/pedagogy-review/SKILL.md`
- (Optional, for consistency) `.claude/skills/create-lecture/SKILL.md`

## Verification
- [ ] `quarto render guide/workflow-guide.qmd`
- [ ] Confirm `_site/guide/workflow-guide.html` exists (or otherwise confirm the render output path is created)
