# Relaxation and Domain-Independent Heuristics

**Domination.** Given two admissible heuristics $h_1, h_2$, if $h_2(\sigma) \geq h_1(\sigma), \forall \sigma \in \Sigma$, then $h_2$ *dominates* $h_1$ and is better for optimizing search.

For any admissible heuristics $h_1, \dots, h_k$,
$$h(\sigma) = \max_{i = 1}^k \{ h_i(\sigma)\}$$
is also admissible and dominates all individual $h_i$.

General procedure for obtaining a heuristic is to solve an easier version of the problem. Two common methods are

* **relaxation**: consider *less constrained* version of the problem
* **abstraction**: consider *smaller* version of the problem

## Relaxation

The **relaxation** $a^+$ of a STRIPS actions $a = (\pre(a), \add(a), \del(a))$ is the action $a^+ = (\pre(a), \add(a), \emptyset)$.

## Heuristics

### $h_\mathrm{max}$

* Action node: $cost(u) = \max\{cost(v_1), \dots, cost(v_k)\}$  
    if we have to achieve several preconditions, estimate this by the most expensive cost
* Proposition node: $cost(u) = \min\{cost(v_1), \dots, cost(v_k)\}$  
    if we have a choice how to achieve a proposition, pick the cheapest possibility

### $h_\mathrm{add}$

* Action node: $cost(u) = cost(v_1) + \cdots + cost(v_k)$  
    if we have to achieve several preconditions, estimate this by the cost of achieving each in isolation
* Proposition node: $cost(u) = \min\{cost(v_1), \dots, cost(v_k)\}$  
    if we have a choice how to achieve a proposition, pick the cheapest possibility

$h_\mathrm{add}$ is safe and goal-aware. Unlike $h_\mathrm{max}$ is very informative in many planning domains. The price for this is that it's not admissible (and hence also not consistent), so it's not suitable for optimal planning. In fact, it almost always overestimates the $h^+$ value because it does not take positive interactions into account.

### $h_\mathrm{FF}$

Annotations are boolean values, computed top-down.

A node is *marked* when its annotation is set to 1 and unmarked if it set to 0. Initially, the goal node is marked and all other nodes are unmarked.

We say that an action node is *justified* if all its true immediate predecessors are marked, and that a proposition node is *justified* if at least one of its immediate predecessors is marked.

Apply these rules until **all marked nodes are justified**:

1. Mark all immediate predecessors of a marked unjustified ACTION node.
2. Mark the immediate predecessor of marked unjustified PROP node with only one immediate predecessor.
3. Mark an immediate predecessor of a marked unjustified PROP node connected via an idle arc.
4. Mark any immediate predecessor of a marked unjustified PROP node.

The rules are given in priority order: earlier rules are preferred if applicable.

Always terminate at first layer where goal node is true.

The heuristic value is the **number of marked action nodes**.

Like $h_\mathrm{add}$ is safe and goal-aware, but neither admissible nor consistent.
Always more accurate than $h_\mathrm{add}$ with respect to $h^+$.

## Comparison

Let $s$ be a state of planning task $(P, I, O, G)$. Then

* $h_\mathrm{max}(s) \leq h^+(s) \leq h^*(s)$
* $h_\mathrm{max}(s) \leq h^+(s) \leq h_\mathrm{FF}(s) \leq h_\mathrm{add}(s)$
* $h^*$ and $h_\mathrm{FF}$ are pairwise incomparable
* $h^*$ and $h_\mathrm{add}$ are incomparable

Moreover, $h^+, h_\mathrm{max}, h_\mathrm{add}$ and $h_\mathrm{FF}$ assign $\infty$ to the same set of states.
