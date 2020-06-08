# Abstraction

Abstracting a transition system means **dropping some distinctions** between states, while **preserving the transition behaviour** as much as possible.

An abstraction of a transition system $\mathcal{T}$ is defined by an **abstraction mapping $\alpha$** that defines which states of $\mathcal{T}$ should be distinguished and which ones should not.

From $\mathcal{T}$ and $\alpha$ we compute an **abstract transition system** $\mathcal{T}'$ which is similar to $\mathcal{T}$, but smaller.

The abstract goal distances (goal distances in $\mathcal{T}'$) are used as heuristic estimates for goal distances in $\mathcal{T}$.

We want to obtain an *admissible heuristic*. Hence, $h^*(\alpha(s))$ (in the abstract state space $\mathcal{T}'$) should never overestimate $h^*(s)$ (in the concrete state space $\mathcal{T}$).

An easy way to achieve this is to ensure that all solutions in $\mathcal{T}$ also exist in $\mathcal{T}'$:

* if $s$ is a goal state in $\mathcal{T}$, then $\alpha(s)$ is a goal state in $\mathcal{T}'$,
* if $\mathcal{T}$ has a transition from $s$ to $t$, then $\mathcal{T}'$ has a transition from $\alpha(s)$ to $\alpha(t)$.

To be useful in practice, an abstraction heuristic must be efficiently computable.

**Transition system.** A *transition system* is a 5-tuple $\mathcal{T} = (S, L, T, I, G)$ where

* $S$ is a finite set of state,
* $L$ is a finite set of (transition) labels,
* $T \subseteq S \times L \times S$ is the transition relation,
* $I \subseteq S$ is the set of initial states and
* $G \subseteq S$ is the set of goal states.

We say that $\mathcal{T}$ has the transition $\langle s, l, s' \rangle$ if $\langle s, l, s' \rangle \in \mathcal{T}$.

## Abstraction heuristics

Let $\mathcal{T} = (S, L, T, I, G)$ and $\mathcal{T}' = (S', L', T', I', G')$ be transition systems with the same label set $L = L'$, and let $\alpha: S \rightarrow S'$.

We say that $\mathcal{T}'$ is an **abstraction of $\mathcal{T}$ with abstraction mapping $\alpha$** if

* $\forall s \in I$, we have $\alpha(s) \in I'$,
* $\forall s \in G$, we have $\alpha(s) \in G'$,
* $\forall \langle s, l, t \rangle \in T$, we have $\langle \alpha(s), l, \alpha(t) \rangle \in T'$.

**Abstraction heuristic.** Let $\Pi$ be an $\mathrm{SAS}^+$ planning task with state space $S$, and let $\mathcal{A}$  be  an abstraction of $\mathcal{T}(\Pi)$ with abstraction mapping $\alpha$. The *abstraction heuristic* induced by $\mathcal{A}$ and $\alpha$ is the heuristic function $h^{\mathcal{A}, \alpha}: S \rightarrow \mathbb{N}_0 \cup \{ \infty \}$ which maps each state $s \in S$ to $h_\mathcal{A}^*(\alpha(s))$ (the goal distance of $\alpha(s)$ in $\mathcal{A}$).

The $h^{\mathcal{A}, \alpha}$ is safe, goal-aware, admissible and consistent.

**Orthogonal abstraction mappings.** Let $\alpha_1$ and $\alpha_2$ be abstraction mappings on $\mathcal{T}$. We say that $\alpha_1$ and $\alpha_2$ are *orthogonal* if for all transitions $\langle s, l, t \rangle$ of $\mathcal{T}$  we have $\alpha_i(s) = \alpha_i(t)$ for at least one $i \in \{1, 2\}$.

Let $h^{\mathcal{A}_1, \alpha_1}, \dots, h^{\mathcal{A}_n, \alpha_n}$ be abstraction heuristics for the same planning task $\Pi$ such that $\alpha_i$ and $\alpha_j$ are orthogonal for all $i \ne j$. Then $\sum_{i = 1}^n h^{\mathcal{A}_i, \alpha_i}$ is a safe, goal-aware, admissible and consistent heuristic for $\Pi$.

In practice there are conflicting goals for abstractions:

* we want to obtain an **informative heuristic**, but
* we want to keep its **representation small**.

Abstractions have small representations if they have

* **few abstract states** and
* a **succinct encoding for $\alpha$**.

## Pattern database heuristic

A pattern database heuristic for a planning task is an abstraction heuristic where

* some aspects of the task are represented in the abstraction **with perfect precision**, while
* all other aspects of the task are **not represented at all**.

**Projections.** Let $\Pi$ be an $\mathrm{SAS}^+$ planning task with variable set $V$ and state set $S$. Let $P \subseteq V$ and let $S'$ be the set of states over $P$. The *projection* $\pi_P: S \rightarrow S'$ is defined as $\pi_P(s) := s|_P$ (with $s|_P(v) := s(v), \forall v \in P$). We call $P$ the **pattern** of the projection $\pi_P$.

In other words, $\pi_P$ maps two states $s_1$ and $s_2$ to the same abstract state iff they agree on all variables in $P$.

The abstraction heuristic induced by $\pi_P$ is called a **pattern database heuristic** (PDB heuristic). We write $h^P$ as a short-hand for $h^{\pi_P}$.

## Merge & Shrink Abstractions

Main idea: instead of perfectly reflecting a few state variables, reflect all state variables but in a potentially lossy way.

**Synchronized product of transition systems.** For $i \in \{1, 2\}$, let $\mathcal{T}_i = (S_i, L, T_i, I_i, G_i)$ be transition systems with identical label set. The *synchronized product* of $\mathcal{T}_1$ and $\mathcal{T}_2$, in symbols $\mathcal{T}_1 \otimes \mathcal{T}_2$, is the transition system $\mathcal{T}_\otimes = (S_\otimes, L, T_\otimes, I_\otimes, G_\otimes)$ with

* $S_\otimes = S_1 \times S_2$,
* $T_\otimes = \left\{ \langle (s_1, s_2), l, (t_1, t_2) \rangle \ | \ \langle s_1, l, t_1 \rangle \in T_1 \text{ and } \langle s_2, l, t_2 \rangle \in T_2 \right\}$,
* $I_\otimes = I_1 \times I_2$,
* $G_\otimes = G_1 \times G_2$.

## Generic abstraction computation procedure

1. **Initialization step:** Compute all abstract transition systems for atomic projections to form the initial abstraction collection.
2. **Merge steps:** Combine two abstractions in the collection by replacing them with their synchronized product.
3. **Shrink steps:** If the abstractions in the collection are too large to compute their synchronized product, make them smaller by abstracting them further.
