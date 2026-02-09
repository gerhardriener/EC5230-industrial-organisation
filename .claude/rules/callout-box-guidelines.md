# Callout Box Guidelines — Single Source of Truth

**Purpose:** Ensure callout boxes **reduce clutter** by highlighting one key point, not adding cognitive load through dense content.

**Referenced by:**
- [.claude/agents/slide-auditor.md](.claude/agents/slide-auditor.md)
- [.claude/agents/pedagogy-reviewer.md](.claude/agents/pedagogy-reviewer.md)
- [.claude/agents/quarto-critic.md](.claude/agents/quarto-critic.md)
- [.github/copilot-instructions.md](.github/copilot-instructions.md)

---

## Core Principle

**Callout boxes should HIGHLIGHT existing content, not INTRODUCE new content.**

A callout is effective when removing it would make the slide less scannable but not less complete. If removing the callout makes the slide incomplete, the content belongs on the main slide instead.

---

## Word Count Thresholds

| Word Count | Status | Action |
|------------|--------|--------|
| **15-60 words** | ✅ GOOD | Ideal range — concise, scannable |
| **61-80 words** | ⚠️ MEDIUM | Flag for review — consider splitting or moving to main slide |
| **81+ words** | ❌ CRITICAL | Too dense — refactor required |

**Exception:** Empirical example callouts (e.g., citing a study with brief context) may reach 70-80 words if well-structured with bullet points.

---

## Callout Types and Purposes

### `::: {.callout-note}`

**Purpose:** Definitions, assumptions, setup clarifications

**Good use cases:**
- Roadmap bullets (≤4 items)
- Key assumptions restated
- Notation reminders (≤3 variables)
- Interpretation of a result

**Bad use cases:**
- Introducing new notation tables (use main slide)
- Full technical definitions (use main slide)
- Multiple unrelated points (split or remove)

**Example (GOOD):**
```markdown
::: {.callout-note}
## Goal

We want to derive the equilibrium R&D investment when firms face uncertain innovation success.
:::
```
**Word count:** ~15 words ✅

**Example (BAD — too dense):**
```markdown
::: {.callout-note}
## Notation for this section

| Symbol | Meaning | Domain |
|--------|---------|--------|
| $\alpha$ | Cost elasticity $-\frac{dc(x)}{dx}\frac{x}{c}$ | $[0,1]$ |
| $c(x)$ | Post-innovation cost | $\mathbb{R}_+$ |
| $\pi^M(c)$ | Monopoly profit | $\mathbb{R}_+$ |
:::
```
**Word count:** ~50 words + complex notation + table ❌
**Fix:** Move table to main slide OR use speaker notes

---

### `::: {.callout-important}`

**Purpose:** Key results, comparative statics, main takeaways

**Good use cases:**
- Highlighting a formula's economic interpretation
- Summarizing a key finding
- Comparative statics result

**Bad use cases:**
- Derivation steps (use main slide)
- Multiple results (pick the most important OR split slides)

**Example (GOOD):**
```markdown
::: {.callout-important}
## Key result

The replacement effect implies $x^M < x^C$: monopolists invest **less** in R&D than competitive firms.
:::
```
**Word count:** ~18 words ✅

**Example (BAD — introduces new content):**
```markdown
::: {.callout-important}
## Utility (full coverage)

Consumers at location $\ell$ have utility:
$$U_1(\ell) = \bar u - p_1 - c\ell$$
$$U_2(\ell) = \bar u - p_2 - c(1-\ell)$$
where $\bar u$ is large enough that the outside option never binds.
:::
```
**Word count:** ~40 words + 2 equations ❌
**Fix:** Put utility functions on main slide; optionally add callout for interpretation ("Full coverage means...")

---

### `::: {.callout-warning}`

**Purpose:** Caveats, knife-edge assumptions, non-existence issues

**Good use cases:**
- Highlighting when a result doesn't hold
- Flagging parameter restrictions
- Warning about edge cases

**Bad use cases:**
- General discussion (use main slide or speaker notes)
- Long explanations (summarize in ≤40 words)

**Example (GOOD):**
```markdown
::: {.callout-warning}
This result assumes $v \ge p^C + \frac{c}{2n}$. If violated, some consumers choose the outside option.
:::
```
**Word count:** ~18 words ✅

---

## Content Prohibitions

**NEVER include these in callout boxes:**

### 1. Tables
**Why:** Tables are dense by nature; they belong on the main slide for proper readability

**Bad example:**
```markdown
::: {.callout-note}
| Parameter | Value | Source |
|-----------|-------|--------|
| $\alpha$ | 0.5 | Assumption |
| $\beta$ | 0.3 | Calibrated |
:::
```

**Fix:** Move table to main slide OR convert to bullet list if only 2-3 rows

---

### 2. Complex Notation Definitions

**Why:** Students need to process notation carefully; callouts are scanned, not studied

**Bad example:**
```markdown
::: {.callout-note}
Define $\alpha \equiv -\frac{dc(x)}{dx}\frac{x}{c}$ as the cost elasticity of R&D investment.
:::
```

**Fix:** Put notation definition on main slide; optionally add callout for interpretation ("Higher $\alpha$ means...")

---

### 3. New Theory or Derivations

**Why:** Callouts should restate/highlight, not teach

**Bad example:**
```markdown
::: {.callout-note}
To derive the equilibrium, substitute $p_1 = BR_1(p_2)$ into $BR_2(p_1)$...
:::
```

**Fix:** Derivation steps belong on main slide; callout can highlight the *result* ("This gives Nash equilibrium prices...")

---

### 4. Multi-Concept Mixing

**Why:** One callout = one key point

**Bad example:**
```markdown
::: {.callout-note}
The Dasgupta-Stiglitz model shows that firm size and R&D intensity are related. Arrow (1962) had a different result. Empirically, Acemoglu and Linn (2004) find support for the market size effect.
:::
```
**Word count:** ~30 words but 3 unrelated concepts ❌

**Fix:** Split into separate callouts OR integrate into main slide flow

---

## Refactoring Patterns

### Pattern 1: Dense Callout → Main Slide + Interpretation Callout

**Before (problematic):**
```markdown
::: {.callout-note}
## Notation

| Symbol | Definition |
|--------|------------|
| $\pi^M(c)$ | Monopoly profit with cost $c$ |
| $\pi^D(c,c')$ | Duopoly profit when firm has cost $c$, rival has $c'$ |
| $x$ | R&D investment |

The cost reduction is $\Delta c = c_0 - c(x)$ where $c_0$ is initial cost.
:::
```

**After (refactored):**
```markdown
## Notation

| Symbol | Definition |
|--------|------------|
| $\pi^M(c)$ | Monopoly profit with cost $c$ |
| $\pi^D(c,c')$ | Duopoly profit (own cost $c$, rival cost $c'$) |
| $x$ | R&D investment |
| $\Delta c$ | Cost reduction: $c_0 - c(x)$ |

::: {.callout-note}
Higher $x$ means larger $\Delta c$, hence lower post-innovation cost.
:::
```

---

### Pattern 2: Multi-Purpose Callout → Split or Consolidate

**Before (problematic):**
```markdown
::: {.callout-note}
The replacement effect arises because monopolists cannibalize existing profits. In contrast, competitive firms start with zero profits. Arrow (1962) first identified this. Empirically, we see less R&D in concentrated industries (Scherer 1967).
:::
```
**Word count:** ~35 words, 3 concepts ❌

**After (refactored — Option A: Split):**
```markdown
::: {.callout-important}
## Replacement effect

Monopolists cannibalize existing profits; competitive firms start with zero profits.
:::

::: {.callout-note}
## Empirical evidence

Less R&D observed in concentrated industries [@schererIndustrialMarketStructure1967].
:::
```

**After (refactored — Option B: Consolidate to main slide):**
```markdown
The **replacement effect**: monopolists invest less because R&D cannibalizes existing profits, while competitive firms start with zero profits [@arrowEconomicWelfareAllocation1962].

Empirical support: concentrated industries show lower R&D intensity [@schererIndustrialMarketStructure1967].
```

---

### Pattern 3: Definition Callout → Main Slide Definition + Optional Interpretation

**Before (problematic):**
```markdown
::: {.callout-note}
Consumer at location $\ell$ chooses firm 1 if $U_1(\ell) \ge U_2(\ell)$, where
$$U_i(\ell) = \bar u - p_i - t \cdot d(\ell, x_i)^2$$
and $d(\ell, x_i)$ is the distance from $\ell$ to firm $i$'s location $x_i$.
:::
```

**After (refactored):**
```markdown
Consumer at location $\ell$ chooses firm 1 if $U_1(\ell) \ge U_2(\ell)$:

$$U_i(\ell) = \bar u - p_i - t \cdot d(\ell, x_i)^2$$

where $d(\ell, x_i)$ is distance from $\ell$ to firm $i$'s location $x_i$.

::: {.callout-note}
Quadratic transport costs penalize distant firms more than linear costs.
:::
```

---

## When to Use Callout vs. Main Slide vs. Speaker Notes

| Content Type | Recommended Location | Rationale |
|--------------|---------------------|-----------|
| **Key result interpretation** | Callout (important) | Draws student attention to economic meaning |
| **Roadmap / agenda** | Callout (note) | Scannability; separates structure from content |
| **Caveat / assumption** | Callout (warning) | Highlights limitations without cluttering main flow |
| **Notation definition** | Main slide | Students need to study notation carefully |
| **Utility function setup** | Main slide | Core technical content, not a highlight |
| **Derivation steps** | Main slide | Step-by-step logic belongs in main flow |
| **Empirical example (brief)** | Callout (note) | Adds context without derailing theory |
| **Empirical example (detailed)** | Speaker notes OR separate slide | Too dense for callout |
| **Discussion question** | Callout (note) OR plain text | Callout if you want visual emphasis; plain italic if not |
| **Technical details** | Speaker notes | Not needed for slide readability |

---

## Review Checklist (For Agents)

When auditing callout boxes, check:

- [ ] **Word count:** ≤60 words ideal, flag >80 words
- [ ] **Content type:** Restate/highlight (not introduce new theory)
- [ ] **No tables:** Tables should be on main slide
- [ ] **No complex notation:** Notation definitions belong on main slide
- [ ] **One concept per callout:** Flag if multiple unrelated points
- [ ] **Callout type matches purpose:** `note` for definitions/setup, `important` for results, `warning` for caveats
- [ ] **Removability test:** If removing callout makes slide incomplete, content belongs on main slide

---

## Concrete Examples from Lecture 3

### GOOD Callouts ✅

**1. Roadmap (lines 37-42):**
```markdown
::: {.callout-note}
## Today

1. The value of process innovation
2. Drastic vs non-drastic innovations
3. Replacement effect (Arrow 1962)
4. Market structure and R&D (Dasgupta-Stiglitz 1980)
:::
```
**Word count:** ~20 words | **Why it works:** Scannable roadmap, appropriate use of `note` type

---

**2. Interpretation (lines 547-549):**
```markdown
::: {.callout-important}
Closer substitutes ($\alpha$ higher) → tougher price competition → lower post-innovation profit → less R&D.
:::
```
**Word count:** ~15 words | **Why it works:** Highlights economic logic without derivation details

---

### BAD Callouts ❌ (Need Refactoring)

**1. Notation table (lines 389-397):**
```markdown
::: {.callout-note}
## Notation for this section

| Symbol | Meaning | Type |
|--------|---------|------|
| $x$ | R&D investment | choice variable |
| $c(x)$ | Post-innovation cost | decreasing in $x$ |
| $\alpha \equiv -\frac{dc}{dx}\frac{x}{c}$ | Cost elasticity | $[0,1]$ |
| $n$ | Number of firms | parameter |
:::
```
**Word count:** ~50 + complex notation + table ❌
**Fix:** Move table to main slide OR use speaker notes; callout not appropriate for reference tables

---

**2. Utility definition (Lecture 2, lines 41-43):**
```markdown
::: {.callout-note}
## Utility (full coverage)

$U_1(\ell) = \bar u - p_1 - c\ell$ and $U_2(\ell) = \bar u - p_2 - c(1-\ell)$, where $\bar u$ is large enough that the outside option never binds.
:::
```
**Word count:** ~28 words + 2 equations ❌
**Fix:** Move utility functions to main slide; optionally add callout for interpretation ("Full coverage means all consumers buy from one of the two firms")

---

## Summary

**Callout boxes are valuable when used sparingly and purposefully.** They should:

- ✅ Highlight one key point
- ✅ Be 15-60 words (occasionally up to 80 for empirical examples)
- ✅ Restate/interpret content already on the slide
- ✅ Use appropriate type (note/important/warning)

**They should NOT:**

- ❌ Introduce new theory or derivations
- ❌ Contain tables or complex notation
- ❌ Mix multiple unrelated concepts
- ❌ Exceed 100 words under any circumstances

When in doubt: **main slide first, callout only if it genuinely improves scannability.**

---

**Last Updated:** 2026-02-09
**Status:** Active
