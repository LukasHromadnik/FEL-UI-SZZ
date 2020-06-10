# LP-Based Heuristics

## Cost Partitioning

* Create copies $\Pi_1, \dots, \Pi_n$ of planning task $\Pi$.
* Each has its own **operator cost function** $cost_i: A \to \mathbb{R}_0^+$ (otherwise identical to $\Pi$)
* $\forall a:$ require $cost_1(a) + \cdots + cost_n(a) \leq cost(a)$

Sum of solution costs in copies is admissible heuristic: $h_{\Pi_1}^* + \cdots h_{\Pi_n}^* \leq h_\Pi^*$

## \h{flow}

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

## \h{pot}

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
