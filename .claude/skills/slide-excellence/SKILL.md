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

---

## Review Stack (Run in Parallel)

1. **slide-auditor** — layout, overflow, spacing, box fatigue  
   Save: `quality_reports/[FILE]_visual_audit.md`
2. **pedagogy-reviewer** — narrative, pacing, notation, patterns  
   Save: `quality_reports/[FILE]_pedagogy_report.md`
3. **proofreader** — grammar, consistency, citations  
   Save: `quality_reports/[FILE]_report.md`
4. **tikz-reviewer** — only if TikZ present  
   Save: `quality_reports/[FILE]_tikz_review.md`

**Inline checks in this skill:**

- **Content parity check:** slide count and environment parity vs Beamer (if applicable)  
  Save: `quality_reports/[FILE]_parity_report.md`
- **Citation key audit (for .qmd):** flag hardcoded author-year citations lacking `@key`  
  Save: `quality_reports/[FILE]_citation_audit.md`

---

## Synthesis Output

```markdown
# Slide Excellence Review: [Filename]

## Overall Quality Score: [EXCELLENT / GOOD / NEEDS WORK / POOR]

| Dimension     | Critical | Medium | Low |
| ------------- | -------- | ------ | --- |
| Visual/Layout |          |        |     |
| Pedagogical   |          |        |     |
| Proofreading  |          |        |     |
| Citations     |          |        |     |

### Critical Issues
### Medium Issues
### Recommended Next Steps
```

---

## Quality Score Rubric

| Score      | Critical | Medium | Meaning              |
| ---------- | -------- | ------ | -------------------- |
| Excellent  | 0-2      | 0-5    | Ready to present     |
| Good       | 3-5      | 6-15   | Minor refinements    |
| Needs Work | 6-10     | 16-30  | Significant revision |
| Poor       | 11+      | 31+    | Major restructuring  |
