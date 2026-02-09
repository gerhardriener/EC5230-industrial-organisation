---
name: slide-excellence
description: Multi-dimensional slide review combining visual, pedagogical, proofreading, and citation checks.
disable-model-invocation: true
argument-hint: "[QMD filename]"
---

# Slide Excellence Review

**Purpose:** Run a comprehensive review across visual layout, pedagogy, proofreading, and citations, then synthesize findings.

---

## Inputs

- `$ARGUMENTS`: lecture filename (resolve under `lecture-slides/slides/`)
- Derive `FILE_STEM` from filename without extension.
- Follow `../../rules/audit-report-conventions.md` for artifact naming/persistence.
- Initialize workflow logging:
  - `python scripts/workflow_log.py init --task "slide excellence: [FILE_STEM]" --slug "slide-excellence-[FILE_STEM]"`

---

## Review Stack (Run in Parallel)

1. **slide-auditor** — layout, overflow, spacing, box fatigue
2. **pedagogy-reviewer** — narrative, pacing, notation, patterns
3. **proofreader** — grammar, consistency, citations
4. **tikz-reviewer** — only if TikZ present

**Inline checks in this skill:**

- **Content parity check:** slide count and environment parity vs Beamer (if applicable)
- **Citation key audit (for .qmd):** flag hardcoded author-year citations lacking `@key`  
  Include findings in the synthesized report under the `Citations` dimension (no standalone citation-audit artifact).

All reviewer agents return reports in response text. The invoking workflow persists:

- `quality_reports/[FILE_STEM]_visual_audit.md`
- `quality_reports/[FILE_STEM]_pedagogy_report.md`
- `quality_reports/[FILE_STEM]_report.md`
- `quality_reports/[FILE_STEM]_tikz_review.md` (if TikZ present)
- `quality_reports/[FILE_STEM]_parity_report.md`

---

## Synthesis Output

Persist synthesized output to:

- `quality_reports/[FILE_STEM]_slide_excellence_synthesis.md`

Close workflow log:
- `python scripts/workflow_log.py close --slug "slide-excellence-[FILE_STEM]" --summary "slide excellence review complete"`

```markdown
# Slide Excellence Review: [Filename]

## Overall Quality Score: [EXCELLENT / GOOD / NEEDS REVISION / POOR]

| Dimension     | Critical | Medium | Low |
| ------------- | -------- | ------ | --- |
| Visual/Layout |          |        |     |
| Pedagogical   |          |        |     |
| Proofreading  |          |        |     |
| Citations     |          |        |     |

### Critical Issues
### Medium Issues
### Citation Key Findings
### Recommended Next Steps
```

---

## Quality Score Rubric

| Score      | Critical | Medium | Meaning              |
| ---------- | -------- | ------ | -------------------- |
| Excellent  | 0-2      | 0-5    | Ready to present     |
| Good       | 3-5      | 6-15   | Minor refinements    |
| Needs Revision | 6-10  | 16-30  | Significant revision |
| Poor       | 11+      | 31+    | Major restructuring  |
