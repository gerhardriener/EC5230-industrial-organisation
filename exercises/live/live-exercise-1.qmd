---
title: "Live Exercise 1: Hotelling with quadratic transportation costs"
params:
  solution: false
format:
  html:
    toc: false
    embed-resources: true
    number-sections: false
  pdf:
    documentclass: article
    fontsize: 11pt
    geometry: margin=1in
    colorlinks: true
    linkcolor: blue
    urlcolor: blue
    number-sections: false
solutions: false
---

**Group exercise (≈15 minutes)**

- Work in groups of 3–4.
- Show your steps (the algebra is the point).
- Assume full market coverage throughout (everyone buys from one of the two firms).

## Problem: Quadratic transport costs and cost asymmetry

Consider a Hotelling line of length 1 with consumers uniformly distributed on $[0,1]$.
Each consumer buys one unit from the firm that gives higher utility.

There are two firms with *fixed locations*:

- Firm 1 at $x_1=a$
- Firm 2 at $x_2=1-a$

where $0 \le a < \frac{1}{2}$. Define the distance between firms
$d \equiv x_2-x_1 = 1-2a$.

Consumers have quasi-linear utility

$$
U_i(x) = \bar u - p_i - t(x-x_i)^2,
$$

where $t>0$ and $\bar u$ is large enough that the outside option never binds.
Firm $i$ has constant marginal cost $c_i$ and chooses price $p_i$ simultaneously.

### (a) Marginal consumer and demands

Let $x^*$ be the consumer indifferent between the two firms (assume $x^* \in (a,1-a)$).

1. Write the indifference condition defining $x^*$.
2. Solve for $x^*$ as a function of $(p_1,p_2,t,a)$.
3. Use your result to write demands $q_1(p_1,p_2)$ and $q_2(p_1,p_2)$.

*Hint:* For $x \in (a,1-a)$ you can drop absolute values; only squared distances matter.

### (b) Best responses in prices

Firm $i$’s profit is

$$
\pi_i(p_i,p_j) = (p_i-c_i)\,q_i(p_i,p_j).
$$

1. Take the first-order condition for Firm 1 and simplify it into a linear best response $BR_1(p_2)$.
2. Do the same for Firm 2.

### (c) Price equilibrium (Nash in prices)

Solve the system of best responses to get equilibrium prices $(p_1^*,p_2^*)$.
Then compute equilibrium market shares $(q_1^*,q_2^*)$.

1. Show that the *price gap* satisfies $p_2^*-p_1^*=\frac{c_2-c_1}{3}$.
2. How does *distance* $d$ affect the average markup? (Be explicit.)

### (d) When does one firm capture the whole market? (optional challenge)

Your answer in (a)–(c) assumed an interior split ($x^*\in(0,1)$).

1. Derive the condition on the cost difference $\Delta c \equiv c_2-c_1$ (relative to $t$ and $d$) under which the interior split is valid.
2. Give a short economic interpretation: what happens if $|\Delta c|$ is “too large”?

### (e) Quick numerical check (2 minutes)

Take $a=\frac{1}{4}$, $t=2$, $c_1=0$, $c_2=1$.
Compute $(p_1^*,p_2^*,q_1^*,q_2^*)$.

### (f) Discussion: why quadratic costs matter (1–2 minutes)

In the linear Hotelling model with $U_i(x)=\bar u-p_i-c|x-x_i|$ (and an interior indifferent consumer),
the slope of demand with respect to price does *not* depend on the distance between firms.

- Using your expressions above, explain why with **quadratic** costs the toughness of price competition *does* depend on $d$.
- How does this help explain why the quadratic-cost Hotelling *location* game is better behaved than the linear-cost one?


::: {.content-hidden unless-meta="solutions"}

## Suggested solution (sketch)

### (a)

Indifference:

$$
\bar u - p_1 - t(x-a)^2 = \bar u - p_2 - t(1-a-x)^2.
$$

Cancel $\bar u$ and rearrange:

$$
p_2-p_1 = t\big[(x-a)^2-(1-a-x)^2\big].
$$

Expanding (or using $(x-a)^2-(1-a-x)^2=(1-2a)(2x-1)=d(2x-1)$) gives

$$
x^*=\frac{1}{2}+\frac{p_2-p_1}{2td}.
$$

For an interior split, demands are

$$
q_1 = x^*,
\qquad
q_2 = 1-x^*.
$$

### (b)

Using $q_1=\frac{1}{2}+\frac{p_2-p_1}{2td}$, we have $\frac{\partial q_1}{\partial p_1}=-\frac{1}{2td}$.
FOC for Firm 1:

$$
0=\frac{\partial \pi_1}{\partial p_1}
= q_1 + (p_1-c_1)\frac{\partial q_1}{\partial p_1}
= q_1 - \frac{p_1-c_1}{2td}.
$$

So $p_1-c_1=2td\,q_1$, i.e.

$$
p_1-c_1 = 2td\left(\frac{1}{2}+\frac{p_2-p_1}{2td}\right)
= td + p_2 - p_1
\quad \Rightarrow \quad
BR_1(p_2)=\frac{p_2+c_1+td}{2}.
$$

Similarly,

$$
BR_2(p_1)=\frac{p_1+c_2+td}{2}.
$$

### (c)

Solve
$2p_1=p_2+c_1+td$ and $2p_2=p_1+c_2+td$ to get

$$
p_1^* = td + \frac{2c_1+c_2}{3},
\qquad
p_2^* = td + \frac{c_1+2c_2}{3}.
$$

Price gap:
$p_2^*-p_1^*=\frac{c_2-c_1}{3}$.

Market shares:

$$
q_1^*=\frac{1}{2}+\frac{c_2-c_1}{6td},
\qquad
q_2^*=\frac{1}{2}-\frac{c_2-c_1}{6td}.
$$

Distance $d$ raises the common “differentiation” term $td$ in prices, hence increases average markups and profits.

### (d)

Interior split requires $q_1^*,q_2^* \in (0,1)$, i.e.

$$
\left|\frac{c_2-c_1}{6td}\right| < \frac{1}{2}
\quad \Leftrightarrow \quad
|c_2-c_1| < 3td.
$$

If $|c_2-c_1|$ is too large relative to $td$, the low-cost firm can profitably set a price that leaves the rival with (essentially) zero demand.

### (e)

Here $d=1-2a=\frac{1}{2}$ and $td=1$, so

$$
p_1^* = 1+\frac{1}{3}=\frac{4}{3},
\qquad
p_2^* = 1+\frac{2}{3}=\frac{5}{3},
\qquad
q_1^*=\frac{2}{3},
\qquad
q_2^*=\frac{1}{3}.
$$

### (f)

With quadratic costs, the demand sensitivity $\left|\frac{\partial q_1}{\partial p_1}\right|=\frac{1}{2td}$ depends on the distance $d$.
Closer firms (smaller $d$) face more elastic demand and therefore lower markups; this makes the location game less prone to “market capture” incentives than under linear costs.

:::
