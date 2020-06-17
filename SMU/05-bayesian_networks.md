# Bayesian Networks

The environment's state $s_k$ at each $k$ is a binary tuple. We assume $s_k$ are sampled i.i.d. from the distribution $P_S$ on $S = \{0, 1\}^n$.

The agent receives a subset of the $s_k$ components through observations $o_k$. Formally, $O = \{0, 1, ?\}^n$ and $\pc[P_O]{o_k}{s_k}$ generates $o_k$ by replacing a random subset of $s_k$ components with the $?$ symbol.

The components of $o_k$ with the $?$ value are called **unobserved variables**, the other components are **observed variables**.

As in concept learning, we have $A = S$ and we keep
$$r(s, a) = \begin{cases}
0 & \text{if } s = a \\
-1 & \text{otherwise}
\end{cases}
$$
So the policy value $V^\pi = \mathbb{E}\sum r_k$ is maximized by policy
$$a_k = \pi(o_k) = \argmax_{s_k \in S} \pc[P_S]{s_k}{o_k}$$
Let $I_k = \{1 \leq i \leq n \ | \ o_k \ne ?\}$, i.e. $I_k$ are indexes of the observed variables in $o_k$. Clearly, $a_k^i = o_k^i$ for $i \in I_k$, while tuple $\langle a_k^i \rangle_{i \notin I_k}$ of unobserved variables maximizes $P_S$ conditioned on the observed variables
$$\langle a_k^i \rangle_{i \notin I_k} = \argmax_{s^i \in S} \pc[P_S]{\langle s^i \rangle_{i \notin I_k}}{\langle o_k^i \rangle_{i \in I_k}}$$
Since the agent does not know $P_S$, it has to learn a model $\hat{P}_S$ of it.

## Conditional Independence

Let $I \subseteq \{ 1, 2, \dots, n \}, i, j \in \{ 1, 2, \dots, n \} \setminus I$. We say that $s^i, s^j$ are **conditionally independent given** $s^I = \{ s^i \ | \ i \in I \}$ if $\pc[P_S]{s^i, s^j}{s^I} = \pc[P_S]{s^i}{s^I} \cdot \pc[P_S]{s^j}{s^I}$.

Any vertex is conditionally independent of all of its non-descendants given all its parents.

## Bayes Graph

Denote $\mathrm{par}_G(v)$ the set of all parents of vertex $v$ in an ordered graph $G$.

A **Bayes Graph** for a distribution $P$ on variables $s^1, s^2, \dots, s^n$ is an acyclic directed graph $G$ with vertices $\{ s^1, s^2, \dots, s^n \}$ such that any $s^i$ is *conditionally independent* (w.r.t. $P$) of all its non-descendants in $G$ given $\mathrm{par}_G(s^i)$.

A Bayes graph for $P$ indictes pairs of variables conditionally independent under $P$. There may be multiple BG's for one $P$.

## Bayes Network

A **Bayes Network** for a distribution $P$ consists of a Bayes graph $G$ for $P$ and a conditional probability table for each vertex $v$ of $G$, specifying $\pc{v}{\mathrm{par}_G(v)}$.

The variables whose joint coonditional probability is computed are called **query** vars; the vars in the condition part are **evidence** vars.
$$P(\underbrace{\neg j, \neg m}_\text{query} \ | \ \underbrace{b, \neg e}_\text{evidence})$$

**Marginalization.** (summing out)
$$P(X) = \sum_y P(X, y)$$
**Conditioning.**
$$P(X) = \sum_y \pc{X}{y} \cdot P(y)$$

For each query we can get the probability by **variable elimination** method which removes redundancy from the computation by using **factors** which are arrays storing intermediate sums.

## MAP-inference

The agent's goal is to find the most probable values fo the unobserved variables given all observed values.

In the present example, this can e.g. mean: given no earthquak and no-one calls, what is the most probable joint state of alarm and burglary?

So we want the joint state with **maximum aposteriori probability**
$$\argmax_{A, B} \pc{a, b}{\neg e, \neg j, \neg m}$$

During computation we have to create factors before maximizing out one of the variables.

## Learning a Bayes Network

A Bayes network model $\hat{P}_{G, \bm{w}}$ of distribution $P$ consists of a Bayes graph $G$ and the entries of all its CPTs, jointly denoted $\bm{w}$. Two kinds of $\hat{P}$ learning

1. estimating $G$ from data,
2. given $G$, estimating $\bm{w}$ from data.

In both cases, learning is based on maximizing the **likelihood $L(G, \bm{w})$, which is the probability of the $m$ received observations according to the model
$$L(G, \bm{w}) = \hat{P}_{G, \bm{w}} (o_1, o_2, \dots, o_m)$$
but 1 is computationally much harder.

We will study only 2, i.e. assume that $G$ is agent's background knowledge and write $L_G(\bm{w})$.

### Likelihood Maximization

Given $m$ observations and $G$ with $n$ vertices denoted $1, 2, \dots, n$, find $\bm{w}$ maximizing
$$L_G(\bm{w}) = \hat{P}_{G, \bm{w}} (o_1, o_2, \dots, o_m) = \prod_{j = 1}^m \hat{P}_{G, \bm{w}} (o_j) = \prod_{j = 1}^m \prod_{i = 1}^n \hat{P}_{G, \bm{w}} (o_j^i \ | \ \mathrm{par}_G(i))$$
Parameters $\bm{w}$ consist of CPT tables $\bm{w} = \langle w^1, w^2, \dots, w^n \rangle$. Let $w^i(o)$ be the probability stored in the row of CPT $w^i$ for which the values of $o$ apply. With this notation
$$\hat{P}_{G, \bm{w}}(o^i \ | \ \mathrm{par}_G{i}) = \begin{cases}
1 & \text{if } o^i = ? \text{ or } o^j = ? \text{ for some } j \in \mathrm{par}_G(i) \\
w^i(o) & \text{if } o^i = 1 \\
1 - w^i(o) & \text{if } o^i = 0
\end{cases}
$$
Denote $m_i^+[j]$ the number of observations $o$ from $o_1, o_2, \dots, o_m$ that satisfy conditions of line $j$ in CPT $w^i$ and $o^i = 1$. Similarly define $m_i^-[j]$, except with $o^i = 0$.

Reformulate the likelihood using the counts $m_i^+[j], m_i^-[j]$
$$L(\bm{w}) = \prod_{i = 1}^n \prod_{j = 1}^{2^{|\mathrm{par}_G(i)|}} \underbrace{w^i[j]^{m_i^+[j]} (1 - w^i[j])^{m_i^-[j]}}_{= L(w^i[j])}$$
$L(\bm{w})$ is maximized by maximizing separately the likelihood $L(w^i[j])$ of each parameter $w^i[j]$. From
$$\frac{\partial L(w^i[j])}{\partial w^i[j]} = 0$$
we get for $m_i^+[j] + m_i^-[j] > 0$
$$w^i[j] = \frac{m_i^+[j]}{m_i^+[j] + m_i^-[j]}$$
which is the **relative frequency** estimate.

## BN Agent

* Keep the counts $m_i^+[j], m_i^-[j]$ for $i = 1, \dots, n, j = 1, \dots, \mathrm{par}_G(i)$ in the agent's state. Initially zero.
* On each observation, increment the appropriate counts.
* Set probabilities in all CPTs by the relative frequency.

An improvement is possible in the batch learning settings. Agent first collects a training set and then calculates its model $\bm{w}$ from it. This allows to use the EM algorithm to handle missing observation values in parameter estimation.
