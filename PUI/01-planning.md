# Planning

State model for classical AI planning

* finite state space $S$,
* an initial state $s_0 \in S$,
* a set $S_G \subseteq S$ of goal states,
* applicable actions $A(s) \subseteq A$ for $s \in S$,
* a transition function $s' = f(a, s)$ for $a \in A(s)$,
* a cost function $c: A^* \rightarrow [0, \infty)$.

A **solution** is a sequence of applicable actions that maps $s_0$ into $S_G$. An **optimal solution** minimizes $c$.

**Transition system.** A *transition system* is $(S, I, \{a_1, \dots, a_n\}, G)$ where

* $S$ is a finite set of **states** (the state space),
* $I \subseteq S$ is a finite set of **initial states**,
* every **action** $a_i \subseteq S \times S$ is a binary relation on $S$,
* $G \subseteq S$ is a finite set of **goal states**.

**Applicable action.** An action $a$ is *applicable* in a state $s$ if exists $sas'$ for at least one state $s'$.

A transition system is **deterministic** if there is only **one initial state** and all actions are deterministic. Hence all future states of the world are completely predictable.

**Deterministic transition system.** A *deterministic transition system* is $(S, I, O, G)$ where

* $S$ is a finite set of states,
* $I \in S$ is an initial state,
* actions $a \in O$ (with $a \subseteq S \times S$) are partial functions,
* $G \subseteq S$ is a finite set of goal states.

Given a state $s$ and an action $a$ so that $a$ is applicable in $s$, the **successor state** of $s$ with respect to $a$ is $s'$ such that $sas'$ denoted by $s' = app_a(s)$.

**Plan.** A *plan* for $(S, I, A, G)$ is a sequence $\pi = a_1, \dots, a_n$ of action instance such that $a_1, \dots, a_n \in A$ and $s_0, \dots, s_n$ is a sequence of states (the **execution** of $\pi$) so that

1. $s_0 = I$,
2. $s_i = app_{a_i}(s_{i - 1}), \forall i \in \{1, \dots, n\}$ and
3. $s_n \in G$.

This can be equivalently expressed as $app_{a_n}\left( app_{a_{n - 1}} \left( \cdots app_{a_1}(I) \cdots \right) \right) \in G$.

**Deterministic planning task.** A *deterministic planning task* is a 4-tuple $\Pi = (V, I, A, G)$ where

* $V$ is a finite set of state variables,
* $I$ is an initial state over $V$,
* $A$ is a finite set of actions over $V$ and
* $G$ is a constraint over $V$ describing the goal states.

From every deterministic planning task $\Pi = (V, I, A, G)$ we can produce a corresponding transition system $\mathcal{T}(\Pi) = (S, I, A', G')$

1. $S$ is the set of all valuations of $V$,
2. $A' = \{ R(a) \ | \ a \in A \}$ where $R(a) = \{(s, s') \in S \times S \ | \ s' = app_a(s) \}$ and
3. $G' = \{ s \in S \ | \ s \vDash G \}$.

**SAS.** A problem in *SAS* is a tuple $(V, A, I, G)$ where

* $V$ is a finite set of state variables with finite domains $dom(v_i)$,
* $I$ is an  initial state over $V$,
* $G$ is a partial assignment to $V$,
* $A$ is a finite set of actions $a$ specified via $\mathrm{pre}(a)$ and $\mathrm{eff}(a)$ both being partial assignments to $V$.

An action $a$ is applicable in a state $s \in dom(V)$ iff $s[v] = \mathrm{pre}(a)[v]$ whenever $\mathrm{pre}(a)[v]$ is specified.

Applying an applicable action $a$ changes the value of each variable $v$ to $\mathrm{eff}(a)[v]$ if $\mathrm{eff}(a)[v]$ is specified.

**STRIPS.** A problem in *STRIPS* is a tuple $(P, A, I, G)$ where

* $P$ stands for a finite set of atoms (boolean vars),
* $I \subseteq P$ stands for initial situation,
* $G \subseteq P$ stands for goal situation,
* $A$ is a finite set of actions $a$ specified via $\pre(a), \add(a)$ and $\del(a)$, all subsets of $P$.

States are collections of atoms. An action $a$ is applicable in a state $s$ iff $\pre(a) \subseteq s$. Applying an applicable action $a$ at $s$ results in $s' = \left(s \setminus \del(a)\right) \cup \add(a)$.

## Heuristic search

**Heuristic.** Let $\Sigma$ be the set of nodes of a given search space. A *heuristic function* is a function $h: \Sigma \rightarrow \mathbb{N}_0 \cup \{ \infty \}$.

The value of $h(\sigma)$ is called the **heuristic estimate** or **heuristic value** for node $\sigma$. It is supposed to estimate the distance from $\sigma$ to the nearest goal node.

**Perfect heuristic.** The *perfect (optimal) heuristic* of a search space is the heuristic $h^*$ which maps each search node $\sigma$ to the length of a shortest path from $state(\sigma)$ to any goal state.

A heuristic $h$ is called

* **safe** if $h^*(\sigma) = \infty$ for all $\sigma \in \Sigma$ with $h(\sigma) = \infty$
* **goal-aware** if $h(\sigma) = 0$ for all goal nodes $\sigma \in \Sigma$
* **admissible** if $h(\sigma) \leq h^*(\sigma)$ for all nodes $\sigma \in \Sigma$
* **consistent** if $h(\sigma) \leq h(\sigma') + 1$ for all nodes $\sigma, \sigma' \in \Sigma$ such that $\sigma'$ is a successor of $\sigma$
