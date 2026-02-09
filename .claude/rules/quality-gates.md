---
paths:
  - "lecture-slides/**/*.qmd"
  - "scripts/**/*.R"
---

# Quality Gates (Canonical)

**Purpose:** Minimal thresholds for commit and PR readiness.

---

## Thresholds

- **80/100** = Commit threshold (save progress)
- **90/100** = PR threshold (deploy-ready)
- **95/100** = Excellence (aspirational)

---

## Quarto Slides (.qmd)

**Critical (block commit):**

- Compilation failure
- Equation overflow
- Broken citation

**Major (block PR):**

- Hardcoded citation (missing `@key`)
- Text overflow
- TikZ label overlap
- Notation inconsistency

**Minor (advisory):**

- Font size reduction used
- Missing framing sentence

---

## R Scripts (.R)

**Critical:**

- Syntax errors
- Known domain-specific bugs
- Hardcoded absolute paths

**Major:**

- Missing `set.seed()`
- Missing figure generation
- Wrong color palette

---

## Beamer Slides (.tex)

**Critical:**

- XeLaTeX compilation failure
- Undefined citation
- Overfull hbox > 10pt

---

## Enforcement

- **Commit gate:** score < 80 → block commit
- **PR gate:** score < 90 → warn and list issues
- Override allowed with justification
