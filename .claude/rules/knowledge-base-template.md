---
paths:
  - "lecture-slides/**/*.qmd"
  - "scripts/**/*.R"
---

# Course Knowledge Base: EC5230 Industrial Organisation

**Purpose:** Centralized reference for notation, narrative, applications, and design principles. Read this FIRST before creating or modifying any lecture content.

---

## 1. Notation Registry

### Core Conventions

| Rule                                 | Convention                                   | Example                               | Anti-Pattern          |
| ------------------------------------ | -------------------------------------------- | ------------------------------------- | --------------------- |
| Firm index in subscript              | Firm identity as subscript $i$ or $j$        | $q_i$, $p_j$, $c_i$                   | $q^i$, $q(i)$         |
| Equilibrium marked with star         | Nash equilibrium values use $^*$             | $p_1^*$, $q_i^*$                      | $p_1^{NE}$, $\hat{p}$ |
| Best response as $BR$                | Best response function                       | $BR_i(p_j)$                           | $R_i$, $BRF$          |
| Model superscripts for regime        | Market structure label in superscript        | $p^C$ (Cournot), $p^B$ (Bertrand)     | $p_{Cournot}$         |
| Tilde for Bertrand demand parameters | Transformed parameters in price-space demand | $\tilde{a}$, $\tilde{b}$, $\tilde{d}$ | $a'$, $a_{Bertrand}$  |
| Aggregate quantity is $Q$            | Total market output is uppercase             | $Q = \sum q_i$                        | $q_{total}$, $q_T$    |

### Symbol Reference

#### Market & Demand

| Symbol     | Meaning                                         | Introduced |
| ---------- | ----------------------------------------------- | ---------- |
| $P(Q)$     | Inverse demand function                         | L1         |
| $Q$        | Total market quantity                           | L1         |
| $q_i$      | Firm $i$'s output                               | L1         |
| $q_{-i}$   | Rival firms' combined output                    | L1         |
| $\eta$     | Price elasticity of demand $-\frac{dQ/Q}{dP/P}$ | L1         |
| $\alpha_i$ | Firm $i$'s market share $q_i/Q$                 | L1         |
| $a$        | Demand intercept (linear demand)                | L1         |
| $b$        | Own-price coefficient in differentiated demand  | L1         |
| $d$        | Cross-price coefficient (substitutability)      | L1         |

#### Costs

| Symbol    | Meaning                         | Introduced |
| --------- | ------------------------------- | ---------- |
| $c(q_i)$  | Cost function of firm $i$       | L1         |
| $c'(q_i)$ | Marginal cost                   | L1         |
| $F$       | Fixed cost of entry             | L2         |
| $m$       | Marginal cost (constant, Salop) | L2         |

#### Welfare

| Symbol | Meaning                              | Introduced |
| ------ | ------------------------------------ | ---------- |
| CS     | Consumer surplus                     | L1         |
| PS     | Producer surplus                     | L1         |
| WL     | Welfare loss (deadweight loss)       | L1         |
| $u(Q)$ | Consumer gross utility; $u'(Q)=P(Q)$ | L1         |
| $W(n)$ | Per-consumer welfare (Salop)         | L2         |

#### Spatial / Differentiation (L2)

| Symbol       | Meaning                                                | Introduced |
| ------------ | ------------------------------------------------------ | ---------- |
| $\ell$       | Consumer location (Hotelling line)                     | L2         |
| $L$          | Length of Hotelling line                               | L2         |
| $a$, $b$     | Distance of Firm 1 (Firm 2) from left (right) endpoint | L2         |
| $c$          | Mismatch / transport cost parameter                    | L2         |
| $C(d)$       | Transport cost function ($cd$ or $td^2$)               | L2         |
| $x$, $y$     | Marginal consumer distances from each firm             | L2         |
| $n$          | Number of firms (Salop)                                | L2         |
| $v$          | Net valuation $u - u^*$                                | L2         |
| $u^*$        | Outside option utility                                 | L2         |
| $\bar{u}$    | Gross utility (reservation value, Hotelling)           | L2         |
| $d_m$        | Monopoly reach (farthest served consumer)              | L2         |
| $q^M$, $q^C$ | Monopoly-region and competitive-region demand          | L2         |
| $n^C$, $n^S$ | Free-entry and socially optimal number of firms        | L2         |

#### Game Theory / Coordination (L1)

| Symbol        | Meaning                                 | Introduced |
| ------------- | --------------------------------------- | ---------- |
| $p_H$, $p_L$  | High and low price (coordination games) | L1         |
| $BR_i(\cdot)$ | Best response function of firm $i$      | L1         |

### Key Assumptions (Standard Notation)

- **Full market coverage (Hotelling):** $\bar{u}$ large enough that all consumers buy from some firm
- **Symmetric equilibrium:** In Salop, $\tilde{p} = p$ (all firms set the same price)
- **Zero profit (free entry):** $p^C = AC = m + nF$ determines equilibrium number of firms
- **Nash equilibrium:** Each firm maximises profit given rivals' strategies; no unilateral deviation is profitable

---

## 2. Course Narrative Arc

### Lecture Progression

| #   | Title                         | Core Question                                                           | Key Notation Introduced                                                              | Key Method                                      |
| --- | ----------------------------- | ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ----------------------------------------------- |
| 0   | Introduction                  | What is IO and how is the course structured?                            | —                                                                                    | —                                               |
| 1   | Oligopoly                     | How does market structure affect pricing, welfare, and coordination?    | $q_i$, $\alpha_i$, $\eta$, Lerner index, $BR_i$, $\tilde{a}$/$\tilde{b}$/$\tilde{d}$ | Cournot, Bertrand, MFN facilitating devices     |
| 2   | Product Differentiation       | How does spatial differentiation shape competition, entry, and welfare? | $\ell$, $L$, $c$, $v$, $n^C$, $n^S$, $q^M$, $q^C$                                    | Hotelling line, Salop circular city, free entry |
| 3   | Innovation                    | How do market structures affect incentives to innovate?                 |                                                                                      | Innovation under uncertainty                    |
| 4   | Patents & IPRs                | How do patents balance innovation incentives against diffusion?         |                                                                                      | Patent design, IPR policy                       |
| 5   | Multi-stage games             | How do firms commit strategically across periods?                       |                                                                                      | Subgame perfection, commitment                  |
| 6   | Cooperative R&D               | When should firms cooperate on research?                                |                                                                                      | R&D joint ventures                              |
| 7   | Bundling                      | How does bundling affect competition and welfare?                       |                                                                                      | Bundling strategies                             |
| 8   | Advertising                   | How does advertising affect market outcomes?                            |                                                                                      | Persuasive vs informative advertising           |
| 9   | Mergers                       | When do mergers harm or benefit consumers?                              |                                                                                      | Merger analysis                                 |
| 10  | Sustainable industrialisation | How can industrial policy promote sustainability?                       |                                                                                      | Policy evaluation                               |

### Connections Between Lectures

- **L1 -> L2:** Homogeneous Cournot/Bertrand -> what happens when products are differentiated? Differentiation softens price competition
- **L2 -> L3:** Product differentiation creates rents -> how do firms invest to create new products or reduce costs? Innovation incentives under different market structures
- **L3 -> L4:** Innovation requires incentives -> patents as the institutional mechanism; trade-off between ex ante incentives and ex post diffusion
- **L4 -> L5:** Single-shot strategic interactions -> multi-stage games where firms can commit (entry deterrence, capacity choice)
- **L5 -> L6:** Strategic interaction across stages -> cooperative R&D as a specific multi-stage setting

---

## 3. Empirical Applications Database

| Application                       | Paper/Source                                | Dataset                                   | R Package | Lecture(s) | Purpose                                                    |
| --------------------------------- | ------------------------------------------- | ----------------------------------------- | --------- | ---------- | ---------------------------------------------------------- |
| Alcoa natural monopoly            | Historical case (c. 1886-1914)              | —                                         | —         | L1         | Sources of market power: patents, scale, input foreclosure |
| Three-firm Cournot example        | Textbook                                    | $P=20-Q$, $c_1=0$, $c_2=5$, $c_3=7$       | —         | L1         | Compare CS/PS/WL across market structures                  |
| MFN clause as facilitating device | Cooper (1986), Salop (1986)                 | Bertrand duopoly: $Q_i=3-2p_i+p_j$, $c=1$ | —         | L1         | Self-enforcing coordination via MFN                        |
| Hotelling duopoly                 | Hotelling (1929), d'Aspremont et al. (1979) | —                                         | —         | L2         | Fixed-location pricing, clustering motives                 |
| Salop circular city               | Salop (1979)                                | —                                         | —         | L2         | Free entry, excess entry result $n^C = 2n^S$               |

### Replication Data Sources

- Interactive Shiny apps for Cournot, monopoly, profit frontiers, and Salop models (see course website)

---

## 4. Validated Design Principles

### What Has Been Approved (Do This)

| Principle                                                        | Evidence                                               | Lectures Applied |
| ---------------------------------------------------------------- | ------------------------------------------------------ | ---------------- |
| Use `clean-revealjs` theme with `#00539b` title backgrounds      | Consistent across all lectures                         | L0, L1, L2       |
| Section headers with `{background-color="#00539b"}`              | Visual separation of lecture parts                     | L1, L2           |
| Use `callout-note`, `callout-important`, `callout-warning` boxes | Highlights key insights, warnings, equilibrium results | L1, L2           |
| Dual-format support: `clean-revealjs` + `beamer`                 | Allows PDF and HTML output from same source            | L1, L2           |
| Figures via SVG (revealjs) and `\includestandalone` (beamer)     | Platform-appropriate rendering                         | L2               |
| End each lecture with References + Preview of next lecture       | Narrative continuity                                   | L1, L2           |
| Tables for comparing market structures / models                  | Side-by-side regime comparisons                        | L1, L2           |
| First introduction of a research paper or source                 | cite in the first slide where the model appears        | L1, L2, L3       |

### What Has Been Overridden (Don't Do This)

| Anti-Pattern | What Happened | Correction |
| ------------ | ------------- | ---------- |
|              |               |            |

### tikz Code Pitfalls

| Bug | Impact | Fix |
| --- | ------ | --- |
|     |        |     |

### R Code Pitfalls

| Bug | Impact | Fix |
| --- | ------ | --- |
|     |        |     |
