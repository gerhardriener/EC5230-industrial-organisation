# Callout Box Guidelines (Canonical)

**Purpose:** Callout boxes should **highlight** existing content, not introduce new content or add cognitive load.

**Referenced by:**
- [slide-auditor.md](../agents/slide-auditor.md)
- [pedagogy-reviewer.md](../agents/pedagogy-reviewer.md)
- [quarto-critic.md](../agents/quarto-critic.md)

---

## Core Rules (Must Follow)

- **Removability test:** Removing the callout must not make the slide incomplete.
- **One concept per callout:** No mixing results, citations, and interpretation in the same box.
- **No new theory:** Derivations, definitions, and setup live on the main slide.
- **No tables or dense notation:** Tables and complex symbol definitions belong on the main slide.
- **Keep it short:** 15-60 words is ideal.

---

## Word Count Thresholds

| Word Count | Status | Action |
|------------|--------|--------|
| **15-60 words** | ✅ GOOD | Ideal range — concise and scannable |
| **61-80 words** | ⚠️ REVIEW | Consider splitting or moving to main slide |
| **81+ words** | ❌ NOT ALLOWED | Refactor required |

**Exception:** Brief empirical example callouts may reach **70-80 words** if structured as bullets.

---

## Callout Types (Use Sparingly)

### `::: {.callout-note}`
**Use for:** roadmap, assumptions, short notation reminders (≤3 variables), discussion questions.  
**Avoid:** full technical definitions, tables, derivations.

### `::: {.callout-important}`
**Use for:** interpretation of a key result, comparative statics, a single takeaway.  
**Avoid:** multiple results or new math.

### `::: {.callout-warning}`
**Use for:** caveats, knife-edge assumptions, parameter restrictions.  
**Avoid:** long explanations.

---

## Prohibited Content (Always Move to Main Slide)

- **Tables**
- **Complex notation definitions** (e.g., elasticity formulas)
- **Derivation steps**
- **New model setup**

---

## Quick Refactor Patterns

- **If it contains equations/tables:** move to main slide; keep a 1-sentence interpretation in the callout.
- **If it exceeds 80 words:** split into 2 callouts or move to main slide / speaker notes.
- **If it mixes concepts:** split into separate callouts or integrate into main slide text.
- **If it defines new symbols:** define on main slide; optional callout for intuition only.

---

## Placement Guide

| Content Type | Recommended Location |
|--------------|---------------------|
| Result interpretation | Callout (important) |
| Roadmap / agenda | Callout (note) |
| Caveat / knife-edge | Callout (warning) |
| Notation definition | Main slide |
| Utility / model setup | Main slide |
| Derivation steps | Main slide |
| Detailed empirical example | Speaker notes or separate slide |

---

## Minimal Examples

**GOOD (interpretation only):**
```markdown
::: {.callout-important}
The replacement effect implies incumbents invest **less** in R&D than competitive firms.
:::
```

**BAD (new theory + equations):**
```markdown
::: {.callout-note}
Consumers have $U_i(\ell)=\bar u-p_i-t(\ell-x_i)^2$ and choose firm 1 if $U_1\ge U_2$.
:::
```
**Fix:** Put equations on the main slide; keep only the interpretation in the callout.

---

## Review Checklist (For Agents)

- [ ] Word count ≤60 (flag >80)
- [ ] Removability test passes
- [ ] One concept per callout
- [ ] No tables
- [ ] No complex notation definitions
- [ ] No derivations or new setup
- [ ] Callout type matches purpose

---

**Status:** Active
