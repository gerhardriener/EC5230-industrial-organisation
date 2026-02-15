# Slide Excellence Review: lecture-4-patents.qmd

## Overall Quality Score: GOOD

| Dimension     | Critical | Medium | Low |
| ------------- | -------- | ------ | --- |
| Visual/Layout | 1        | 5      | 6   |
| Pedagogical   | 2        | 2      | 4   |
| Proofreading  | 1        | 3      | 6   |
| Citations     | 0        | 0      | 0   |

**Totals: 4 Critical, 10 Medium, 16 Low**

---

### Critical Issues

1. **Truncated speaker notes (line 90)** — Notes on "IPRs: instruments" slide end with `[No endpoint found]`. Broken text in presenter view. *(Proofreading)*

2. **No Socratic questions on slides** — All discussion prompts are hidden in speaker notes. Surface 2–3 onto slides: "Why can't we just rely on first-mover advantage?", "Would you prefer broad-short or narrow-long?", "What happens to the duplication region as $p$ increases?" *(Pedagogy)*

3. **Zero diagrams across 30 slides** — Entirely text-and-equations. Add at minimum: (a) monopoly diagram with $\pi\nu$ profit rectangle and $\lambda\nu$ DWL triangle, (b) number-line for duplication region. *(Pedagogy + Visual)*

4. **Slide 24 overflow risk** — "Symmetric patent race: setup" has 11 content elements + callout. Split into setup + welfare benchmarks. *(Visual)*

### Medium Issues

5. **Missing $-F$ in planner formula (lines 240–242)** — Displayed equation omits $F$ that notes and numerical example include. *(Proofreading)*

6. **Inconsistent `R\&D` vs `R&D` escaping** — 5 instances use LaTeX escaping; standardise to plain `R&D`. *(Proofreading)*

7. **"Next week" label mismatch** — Preview says "multi-stage games" but Lecture 5 is titled "Repeated Games." *(Proofreading)*

8. **Patent race NE slide too dense** — Combines callout, game description, and equilibrium condition. Split into game structure + equilibrium. *(Pedagogy)*

9. **Shy model pacing** — 4 consecutive formal slides with no example/visual break. Add worked example or $x^I(\tau)$ plot. *(Pedagogy)*

10. **Inline fraction readability (slide 15)** — $\frac{\nu}{r}$ in task bullet may render too small. Promote to displayed equation. *(Visual)*

11. **Notation in callout (slide 18)** — Regime definitions in callout box; move to main slide body. *(Visual)*

12. **Wide equations (slides 21, 28)** — Maximization problem and arithmetic chains risk horizontal overflow. Break with `aligned` environments. *(Visual)*

13. **Summary slide density (slide 29)** — 7 full-sentence bullets. Shorten to fragment form. *(Visual)*

14. **Breadth notation density** — 5 new decorated symbols ($\hat{T}$, $\tilde{T}$, $\hat{\pi}_1$, $\hat{\pi}_2$, $\tilde{\pi}_1$) introduced on one slide without prior setup. *(Pedagogy)*

### Citation Key Findings

- All citations use proper `@key` syntax (`@scotchmerInnovationIncentives2006`, `@shyIndustrialOrganizationTheory1995`).
- No hardcoded author-year patterns found.
- Citation keys in section headers (lines 123, 379) should be verified for correct Pandoc rendering in RevealJS.
- **Verdict: Clean** — no citation issues requiring action.

### Recommended Next Steps

**Priority 1 (Critical fixes):**
1. Complete truncated speaker notes on line 90
2. Add 2–3 Socratic questions to slide body text
3. Create 2–3 TikZ diagrams (DWL triangle, duplication region number-line, optionally patent race payoff matrix)
4. Split slide 24 ("Symmetric patent race: setup") into two slides

**Priority 2 (Medium fixes):**
5. Add $-F$ to planner's displayed formula (line 241)
6. Standardise `R&D` escaping (5 lines)
7. Reconcile "next week" preview with Lecture 5 title
8. Split patent race NE slide (line 495) into game structure + equilibrium
9. Add worked example or plot in Shy model section
10. Break wide equations on slides 21 and 28

**Priority 3 (Low fixes):**
11. Fix double space in Shy header (line 379)
12. Use `\text{priv}` and `\text{publ}` for word-like superscripts
13. Add brief note on continuous-to-discrete time switch
14. Change `callout-warning` to `callout-important` on patent race NE slide
