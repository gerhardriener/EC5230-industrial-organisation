# Pedagogical Review: lecture-3-innovation.qmd

**Date:** 2026-02-07
**Reviewer:** Claude Code (Pedagogy-Reviewer Agent)
**File:** `lecture-slides/slides/lecture-3-innovation.qmd`

---

## Pattern Scorecard: 7 Followed / 3 Partial / 3 Violated

| # | Pattern | Status | Severity |
|---|---------|--------|----------|
| 1 | Motivation before formalism | FOLLOWED | — |
| 2 | Incremental notation | FOLLOWED | Low |
| 3 | Worked example after every definition | PARTIAL | **High** |
| 4 | Progressive complexity | FOLLOWED | — |
| 5 | Fragment reveals for problem-solution | VIOLATED | Medium |
| 6 | Standout slides at conceptual pivots | FOLLOWED | — |
| 7 | Two-slide strategy for dense theorems | PARTIAL | **High** |
| 8 | Semantic color usage | PARTIAL | Low |
| 9 | Box hierarchy | FOLLOWED | — |
| 10 | Box fatigue (per-slide) | VIOLATED | Medium |
| 11 | Socratic embedding | PARTIAL | Medium |
| 12 | Visual-first for complex concepts | VIOLATED | **High** |
| 13 | Two-column definition comparisons | FOLLOWED | Low |

---

## Pattern Details

### Pattern 3: Worked Example After Every Definition — PARTIAL
The monopoly and competition benchmarks have worked derivations, and a numerical check appears (lines 232–241). However, the **Dasgupta-Stiglitz model** (lines 330–415) introduces the planner problem, FOC, free-entry condition, and concentration formula across four consecutive slides with **no numerical example**. Comparative statics (lines 417–451) also lack worked examples.

### Pattern 5: Fragment Reveals — VIOLATED
Zero fragment reveals (`. . .`) in the entire deck. Key "punchline" moments that should be revealed after a pause:
- Replacement effect inequality: $\Delta \pi^{pc} - \Delta \pi^m = \pi^m(c_0) > 0$
- Pre-emption condition: $V_I > V_E$
- D-S concentration formula

### Pattern 7: Two-Slide Strategy for Dense Theorems — PARTIAL
The free-entry/concentration slide (lines 387–415) crams **four equations** plus an interpretation callout onto a single slide. This is the densest slide in the deck.

### Pattern 10: Box Fatigue — VIOLATED
The perfect competition benchmark slide (lines 124–164) contains **two callout boxes** plus equations and the drastic condition. ~54% of slides have at least one callout overall.

### Pattern 11: Socratic Embedding — PARTIAL
Only **one** discussion question in the deck (line 239–241). Target is 2–3 per lecture.

### Pattern 12: Visual-First for Complex Concepts — VIOLATED
**Zero diagrams or figures** in the entire deck. Concepts crying out for visuals:
- Replacement effect: surplus rectangles under monopoly vs competition
- Drastic vs non-drastic: demand-cost diagram with threshold
- Inverted-U relationship: the iconic Aghion et al. curve
- D-S comparative statics: schematic of $N^*$ and $x^*$ co-movement

---

## Deck-Level Analysis

### Narrative Arc
Coherent and well-structured: motivation → benchmarks → replacement effect → strategic settings → Dasgupta-Stiglitz → summary. The two-way relationship framing (line 62) recurs implicitly throughout. One weakness: the transition from benchmarks to oligopoly/entry (line 243) is slightly abrupt.

### Pacing
Uneven across sections:
- **Section 1 (Motivation + Benchmarks):** 12 slides — well paced, good rhythm
- **Section 2 (Oligopoly + Entry):** 5 slides — slightly thin
- **Section 3 (Dasgupta-Stiglitz):** 7 slides — densest stretch. Four consecutive theory-heavy slides with no example or visual break (exceeds recommended max of 3–4 consecutive theory slides)

### Visual Rhythm
Heavily text-and-equation based:
- 0 diagrams/figures
- 0 R-generated plots
- 4 section dividers (good)
- 1 table, 1 numerical example
- 4 empirical callouts (all text-based)

### Notation Consistency
Generally consistent. Minor issue: social planner output $Q^{sp}$ introduced but competitive output has no symbol. The D-S section introduces entirely new notation ($U(Q)$, $c(x)$, $\alpha$, $\sigma$, $\beta$, $\varepsilon$) without flagging the shift from the linear model.

### Student Concerns
A critical MSc student might ask:
1. "Where is the proof that $\Delta \pi^{pc} > \Delta \pi^m$ in the **non-drastic** case?" (only shown for drastic)
2. "The D-S concentration formula seems to come from nowhere" — intermediate algebra is missing
3. "What are the specific functional forms in D-S?" — the switch from general to CES/isoelastic forms is not flagged
4. "The inverted-U is mentioned but never shown"
5. "How does this handle asymmetric firms?"

---

## Top 5 Critical Recommendations

### 1. Add visual diagrams for key concepts (High)
The deck has zero figures. At minimum add:
- (a) Surplus diagram illustrating the replacement effect
- (b) Demand-cost diagram showing drastic vs non-drastic threshold
- (c) Sketch of the inverted-U from Aghion et al.
These would dramatically improve retention of the three most important ideas.

### 2. Add a worked numerical example for Dasgupta-Stiglitz (High)
The D-S section has four consecutive theory slides with no example. Insert a numerical example showing how $N^*$ changes when $\alpha$ doubles or $\varepsilon$ increases. Critical for exam preparation.

### 3. Split the dense free-entry/concentration slide (High)
Lines 387–415 contain four equations, a definition, and a callout. Split into: (1) zero-profit condition and rearrangement, (2) innovative potential definition and concentration formula with interpretation.

### 4. Add fragment reveals at punchline moments (Medium)
Insert `. . .` before: (a) the replacement effect inequality, (b) the $V_I > V_E$ condition, and (c) the D-S concentration formula. Creates problem-then-solution rhythm.

### 5. Add 1–2 more Socratic questions (Medium)
Only one discussion question currently. Add after the pre-emption result and after D-S comparative statics.

---

## Overall Assessment

**Good with significant room for improvement.** The economic content is rigorous, well-sequenced, and empirically grounded. The narrative arc is clear and the replacement effect is well motivated. The main deficiencies are in *presentation* rather than *content*: the complete absence of diagrams, the dense D-S section without examples, and the lack of interactive/reveal elements. Addressing the top 3 recommendations would lift this from a competent theory-heavy lecture to an engaging and memorable one.
