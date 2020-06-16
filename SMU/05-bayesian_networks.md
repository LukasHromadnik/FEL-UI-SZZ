# Bayesian Networks

## Inference with the full joint model

**Marginalization** (summing out) to obtain prior probabilites
$$P(X) = \sum_{y \in Y} P(X, y)$$
**Normalization** follows too obtain conditional probabilities
$$\pc{X}{Y} = \frac{P(X, Y)}{P(Y)}$$
or it works with a normalizatino constant $\alpha$.

## Conditional independence

$A$ and $B$ are conditionally independent given $C$ if
$$\pc{A, B}{C} = \pc{A}{C} \times \pc{B}{C}, \ \forall A, B, C, P(C) \ne 0$$

## D-separation

Uses connections to determine conditional independence between sets of nodes

* linear and diverging connections transit information **not given** middle node,
* converging connection transmits information **given** middle node / its descendant.

![D-separation](assets/d-separation.png)

## Bayesian Network

Is a DAG, nodes represent random variables (typically discrete), edges represent direct dependence and nodes are annotated by probabilities (table, distributions).

Each node is conditioned by conjuction of all its parents
$$\pc{O_{i + 1}}{O_1, \dots, O_i} = \pc{O_{i + 1}}{parents(O_{i + 1})}$$
Root nodes are annotaed by prior distributions.

### Characteristics of qualitative model

* **Correctness** – $\pc{O_{i + 1}}{parents(O_{i + 1})}$ holds in reality
* **Efficiency** – actual CI relations described by the minimum number of edges
* **Causality** – edge directinos agree with actual cause-effect relationships

## Inference by enumeration

Conditional probabilities calculated by summing the elements of joint probability table.

### Variable elimination

1. Pre-computes **factors** for recycling the earlier computed intermediate results, some variables are eliminated by summing them out.
2. Does not consider variables irrelevant to the query.
