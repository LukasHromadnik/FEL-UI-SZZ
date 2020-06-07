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

## Formally

**Transition system.** A *transition system* is a 5-tuple $\mathcal{T} = (S, L, T, I, G)$ where

* $S$ is a finite set of state,
* $L$ is a finite set of (transition) labels,
* $T \subseteq S \times L \times S$ is the transition relation,
* $I \subseteq S$ is the set of initial states and
* $G \subseteq S$ is the set of goal states.

We say that $\mathcal{T}$ has the transition $\langle s, l, s' \rangle$ if $\langle s, l s' \rangle \in \mathcal{T}$.

Let $\mathcal{T} = (S, L, T, I, G)$ and $\mathcal{T}' = (S', L', T', I', G')$ be transition systems with the same label set $L = L'$, and let $\alpha: S \rightarrow S'$.

We say that $\mathcal{T}'$ is an **abstraction of $\mathcal{T}$ with abstraction mapping $\alpha$** if

* $\forall s \in I$, we have $\alpha(s) \in I'$,
* $\forall s \in G$, we have $\alpha(s) \in G'$,
* $\forall \langle s, l, t \rangle \in T$, we have $\langle \alpha(s), l \alpha(t) \rangle \in T'$.

**Abstraction heuristic.** Let $\Pi$ be an $\mathrm{SAS}^+$ planning task with state space $S$, and let $\mathcal{A}$  be  an abstraction of $\mathcal{T}(\Pi)$ with abstraction mapping $\alpha$. The *abstraction heuristic* induced by $\mathcal{A}$ and $\alpha$ is the heuristic function $h^{\mathcal{A}, \alpha}: S \rightarrow \mathbb{N}_0 \cup \{ \infty \}$ whcih maps each state $s \in S$ to $h_\mathcal{A}^*(\alpha(s))$ (the goal distance of $\alpha(s)$ in $\mathcal{A}$).

The $h^{\mathcal{A}, \alpha}$ is safe, gaol-aware, admissible and consistent.

**Orthogonal abstraction mappings.** Let $\alpha_1$ and $\alpha_2$ be abstraction mappings on $\mathcal{T}$. We say that $\alpha_1$ and $\alpha_2$ are *orthogonal* if for all transitions $\langle s, l, t \rangle$ of $\mathcal{T}$  we have $\alpha_i(s) = \alpha_i(t)$ for at least one $i \in \{1, 2\}$.
