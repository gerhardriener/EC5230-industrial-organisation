# ILO Mapping Template — EC5230 Industrial Organisation

This file defines the canonical format for the learning-outcome mapping document
that accompanies each EC5230 exam paper. The mapping is required by the School
of Economics and Finance when submitting exam papers for moderation.

---

## File header

Every `ilo-mapping.md` should begin with a header block:

```markdown
# Learning Outcome Mapping
**Module:** EC5230 Industrial Organisation
**Academic year:** 2025-26
**Exam type:** Final exam — main paper
**Submission date:** [date]
**Prepared by:** [name]
```

---

## Mapping table format

Use a Markdown table with these columns:

| Question | Sub-part | Marks | ILOs assessed | Assessment method |
|----------|----------|-------|---------------|-------------------|
| Q1       | (a)      | 2     | ILO 1, ILO 3  | Derivation        |
| Q1       | (b)      | 2     | ILO 1, ILO 3  | Calculation       |
| Q1       | (c)      | 1     | ILO 4         | Interpretation    |
| Q2       | (a)      | 2     | ILO 2         | Derivation        |
| Q2       | (b)      | 3     | ILO 2, ILO 5  | Calculation       |
| ...      | ...      | ...   | ...           | ...               |
| **Total**|          | **100**|              |                   |

### Columns

- **Question** — question number (Q1, Q2, ...).
- **Sub-part** — sub-part label ((a), (b), (c), ...). If the question has no
  sub-parts, write "—".
- **Marks** — marks available for this sub-part.
- **ILOs assessed** — comma-separated list of ILO numbers or short identifiers
  (e.g. "ILO 1, ILO 3"). Use `[ILO N - to be confirmed]` if the ILO list has
  not yet been provided.
- **Assessment method** — one of:
  - `Derivation` — student derives a result algebraically
  - `Calculation` — student computes a numerical answer
  - `Interpretation` — student explains or interprets a result in words
  - `Comparison` — student compares two cases or scenarios
  - `Essay` — extended written response
  - `Proof` — formal mathematical argument

---

## EC5230 ILOs (authoritative — from module description 2025-26)

| ILO   | Description |
|-------|-------------|
| ILO 1 | Understand how IO deepens the understanding of firm/agent behaviour in imperfectly competitive markets. |
| ILO 2 | Select the right model(s) to analyse various issues in industrial economics. |
| ILO 3 | Analyse economic behaviour through game theory. |
| ILO 4 | Develop curiosity by identifying interesting papers and examples to extend knowledge of the subject. |

**Note on ILO 4:** This ILO is primarily assessed through the policy report
coursework. Include it in the exam mapping only where a question explicitly
invites students to draw on wider reading or make policy-relevant observations.

---

## Coverage summary

After the table, add a brief prose paragraph summarising coverage:

```markdown
## Coverage summary

The exam covers [N] of the module's [M] intended learning outcomes.
[ILOs not assessed] are not examined in this paper because [brief reason,
e.g. "they are assessed via the class test and policy report"].
```

---

## Example: complete mapping for a 4-question final exam

```markdown
# Learning Outcome Mapping
**Module:** EC5230 Industrial Organisation
**Academic year:** 2025-26
**Exam type:** Final exam — main paper
**Submission date:** 5 March 2026
**Prepared by:** [name]

| Question | Sub-part | Marks | ILOs assessed | Assessment method |
|----------|----------|-------|---------------|-------------------|
| Q1       | (a)      | 4     | ILO 1         | Derivation        |
| Q1       | (b)      | 3     | ILO 1, ILO 2  | Calculation       |
| Q1       | (c)      | 3     | ILO 2         | Interpretation    |
| Q2       | (a)      | 5     | ILO 3         | Derivation        |
| Q2       | (b)      | 5     | ILO 3, ILO 4  | Calculation       |
| Q3       | (a)      | 4     | ILO 4         | Derivation        |
| Q3       | (b)      | 3     | ILO 4, ILO 5  | Comparison        |
| Q3       | (c)      | 3     | ILO 5         | Interpretation    |
| Q4       | —        | 20    | ILO 1-5       | Essay/Integration |
| **Total**|          | **50**|               |                   |

## Coverage summary

The exam covers all five intended learning outcomes. ILO 5 (policy analysis)
is assessed primarily in Q3(c) and Q4, where students are expected to connect
theoretical results to welfare and competition-policy implications.
```
