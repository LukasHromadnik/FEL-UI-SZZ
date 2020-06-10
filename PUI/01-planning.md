# Planning

## STRIPS

A STRIPS **planning task** $\Pi$ is specified by a tuple $\Pi = \langle \mathcal{F}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$, where

* $\mathcal{F} = \{f_1, \dots, f_n\}$ is a **set of facts**,
* $\mathcal{O} = \{o_1, \dots, o_n\}$ is a set of operators,
* $s_{init} \subseteq \mathcal{F}$ is an initial state,
* $s_{goal} \subseteq \mathcal{F}$ is a goal state and
* $c: \mathcal{O} \to \mathbb{R}_0^+$ is a cost function mapping each operator to a non-negative real number.

A **state** $s \subseteq \mathcal{F}$ is a set of facts.

An **operator** $o \in \mathcal{O}$ is a triplet $o = \langle \pre(o), \add(o), \del(o) \rangle$ where

* $\pre(o) \subseteq \mathcal{F}$ is a set of preconditions,
* $\add(o) \subseteq \mathcal{F}$ is a set of add effects and
* $\del(o) \subseteq \mathcal{F}$ is a set of delete effects.

All operators are well-formed, i.e. $\add(o) \cap \del(o) = \emptyset$ and $\pre(o) \cap \add(o) = \emptyset$.

An operator $o$ is **applicable** in a state $s$ if $\pre(o) \subseteq s$. The resulting state of applying an applicable operator $o$ in a state $s$ is the state $o[s] = \left( s \setminus \del(o) \right) \cup \add(o)$.

A state $s$ is a **goal state** iff $s_{goal} \subseteq s$.

A **sequence of operators** $\pi = \langle o_1, \dots, o_n \rangle$ is applicable in a state $s_0$ if there are states $s_1, \dots, s_n$ such that $o_i$ is applicable in $s_{i - 1}$ and $s_i = o_i[s_{i - 1}]$ for $1 \leq i \leq n$. The resulting state of this application is $\pi[s_0] = s_n$ and the cost of the plan is $c(\pi) = \sum_{o \in \pi} c(o)$.

A sequence of operators $\pi$ is called a **plan** iff $s_{goal} \subseteq \pi[s_{init}]$. An **optimal plan** is the plan with the minimal cost over all plans.

## FDR

A Finite Domain Representation (FDR) **planning task** $P$ is specified by a tuple $P = \langle \mathcal{V}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$, where

* $\mathcal{V}$ is a finite set of **variables**, each variable $V \in \mathcal{V}$ has a finite domain $D_V$,
* $\mathcal{O} = \{o_1, \dots, o_n\}$ is a set of operators,
* $s_{init}$ is the initial (complete) state,
* $s_{goal}$ is the goal (partial) state,
* $c: \mathcal{O} \to \mathbb{R}_0^+$ is a cost function mapping each operator to a non-negative real number.

A (partial) **state** is a (partial) variable assignment over $\mathcal{V}$. We write $\vars(s)$ for the set of variables defined in $s$ and $s[V]$ for the value of $V$ in $s$. The notation $s[V] = \bot$ means that $V \notin \vars(s)$.

A partial state $s$ is **consistent** with a partial state $s'$ if $s[V] = s'[V], \forall V \in \vars(s')$.

We say that **atom** $V = v$ is true in a (partial) state $s$ iff $s[V] = v$.

An **operator** $o \in \mathcal{O}$ is a pair $o = \langle \pre(o), \eff(o) \rangle$ where precondition $\pre(o)$ and effect $\eff(o)$ are partial assignments over $\mathcal{V}$. We require that $V = v$ cannot be both a precondition and an effect.

An operator $o$ is **applicable** in a state $s$ if $s$ is consistent with $\pre(o)$.

The **resulting state** of applying an applicable operator $o$ in the state $s$ is the state $\mathrm{res}(o, s)$ with
$$\mathrm{res}(o, s) = \begin{cases}
\eff(o)[V] & \text{if } V \in \vars(\eff(o)), \\
s[V] & \text{otherwise}.
\end{cases}
$$

A **sequence of operators** $\pi = \langle o_1, \dots, o_n \rangle$ is applicable in a state $s_0$ if there are states $s_1, \dots, s_n$ such that $o_i$ is applicable in $s_{i - 1}$ and $s_i = \mathrm{res}(o_i, s_{i - 1})$ for $1 \leq i \leq n$. The resulting state of this application is $\mathrm{res}(\pi, s_0) = s_n$ and the cost of the plan is $c(\pi) = \sum_{o \in \pi} c(o)$.

A sequence of operators $\pi$ is called a **plan** iff $\mathrm{res}(\pi, s_{init})$ is consistent with $s_{goal}$ and an **optimal plan** is the plan with the minimal cost over all plans.

## Heuristic search

**Heuristic.** Let $\Sigma$ be the set of nodes of a given search space. A *heuristic function* is a function $h: \Sigma \rightarrow \mathbb{N}_0 \cup \{ \infty \}$.

The value of $h(\sigma)$ is called the **heuristic estimate** or **heuristic value** for node $\sigma$. It is supposed to estimate the distance from $\sigma$ to the nearest goal node.

**Perfect heuristic.** The *perfect (optimal) heuristic* of a search space is the heuristic $h^*$ which maps each search node $\sigma$ to the length of a shortest path from $state(\sigma)$ to any goal state.

A heuristic $h$ is called

* **safe** if $h^*(\sigma) = \infty$ for all $\sigma \in \Sigma$ with $h(\sigma) = \infty$
* **goal-aware** if $h(\sigma) = 0$ for all goal nodes $\sigma \in \Sigma$
* **admissible** if $h(\sigma) \leq h^*(\sigma)$ for all nodes $\sigma \in \Sigma$
* **consistent** if $h(\sigma) \leq h(\sigma') + 1$ for all nodes $\sigma, \sigma' \in \Sigma$ such that $\sigma'$ is a successor of $\sigma$
