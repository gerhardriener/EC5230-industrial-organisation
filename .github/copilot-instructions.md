# **Copilot Instructions for EC5230 – Industrial Organisation**

## **Course Context**

This is a **formal MSc-level Industrial Organisation course** at the **University of St Andrews**.
All content must follow **textbook microeconomic standards** (Tirole, Vives, Shy, Cabral, Belleflamme & Peitz).

This is **not** a blog, not a policy site, and not popular economics.
It is a **theory-first course** designed for **exam-grade economic reasoning**.

---

# **I. Pedagogical and Epistemic Discipline**

## **1. No Hallucinated Theory**

Never invent:

* equilibrium concepts
* welfare criteria
* strategic effects
* terminology

Every concept must be:

* **standard** (Nash equilibrium, best response, residual demand, elasticity, etc.), or
* **explicitly defined** on the slide.

---

## **2. One Core Economic Object per Slide**

Each slide must have **one primary object**:

* model
* equilibrium
* intuition
* comparative statics
* evidence
* policy implication

Other content may support this object but not replace it.

---

## **3. Slide Grammar**

Each slide has:

**Title (`##`)** → names an **economic object**

Then one of:

* Definition
* Model
* Result
* Intuition
* Implication

No rhetorical titles.

---

## **4. Mathematical Hygiene**

All equations:

* use `$` and `$$`
* are standard or derived later
* define all variables
* classify variables as choice, parameter, or equilibrium outcome

---

## **5. No Narrative Fluff**

No anecdotes.
No filler.
No untethered policy talk.

---

## **6. Model-Consistent Examples**

All examples must satisfy equilibrium logic.

---

## **7. Visuals Encode Theory**

All curves and objects must be named.

---

## **8. Slides Are Lecture Notes**

Readable, exam-usable, minimal but complete.

---

## **9. Exams Are the Target**

Every slide must support at least one exam-type question.

---

## **10. Stability Over Creativity**

Preserve notation and canonical order.

---

# **II. Slide Types**

Each slide is one of:

* **MODEL**
* **NARRATIVE**
* **HYBRID** (≥80% one purpose + ≤20% anchor)

---

# **III. Density and Interpretation**

Target per slide:

* 4–10 bullets
* or 1–2 equations + 2–5 bullets
* or 1 figure + 3–6 bullets

Hard limits:

* max 12 bullets
* max 2 equations
* max 1 figure

MODEL and HYBRID slides should include **equation + interpretation**.

---

# **IV. Formatting**

Always leave a blank line **before and after lists**.

---

# **V. Slide Linting**

Slides must satisfy:

* clear type
* correct title
* correct density
* symbols defined
* narrative not introducing theory
* forward logical flow
* exam usability

---

# **VI. University of St Andrews Visual Identity**

## **Typefaces**

Use official University fonts:

* **Primary:** PT Sans
  `font-family: 'PT Sans', Helvetica, Arial, sans-serif;`
* **Secondary (long text only):** PT Serif
  `font-family: 'PT Serif', Georgia, 'Times New Roman', serif;`

Slides must use **PT Sans** for all headings and body text.

---

## **Colour System**

Use only official University colours.

### **Primary**

| Meaning              | Colour                          |
| -------------------- | ------------------------------- |
| Institutional anchor | **St Andrews Blue** `#00539b`   |
| Critical / warning   | **St Andrews Red** `#ee312a`    |
| Highlight / key      | **St Andrews Yellow** `#ffdf00` |
| Text                 | **St Andrews Black** `#231f20`  |

### **Secondary (plots only)**

| Use         | Colour               |
| ----------- | -------------------- |
| Firm 1      | Mid Blue `#007dc5`   |
| Firm 2      | Burgundy `#c60c46`   |
| Efficient   | Green `#54b948`      |
| Inefficient | Dark Green `#005953` |
| Optional    | Purple `#7b439a`     |
| Optional    | Orange `#f5842b`     |

White must be used generously.

---

# **VII. ggplot2 Standards**

Use:

```r
theme_econ <- theme_minimal() + theme(
  panel.grid.major = element_line(color = "gray90"),
  panel.grid.minor = element_blank(),
  plot.title = element_text(size = 14, face = "bold"),
  axis.title = element_text(size = 11)
)
```

### Colour rules

* Use only St Andrews palette
* Never more than **4 colours**
* Never rely on colour alone — always also use linetype, shape, or labels
* Must remain interpretable in grayscale

---

# **VIII. Shiny Apps**

Each app must:

* illustrate one model
* show equilibrium
* show formulas
* label all curves and equilibria
* use theme_econ

---

# **IX. File Structure**

Slides → `lecture-slides/markdown/`
Theme → `lecture-slides/theme/`
Apps → `shiny-apps/`
Exercises → `exercises/`

---

# **X. Rendering**

Use:

```bash
quarto preview
quarto render
```

All `.qmd` must be listed in `_quarto.yml`.

---

# **XI. Final Integrity Check**

Before accepting output:

* no hallucinated theory
* equations standard or derived
* variables defined
* examples consistent
* density correct
* hybrid obeys 80/20
* St Andrews colours only
* grayscale-safe plots
* blank lines around lists

---

**End of EC5230 Copilot Instructions**

