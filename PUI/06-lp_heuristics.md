# LP-Based Heuristics

## Cost Partitioning

* Create copies $\Pi_1, \dots, \Pi_n$ of planning task $\Pi$.
* Each has its own **operator cost function** $cost_i: A \to \mathbb{R}_0^+$ (otherwise identical to $\Pi$)
* $\forall a:$ require $cost_1(a) + \cdots + cost_n(a) \leq cost(a)$

Sum of solution costs in copies is admissible heuristic: $h_{\Pi_1}^* + \cdots h_{\Pi_n}^* \leq h_\Pi^*$.

Strategies for defining cost-functions:

* uniform: $cost_i(o) = cost(o) / n$
* zero-one: full operator cost in one copy, zero in all others
* ...

To create optimal cost paritioning we can use LP:

* Use variables for cost of each operator in each task copy
* Express heuristic values with linear constraints
* Maximize sum of heuristic values subject to these constraints

### Optimal Cost Partitioning for Abstraction

\begin{equation*}
\begin{array}{rll}
\text{maximize} & \displaystyle\sum_\alpha \mathrm{GoalDist}^\alpha & \\
\text{subject to} & \displaystyle\sum_\alpha \mathrm{Cost}_o^\alpha \leq cost(o) & \forall o \in \mathcal{O} \\
& \mathrm{Cost}_o^\alpha \geq 0 & \forall o \in \mathcal{O}, \forall \alpha \text{ abstractions} \\
& \mathrm{Distance}_{s_{init}}^\alpha = 0 & \text{for the abstract initial state } s_{init} \\
& \mathrm{Distance}_{s'}^\alpha \leq \mathrm{Distance}_s^\alpha + \mathrm{Cost}_o^\alpha & \text{for all transitions } s \xrightarrow o s' \\
& \mathrm{GoalDist}^\alpha \leq \mathrm{Distance}_{s_{goal}}^\alpha & \text{for all abstract goal states } s_{goal}
\end{array}
\end{equation*}

### Optimal Cost Partitioning for Landmarks

\begin{equation*}
\begin{array}{rll}
\text{maximize} & \displaystyle\sum_L \mathrm{Cost}_L & \\
\text{subject to} & \displaystyle\sum_{L : o \in L} \mathrm{Cost}_L \leq cost(o) & \forall o
\end{array}
\end{equation*}

Optimization for every state gives best-possible cost partitioning but takes time.

## Operator Counting

Idea behind Operator counting is linear constraints whose variables denote number of occurrences of a given operator that must be satisfied by every plan that solves the task.

\begin{equation*}
\begin{array}{rll}
\text{minimize} & \displaystyle\sum_o Y_o \cdot cost(o) \\
\text{subject to} & Y_o \geq 0 & \text{and some operator-counting constraints}
\end{array}
\end{equation*}

For every plan $\pi$ there is an LP-solution where $Y_o$ is the number of occurences of $o$ in $\pi$.

Operator counting heuristics are admissible and solvable in polynomial time. Adding constraints can only make the heuristic more informed.

## State-equation Heuristic

Main idea:

* Facts can be produced (made true) or consumed (made false) by an operator
* Number oof producing and consuming operators must balance out for each fact

### \h{flow}

Let $P = \langle \mathcal{V}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$ denote a FDR planning task, $\mathcal{A}_V = (N_V, L_V, T_V)$ is a domain transition graph for each variable $V \in \mathcal{V}$ and $s$ is a state reachable from $s_{init}$. Given the following linear program with real-valued variables $x_o$ for each operator $o \in \mathcal{O}$
\begin{equation*}
\begin{array}{lll}
\text{minimize}   & \displaystyle\sum_{o \in \mathcal{O}} c(o) x_o & \\
\text{subject to} & LB_{V, v} \leq \displaystyle\sum_{(v', o, v) \in T_v} x_0 - \displaystyle\sum_{(v, o, v') \in T_v} x_o & \forall V \in \mathcal{V}, \forall v \in D_v,
\end{array}
\end{equation*}
where
$$LB_{V, v} = \begin{cases}
0 & \text{if } V \in \vars(s_{goal}) \text{ and } s_{goal}[V] = v \text{ and } s[V] = v \\
1 & \text{if } V \in \vars(s_{goal}) \text{ and } s_{goal}[V] = v \text{ and } s[V] \ne v \\
-1 & \text{if } (V \notin \vars(s_{goal}) \text{ or } s_{goal}[V] \ne v) \text{ and } s[V] = v \\
0 & \text{if } (V \notin \vars(s_{goal}) \text{ or } s_{goal}[V] \ne v) \text{ and } s[V] \ne v
\end{cases}
$$
then the value of the **flow heuristic** $\h{flow}(s)$ for the state $s$ is
$$\h{flow}(s) = \begin{cases}
\left\lceil \displaystyle\sum_{o \in \mathcal{O}} c(o) x_o \right\rceil & \text{if the solution is feasible} \\
\infty & \text{if the solution is nnot feasible}
\end{cases}$$

## Potential Heuristics

Heuristic design as an optimization problem:

* Define simple numberical state features $f_1, \dots, f_n$
* Considuer heuristics that are linear combination of features
$$h(s) = w_1 f_1(s) + \cdots + w_nf_n(s)$$
with weights (potentials) $w_i \in \mathbb{R}$
* Find potentials for which $h$ is admissible and well-informed

With potential heuristics, solving ono LP defines the entire heuristic function, not just the estimate for a single state.

**Feature.** A (state) *feature* for a planning task is a numerical function defined on the states of the task: $f: S \rightarrow \mathbb{R}$.

**Potential heuristic.** A *potential heuristic* for a set of features $\mathcal{F} = \{f_1, \dots, f_n\}$i s a heuristic function $h$ defined as a linear combination of the features
$$h(s) = w_1f_1(s) + \cdots w_nf_n(s)$$
with weights (potentials) $w_i \in \mathbb{R}$.

**Atomic feature.** Let $X = x$ be an atomic proposition of a planning task. The *atomic feature* $f_{X = x}$ is defined as:
$$f_{X = x}(s) = \begin{cases}
1 & \text{if variable } X \text{ has value } x \text{ in state } s \\
0 & \text{otherwise}
\end{cases}$$

We only consider atomic potential heuristics which are based on the set of all atomic features.

To find optimal potentials we use (again) LP.

\begin{equation*}
\begin{array}{lll}
\displaystyle\sum_{\text{goal facts } f} w_f = 0 & & \text{goal-awareness} \\
\displaystyle\sum_{f \text{ consumed by } o} w_f - \displaystyle\sum_{f \text{ produced by } o} w_f \leq cost(o) & \forall o & \text{consistency}
\end{array}
\end{equation*}

Setting heuristic to be goal-aware and consistent will create also an admissible heuristic.

### \h{pot}

Let $P = \langle \mathcal{V}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$ denote a FDR planning task and let $s$ be a state reachable from $s_{init}$. Given the following linear program with real-valued variables $P_{V, v}$ for each variable $V \in \mathcal{V}$ and each value $v \in D_V$ and real-values variables $M_V$ for each variable $V \in \mathcal{V}$
\begin{equation*}
\begin{array}{lll}
\text{maximize}   & \displaystyle\sum_{V \in \mathcal{V}} P_{V, s_{init}[V]} & \\
\text{subject to} & P_{V, v} \leq M_V & \forall V \in \mathcal{V}, \forall v \in D_V \\
                  & \displaystyle\sum_{V \in \mathcal{V}} maxpot(V, s_{goal}) \leq 0 & \\
                  & \displaystyle\sum_{V \in \vars(\eff(o))} \left(maxpot(V, \pre(o)) - P_{V, \eff(o)[V]}\right) \leq c(o) & \forall o \in \mathcal{O}
\end{array}
\end{equation*}
where
$$maxpot(V, p) = \begin{cases}
P_{V, p[V]} & \text{if } V \in \vars(p) \\
M_V & \text{otherwise}
\end{cases}
$$
then the value of the **potential heuristic** $\h{pot}(s)$ for the state $s$ is
$$\h{pot}(s) = \begin{cases}
\displaystyle\sum_{V \in \mathcal{V}} P_{V, s[V]} & \text{if the solution is feasible} \\
\infty & \text{if the solution is not feasible}
\end{cases}$$

## Conclusion

For state $s$, let $\h{maxpot}(s)$ denote the maximal heuristic value of all admissible and consistent atomic potential heuristics in $s$. Then $\h{maxpot}(s) = \h{SEQ}(s) = \h{gOCP}(s)$ where
\h{SEQ}  is a state equation heuristic a.k.a \h{flow} and \h{gOCP} is an optimal general cost partitioning of atomic projections.
