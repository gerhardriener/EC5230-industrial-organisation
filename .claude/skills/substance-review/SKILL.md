---
name: substance-review
description: Run substantive domain correctness review using domain-reviewer (read-only).
disable-model-invocation: true
argument-hint: "[QMD or TEX filename]"
---

# Substance Review

## Purpose

Run the `domain-reviewer` agent for substantive correctness:
- assumptions
- derivations
- citation fidelity
- IO logic coherence

## Steps

1. Resolve `$ARGUMENTS` to a lecture source file.
2. Invoke `domain-reviewer`.
3. Persist report to:
   - `quality_reports/[FILE_STEM]_substance_review.md`

## Notes

- Read-only review; no edits applied.
- Use before final teaching release.

