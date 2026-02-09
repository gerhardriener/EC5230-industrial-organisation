---
name: slide-excellence
description: Comprehensive slide excellence review combining visual audit, pedagogical review, proofreading, and optional TikZ/parity checks. Produces multiple reports and a combined summary.
disable-model-invocation: true
argument-hint: "[QMD filename]"
---

# Slide Excellence Review

Run a comprehensive multi-dimensional review of lecture slides. Multiple agents analyze the file independently, then results are synthesized.

## Steps

### 1. Identify the File

Parse `$ARGUMENTS` for the filename. Resolve path in `lecture-slides/slides/`.

### 2. Run Review Agents in Parallel

**Agent 1: Visual Audit** (slide-auditor)

- Overflow, font consistency, box fatigue, spacing, images
- Persist response to: `quality_reports/[FILE]_visual_audit.md`

**Agent 2: Pedagogical Review** (pedagogy-reviewer)

- 13 pedagogical patterns, narrative, pacing, notation
- Persist response to: `quality_reports/[FILE]_pedagogy_report.md`

**Agent 3: Proofreading** (proofreader)

- Grammar, typos, consistency, academic quality, citations
- Persist response to: `quality_reports/[FILE]_report.md`

**Agent 4: TikZ Review** (only if file contains TikZ)

- Label overlaps, geometric accuracy, visual semantics
- Persist response to: `quality_reports/[FILE]_tikz_review.md`

**Agent 5: Content Parity Check** (inline check in this skill)

- Frame count comparison, environment parity, content drift
- Persist report to: `quality_reports/[FILE]_parity_report.md`

**Agent 6: Citation Key Audit** (always for .qmd files)

- Detect hardcoded author-year citations not using `@citationKey` syntax
- Cross-reference against `references.bib` to suggest correct keys
- Exempt: figure `fig-alt` strings, code blocks, YAML frontmatter, non-citation parenthetical asides
- Detection patterns:
  - `Author (YYYY)` — e.g., `Arrow (1962)`
  - `Author et al. (YYYY)` — e.g., `Aghion et al. (2005)`
  - `Author and Author (YYYY)` — e.g., `Acemoglu and Linn (2004)`
  - `Author, Author, and Author (YYYY)` — e.g., `Blundell, Griffith, and Van Reenen (1999)`
  - `(Author YYYY)` or `(Author, YYYY)` — e.g., `(Dasgupta–Stiglitz 1980)`
- Skip lines where a `@citationKey` for the same reference already appears
- For each match: report line number, matched text, and suggested `@key` replacement from `references.bib`
- If no matching bib entry exists: flag as "hardcoded citation with no bib entry" (double issue)
- Quality gate: **-10 per instance** (Major)
- Save: `quality_reports/[FILE]_citation_audit.md`

### 3. Synthesize Combined Summary

```markdown
# Slide Excellence Review: [Filename]

## Overall Quality Score: [EXCELLENT / GOOD / NEEDS WORK / POOR]

| Dimension     | Critical | Medium | Low |
| ------------- | -------- | ------ | --- |
| Visual/Layout |          |        |     |
| Pedagogical   |          |        |     |
| Proofreading  |          |        |     |
| Citations     |          |        |     |

### Critical Issues (Immediate Action Required)

### Medium Issues (Next Revision)

### Recommended Next Steps
```

## Quality Score Rubric

| Score      | Critical | Medium | Meaning              |
| ---------- | -------- | ------ | -------------------- |
| Excellent  | 0-2      | 0-5    | Ready to present     |
| Good       | 3-5      | 6-15   | Minor refinements    |
| Needs Work | 6-10     | 16-30  | Significant revision |
| Poor       | 11+      | 31+    | Major restructuring  |
