# Abstraction

Abstracting a transition system means **dropping some distinctions** between states, while **preserving the transition behavior** as much as possible.

An abstraction of a transition system $\mathcal{T}$ is defined by an **abstraction mapping $\alpha$** that defines which states of $\mathcal{T}$ should be distinguished and which ones should not.

From $\mathcal{T}$ and $\alpha$ we compute an **abstract transition system** $\mathcal{T}'$ which is similar to $\mathcal{T}$, but smaller.

The abstract goal distances (goal distances in $\mathcal{T}'$) are used as heuristic estimates for goal distances in $\mathcal{T}$.

We want to obtain an *admissible heuristic*. Hence, $h^*(\alpha(s))$ (in the abstract state space $\mathcal{T}'$) should never overestimate $h^*(s)$ (in the concrete state space $\mathcal{T}$).

An easy way to achieve this is to ensure that all solutions in $\mathcal{T}$ also exist in $\mathcal{T}'$:

* if $s$ is a goal state in $\mathcal{T}$, then $\alpha(s)$ is a goal state in $\mathcal{T}'$,
* if $\mathcal{T}$ has a transition from $s$ to $t$, then $\mathcal{T}'$ has a transition from $\alpha(s)$ to $\alpha(t)$.

To be useful in practice, an abstraction heuristic must be efficiently computable.

A **transition system** is a tuple $\mathcal{T} = \langle S, L, T, I, G \rangle$ where

* $S$ is a finite set of **states**,
* $L$ is a finite set of **labels**, each label has a **cost** $c(l): L \rightarrow \mathbb{R}_0^+$,
* $T \subseteq S \times L \times S$ is a **transition relation**,
* $I \subseteq S$ is a set of initial states and
* $G \subseteq S$ is a set of goal states.

Given a FDR planning task $P = \langle \mathcal{V}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$, $\mathcal{T}(P) = \langle S, L, T, I, G \rangle$ denote a **transition system of $P$** where

* $S$ is a set of states over $\mathcal{V}$,
* $L = \mathcal{O}$,
* $T = \{(s, o, t) \ | \ \f{res}{o, s} = t \}$,
* $I = \{ s_{init} \}$ and
* $G = \{ s \ | \ s \in S, s \text{ is consistent with } s_{goal}\}$.

## Abstraction heuristics

Let $\mathcal{T}^1 = \langle S^1, L, T^1, I^1, G^1 \rangle$ and $\mathcal{T}^2 = \langle S^2, L, T^2, I^2, G^2 \rangle$ denote two transition systems with the same set of labels and let $\alpha: S^1 \mapsto S^2$. We say that $S^2$ is an **abstraction of $S^1$** with **abstraction function $\alpha$** if it holds

* for every $s \in I^1$ that $\alpha(s) \in I^2$,
* for every $s \in G^1$ that $\alpha(s) \in G^2$ and
* for every $(s, l, t) \in T^1$ that $(\alpha(s), l, \alpha(t)) \in T^2$.

Let $P$ denote a FDR planning task, let $\mathcal{A}$ denote an abstraction of transition system $\mathcal{T}(P) = \langle S, L, T, I, G \rangle$ with the abstraction function $\alpha$. The **abstraction heuristic** induced by $\mathcal{A}$ and $\alpha$ is the function $\h{\mathcal{A}, \alpha}(s) = \h{*}(\mathcal{A}, \alpha(s)), \forall s \in S$.

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

**Projections.** Let $\Pi$ be an $\mathrm{SAS}^+$ planning task with the variable set $V$ and the state set $S$. Let $P \subseteq V$ and let $S'$ be the set of states over $P$. The *projection* $\pi_P: S \rightarrow S'$ is defined as $\pi_P(s) := s|_P$ (with $s|_P(v) := s(v), \forall v \in P$). We call $P$ the **pattern** of the projection $\pi_P$.

In other words, $\pi_P$ maps two states $s_1$ and $s_2$ to the same abstract state iff they agree on all variables in $P$.

The abstraction heuristic induced by $\pi_P$ is called a **pattern database heuristic** (PDB heuristic). We write $h^P$ as a short-hand for $h^{\pi_P}$.

## Merge & Shrink Abstractions

Main idea: instead of perfectly reflecting a few state variables, reflect all state variables but in a potentially lossy way.

Given two transition systems $\mathcal{T}^1 = \langle S^1, L, T^1, I^1, G^1 \rangle$ and $\mathcal{T}^2 = \langle S^2, L, T^2, I^2, G^2 \rangle$ with the same set of labels, the **synchronized product** $\mathcal{T}^1 \otimes \mathcal{T}^2 = \mathcal{T}$ is a transition system $\mathcal{T} = \langle S, L, T, I, G \rangle$ where

* $S = S^1 \times S^2$,
* $T = \{((s_1, s_2), l, (t_1, t_2)) \ | \ (s_1, l, t_1) \in T^1, (s_2, l, t_2) \in T^2 \}$,
* $I = I^1 \times I^2$ and
* $G = G^1 \times G^2$.

\begin{algorithm}[!htp]
\caption{Algorithm for computing merge-and-shrink}
\hspace*{\algorithmicindent} \textbf{Input:} $P = \langle \mathcal{V}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$ \\
\hspace*{\algorithmicindent} \textbf{Output:} Abstraction $\mathcal{M}$
\begin{algorithmic}[1]
\State $\mathcal{A} \gets$ set of (atomic) abstractions $(\alpha_i, T_i)$ of $\mathcal{T}(P)$
\While{$|\mathcal{A}| > 1$}
    \State $A_1 = (\alpha_1, T_1), A_2 = (\alpha_2, T_2) \gets$ select two abstractions from $\mathcal{A}$
    \State Shrink $A_1$ and / or $A_2$ until they are "small enough"
    \State $\mathcal{A} \gets (\mathcal{A} \setminus \{ A_1, A_2 \}) \cup (A_1 \otimes A_2$) \Comment Merge
\EndWhile
\State $\mathcal{M} \gets$ the only element of $\mathcal{A}$
\end{algorithmic}
\end{algorithm}

## Generic abstraction computation procedure

1. **Initialization step:** Compute all abstract transition systems for atomic projections to form the initial abstraction collection.
2. **Merge steps:** Combine two abstractions in the collection by replacing them with their synchronized product.
3. **Shrink steps:** If the abstractions in the collection are too large to compute their synchronized product, make them smaller by abstracting them further.
