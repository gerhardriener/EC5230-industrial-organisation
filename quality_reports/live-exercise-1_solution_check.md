# Solution Verification: live-exercise-1.qmd

**File:** `exercises/live/live-exercise-1.qmd`
**Verification Date:** 2026-02-09
**Verifier:** Manual algebraic check

---

## Executive Summary

**Solutions Verified:** Parts (a) through (f)
**Algebraic Errors:** 0 critical, 0 medium, 1 low
**Numerical Errors:** 0
**Economic Logic:** Sound

**Overall Assessment:** ✅ **CORRECT** (solutions are mathematically accurate)

All derivations have been independently verified. Solutions show appropriate intermediate steps and arrive at correct final answers.

---

## Part-by-Part Verification

### Part (a): Marginal consumer and demands

**Question:** Derive x* and demands q₁, q₂

**Solution Claims:**
1. Indifference: $\bar u - p_1 - t(x-a)^2 = \bar u - p_2 - t(1-a-x)^2$
2. Simplifies to: $x^* = \frac{1}{2} + \frac{p_2 - p_1}{2td}$
3. Demands: $q_1 = x^*$, $q_2 = 1 - x^*$

**Independent Verification:**

**Step 1:** Indifference condition ✓
```
U₁(x) = U₂(x)
ū - p₁ - t(x-a)² = ū - p₂ - t(1-a-x)²
p₂ - p₁ = t[(x-a)² - (1-a-x)²]
```

**Step 2:** Expand quadratics
```
(x-a)² - (1-a-x)² = (x² - 2ax + a²) - ((1-a)² - 2(1-a)x + x²)
                   = -2ax + a² - (1-a)² + 2(1-a)x
                   = -2ax + 2(1-a)x + a² - (1-a)²
                   = 2x[1-a-a] + [a² - (1-2a+a²)]
                   = 2x(1-2a) + [a² - 1 + 2a - a²]
                   = 2x(1-2a) + 2a - 1
                   = (1-2a)(2x-1)
                   = d(2x-1)  [since d = 1-2a]
```

So:
```
p₂ - p₁ = td(2x-1)
2x-1 = (p₂-p₁)/(td)
x = 1/2 + (p₂-p₁)/(2td)  ✓
```

**Verification:** ✅ CORRECT

**Note:** Solution (line 117) provides alternative derivation $(x-a)^2-(1-a-x)^2=(1-2a)(2x-1)=d(2x-1)$, which is correct and more direct.

---

### Part (b): Best responses

**Question:** Derive BR₁(p₂) and BR₂(p₁)

**Solution Claims:**
- $BR_1(p_2) = \frac{p_2 + c_1 + td}{2}$
- $BR_2(p_1) = \frac{p_1 + c_2 + td}{2}$

**Independent Verification:**

**Firm 1's problem:**
```
max π₁ = (p₁ - c₁) q₁
     p₁

where q₁ = 1/2 + (p₂-p₁)/(2td)
```

**FOC:**
```
∂π₁/∂p₁ = q₁ + (p₁-c₁)(∂q₁/∂p₁) = 0

∂q₁/∂p₁ = -1/(2td)

So: q₁ - (p₁-c₁)/(2td) = 0
    (p₁-c₁)/(2td) = q₁
    p₁ - c₁ = 2td · q₁
```

Substitute q₁:
```
p₁ - c₁ = 2td · [1/2 + (p₂-p₁)/(2td)]
        = td + (p₂-p₁)
        = td + p₂ - p₁

2p₁ = p₂ + c₁ + td

p₁ = (p₂ + c₁ + td)/2  ✓
```

**Verification:** ✅ CORRECT

By symmetry, BR₂(p₁) follows the same logic.

---

### Part (c): Price equilibrium

**Question:** Solve for (p₁*, p₂*) and (q₁*, q₂*), show price gap, discuss distance effect

**Solution Claims:**
- $p_1^* = td + \frac{2c_1 + c_2}{3}$
- $p_2^* = td + \frac{c_1 + 2c_2}{3}$
- $p_2^* - p_1^* = \frac{c_2 - c_1}{3}$
- $q_1^* = \frac{1}{2} + \frac{c_2-c_1}{6td}$
- $q_2^* = \frac{1}{2} - \frac{c_2-c_1}{6td}$

**Independent Verification:**

**System:**
```
2p₁ = p₂ + c₁ + td  ... (1)
2p₂ = p₁ + c₂ + td  ... (2)
```

From (1): $p₂ = 2p₁ - c₁ - td$

Substitute into (2):
```
2(2p₁ - c₁ - td) = p₁ + c₂ + td
4p₁ - 2c₁ - 2td = p₁ + c₂ + td
3p₁ = 2c₁ + c₂ + 3td
p₁* = td + (2c₁ + c₂)/3  ✓
```

By symmetry (or back-substitution):
```
p₂* = td + (c₁ + 2c₂)/3  ✓
```

**Price gap:**
```
p₂* - p₁* = [(c₁ + 2c₂) - (2c₁ + c₂)]/3
          = (c₂ - c₁)/3  ✓
```

**Market shares:**
```
q₁* = 1/2 + (p₂* - p₁*)/(2td)
    = 1/2 + [(c₂-c₁)/3]/(2td)
    = 1/2 + (c₂-c₁)/(6td)  ✓

q₂* = 1 - q₁*
    = 1/2 - (c₂-c₁)/(6td)  ✓
```

**Verification:** ✅ ALL CORRECT

**Distance effect (line 179):** "Distance d raises the common 'differentiation' term td in prices, hence increases average markups and profits."

**Check:** Both prices have td as additive term. As d↑, both p₁* and p₂* increase proportionally (holding costs constant). Average markup = p̄ - c̄ = td + (c₁+c₂)/3 - (c₁+c₂)/2 increases in td. ✓ SOUND

---

### Part (d): Interior condition

**Question:** Derive condition for interior split (both firms have positive market share)

**Solution Claim:**
$|c_2 - c_1| < 3td$

**Independent Verification:**

**Interior requires:** $0 < q_1^*, q_2^* < 1$

From part (c):
```
q₁* = 1/2 + (c₂-c₁)/(6td)
q₂* = 1/2 - (c₂-c₁)/(6td)
```

**Condition 1:** q₁* < 1
```
1/2 + (c₂-c₁)/(6td) < 1
(c₂-c₁)/(6td) < 1/2
c₂-c₁ < 3td
```

**Condition 2:** q₂* > 0
```
1/2 - (c₂-c₁)/(6td) > 0
1/2 > (c₂-c₁)/(6td)
3td > c₂-c₁
c₂-c₁ < 3td
```

**Condition 3:** q₁* > 0
```
1/2 + (c₂-c₁)/(6td) > 0
(c₂-c₁) > -3td
c₁-c₂ < 3td
```

**Condition 4:** q₂* < 1
```
1/2 - (c₂-c₁)/(6td) < 1
-(c₂-c₁)/(6td) < 1/2
c₁-c₂ < 3td
```

**Combined:** Conditions 1-4 reduce to $|c_2 - c_1| < 3td$ ✓

**Economic interpretation (line 191):** "If |c₂-c₁| is too large relative to td, the low-cost firm can profitably set a price that leaves the rival with (essentially) zero demand."

**Verification:** ✅ CORRECT and economically sound

---

### Part (e): Numerical check

**Question:** Compute (p₁*, p₂*, q₁*, q₂*) with a=1/4, t=2, c₁=0, c₂=1

**Solution Claims:**
- d = 1/2
- td = 1
- p₁* = 4/3
- p₂* = 5/3
- q₁* = 2/3
- q₂* = 1/3

**Independent Verification:**

**Parameters:**
```
a = 1/4
d = 1 - 2a = 1 - 2(1/4) = 1 - 1/2 = 1/2  ✓
t = 2
td = 2 · (1/2) = 1  ✓
c₁ = 0
c₂ = 1
```

**Prices:**
```
p₁* = td + (2c₁ + c₂)/3
    = 1 + (0 + 1)/3
    = 1 + 1/3
    = 4/3  ✓

p₂* = td + (c₁ + 2c₂)/3
    = 1 + (0 + 2)/3
    = 1 + 2/3
    = 5/3  ✓
```

**Market shares:**
```
q₁* = 1/2 + (c₂-c₁)/(6td)
    = 1/2 + 1/(6·1)
    = 1/2 + 1/6
    = 3/6 + 1/6
    = 4/6
    = 2/3  ✓

q₂* = 1 - q₁*
    = 1 - 2/3
    = 1/3  ✓
```

**Verification:** ✅ ALL NUMERICAL VALUES CORRECT

---

### Part (f): Discussion — quadratic vs linear costs

**Question:** Explain why quadratic costs make competition intensity depend on distance, unlike linear costs

**Solution Claim (line 209-210):**
"With quadratic costs, the demand sensitivity |∂q₁/∂p₁| = 1/(2td) depends on the distance d. Closer firms (smaller d) face more elastic demand and therefore lower markups; this makes the location game less prone to 'market capture' incentives than under linear costs."

**Independent Verification:**

**Quadratic costs (this exercise):**
```
q₁ = 1/2 + (p₂-p₁)/(2td)
∂q₁/∂p₁ = -1/(2td)

Demand elasticity ε₁ = (∂q₁/∂p₁) · (p₁/q₁) depends on d through the 1/(2td) term.
```

**Linear costs (Lecture 2):**
From lecture, with U(x) = ū - p - c|x-x_i|:
```
Marginal consumer: p₁ + cx = p₂ + cy
With x + y = L-a-b:
  x = (p₂ - p₁ + c(L+a-b))/(2c)

∂x/∂p₁ = -1/(2c)
```

The slope does NOT depend on (L-a-b), the distance between firms. Only on c.

**With quadratic costs:**
```
∂q₁/∂p₁ = -1/(2td)
```

The slope DOES depend on d.

**Economic logic:**
- Smaller d → firms closer → steeper utility penalty for mismatch → more elastic demand → fiercer price competition → lower markups
- In location stage, extreme differentiation (d large) less attractive because it softens price competition too much
- With linear costs, demand slope independent of d → location incentives distorted → "principle of minimum differentiation" breakdown

**Verification:** ✅ ECONOMICALLY SOUND and mathematically accurate

---

## Minor Issues

### Issue 1: Solution skips a step (LOW severity, line 117)

**Location:** Part (a) solution, line 117

**Current:**
"Expanding (or using $(x-a)^2-(1-a-x)^2=(1-2a)(2x-1)=d(2x-1)$) gives ..."

**Analysis:** The solution provides the factored form $(x-a)^2-(1-a-x)^2=(1-2a)(2x-1)$ without showing the expansion. While this is correct (verified above), some students may struggle to verify it.

**Impact:** LOW (advanced students can verify; others can accept the identity and proceed)

**Recommendation:** Add one line showing the expansion for completeness:
```
Expanding: (x-a)² - (1-a-x)² = (x²-2ax+a²) - ((1-a)²-2(1-a)x+x²) = (1-2a)(2x-1) = d(2x-1)
```

---

## Summary of Solution Quality

| Part | Algebraic Correctness | Numerical Accuracy | Economic Logic | Intermediate Steps | Status |
|------|----------------------|-------------------|----------------|-------------------|--------|
| (a)  | ✓ Correct | N/A | ✓ Sound | ✓ Adequate | CORRECT |
| (b)  | ✓ Correct | N/A | ✓ Sound | ✓ Good | CORRECT |
| (c)  | ✓ Correct | N/A | ✓ Sound | ✓ Good | CORRECT |
| (d)  | ✓ Correct | N/A | ✓ Sound | ✓ Adequate | CORRECT |
| (e)  | ✓ Correct | ✓ All correct | N/A | ✓ Clear | CORRECT |
| (f)  | N/A | N/A | ✓ Sound | ✓ Clear | CORRECT |

**Overall:** ✅ **CORRECT** — All solutions verified mathematically accurate

---

## Verification Method

All key derivations were independently reproduced:
1. Indifference condition solved for x* (expanded quadratics manually)
2. Best response functions derived from FOCs
3. Equilibrium system solved (substitution method)
4. Interior condition derived from inequality constraints
5. Numerical values computed independently
6. Economic reasoning checked against standard IO theory

**Confidence level:** HIGH (all critical steps verified)

---

## Recommendations

### Optional Improvements

1. **Part (a) solution:** Add one line showing quadratic expansion for transparency
2. **Part (c) solution:** Could add verification that q₁* + q₂* = 1 (consistency check)
3. **Part (f) solution:** Could reference specific line in Lecture 2 for linear cost formula comparison

**None of these affect correctness — purely pedagogical enhancements.**

---

**Report saved to:** `quality_reports/live-exercise-1_solution_verification.md`
**Conclusion:** Solutions are mathematically correct and economically sound. Ready for classroom use.
