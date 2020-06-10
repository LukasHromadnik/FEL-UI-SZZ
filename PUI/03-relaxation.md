# Relaxation and Domain-Independent Heuristics

**Domination.** Given two admissible heuristics $h_1, h_2$, if $h_2(\sigma) \geq h_1(\sigma), \forall \sigma \in \Sigma$, then $h_2$ *dominates* $h_1$ and is better for optimizing search.

For any admissible heuristics $h_1, \dots, h_k$,
$$h(\sigma) = \max_{i = 1}^k \{ h_i(\sigma)\}$$
is also admissible and dominates all individual $h_i$.

General procedure for obtaining a heuristic is to solve an easier version of the problem. Two common methods are

* **relaxation**: consider *less constrained* version of the problem
* **abstraction**: consider *smaller* version of the problem

## Heuristics

### \h{max}

Let $\Pi = \langle \mathcal{F}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$ denote a STRIPS planning task. The heuristic function $\h{max}(s)$ gives an estimation of the  distance from $s$ to a node that satisfies the goal $s_{goal}$ as $\h{max} = \max_{f \in s_{goal}} \Delta_1(s, f)$ where
$$\Delta_1(s, f) = \begin{cases}
0 & \text{if } f \in s \\
\infty &  \text{if } \forall o \in \mathcal{O}: f \notin \add(o) \\
\min\{c(o) + \Delta_1(s, o) \ | \ o \in \mathcal{O}, f \in \add(o) \} & \text{otherwise}
\end{cases}
$$
and
$$\Delta_1(s, o) = \max_{f \in \pre(o)} \Delta_1(s, f), \quad \forall o \in \mathcal{O}.$$

### \h{add}

Given a STRIPS planning task $\Pi = \langle \mathcal{F}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$ and let $\Pi^+ = \langle \mathcal{F}, \mathcal{O}^+, s_{init}, s_{goal}, c \rangle$ denote a **relaxed** STRIPS planning task, where $\mathcal{O}^+ = \{ o_i^+ = \langle \pre(o_i), \add(o_i), \emptyset \rangle \ | \ o_i \in \mathcal{O} \}$.

Let $\Pi = \langle \mathcal{F}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$ denote a STRIPS planning task. The heuristic function $\h{add}(s)$ gives an estimate of the distance from $s$ to a node that satisfies the goal $s_{goal}$ as $\h{add}(s) = \sum_{f \in s_{goal}} \Delta_0(s, f)$ where
$$
\Delta_0(s, f) = \begin{cases}
0 & \text{if } f \in s \\
\infty & \text{if } \forall o \in \mathcal{O}: f \notin \add(o) \\
\min\{c(o) + \Delta_0(s, o) \ | \ o \in \mathcal{O}, f \in \add(o)\} & \text{otherwise}
\end{cases}
$$
and
$$\Delta_0(s, o) = \sum_{f \in \pre(o)} \Delta_0(s, f), \quad \forall o \in \mathcal{O}.$$

\h{add} is safe and goal-aware. Unlike \h{max} is very informative in many planning domains. The price for this is that it's not admissible (and hence also not consistent), so it's not suitable for optimal planning. In fact, it almost always overestimates the $\h{+}$ value because it does not take positive interactions into account.

### \h{FF}

Annotations are boolean values, computed top-down.

A node is *marked* when its annotation is set to 1 and unmarked if it set to 0. Initially, the goal node is marked and all other nodes are unmarked.

We say that an action node is *justified* if all its true immediate predecessors are marked, and that a proposition node is *justified* if at least one of its immediate predecessors is marked.

Apply these rules until **all marked nodes are justified**:

1. Mark all immediate predecessors of a marked unjustified ACTION node.
2. Mark the immediate predecessor of marked unjustified PROP node with only one immediate predecessor.
3. Mark an immediate predecessor of a marked unjustified PROP node connected via an idle arc.
4. Mark any immediate predecessor of a marked unjustified PROP node.

The rules are given in priority order: earlier rules are preferred if applicable.

Always terminate at the first layer where goal node is true.

The heuristic value is the **number of marked action nodes**.

Like \h{add} is safe and goal-aware, but neither admissible nor consistent.
Always more accurate than \h{add} with respect to \h{+}.

## Comparison

Let $s$ be a state of planning task. Then

* $\h{max}(s) \leq \h{+}(s) \leq \h{*}(s)$
* $\h{max}(s) \leq \h{+}(s) \leq \h{FF}(s) \leq \h{add}(s)$
* $\h{*}$ and $\h{FF}$ are pairwise incomparable
* $\h{*}$ and \h{add} are incomparable

Moreover, $\h{+}, \h{max}, \h{add}$ and $\h{FF}$ assign $\infty$ to the same set of states.
