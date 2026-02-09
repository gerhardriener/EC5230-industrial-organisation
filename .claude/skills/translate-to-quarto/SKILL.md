---
name: translate-to-quarto
description: Translate a Beamer lecture to Quarto RevealJS using the beamer-translator workflow.
disable-model-invocation: true
argument-hint: "[path/to/beamer.tex or LectureN]"
---

# Translate Beamer to Quarto

## Purpose

Convert a Beamer lecture into `lecture-slides/slides/*.qmd` while preserving notation and pedagogical flow.

## Steps

1. Initialize workflow log:
   - `python scripts/workflow_log.py init --task "translate-to-quarto: $ARGUMENTS" --slug "translate-$ARGUMENTS"`
2. Locate Beamer source and target Quarto file.
3. Invoke `beamer-translator` process:
   - map environments to CSS callout classes
   - convert citations to Pandoc `@key`
   - ensure figure references use SVG for RevealJS
4. Run adversarial QA:
   - `/qa-quarto [LectureN]`
5. Close workflow log:
   - `python scripts/workflow_log.py close --slug "translate-$ARGUMENTS" --summary "translation + QA complete"`

## Output

- Updated `.qmd` lecture file
- QA artifacts in `quality_reports/`

