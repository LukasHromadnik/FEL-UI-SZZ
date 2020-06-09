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

A FDR **planning task** $P$ is specified by a tuple $P = \langle \mathcal{V}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$, where

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

## Heuristics

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

### LM-Cut Heuristic

A **disjunctive operator landmark** $L \subseteq \mathcal{O}$ is a set of operators such that every plan contains at least one operator from $L$.

Let $\Pi = \langle \mathcal{F}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$ denote a STRIPS planning task, let $\Delta_1$ denote \h{max} function and let $\f{supp}{o} = \argmax_{f \in \pre(o)} \Delta_1(f)$ denote a function mapping each operator to its **supporters**.

A **justification graph** $G = (N, E)$ is a directed labeled multigraph with a set of nodes $N = \{ n_f \ | \ f \in \mathcal{F} \}$ and a set of edges $E = \{ (n_s, n_t, o) \ | \ o \in \mathcal{O}, s = \f{supp}{o}, t \in \add(o)\}$, where the triplet $(a, b, l)$ denotes an edges from $a$ to $b$ with the label $l$.

An **s-t-cut** $\mathcal{C}(G, s, t) = (N^0, N^* \cup N^b)$ is a partitioning of nodes from the justification graph $G = (N, E)$ such that $N^*$ contains all nodes from which $t$ can be reached with a zero-cost path, $N^0$ contains all nodes reachable from $s$ without passing through any node from $N^*$, and $N^b = N \setminus (N^0 \cup N^*)$.

\begin{algorithm}[!htp]
\caption{Algorithm for computing $\h{lm-cut}(s)$}
\hspace*{\algorithmicindent} \textbf{Input:} $\Pi = \langle \mathcal{F}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$, state $s$ \\
\hspace*{\algorithmicindent} \textbf{Output:} $\h{lm-cut}(s)$
\begin{algorithmic}[1]
\State $\h{lm-cut}(s) \gets 0$
\State $\Pi_1 = \langle \mathcal{F} \cup \{I, G\}, \mathcal{O}' = \mathcal{O} \cup \{o_{init}, o_{goal}\}, s'_{init} = \{I\}, s'_{goal} = \{G\}, c_1 \rangle$, where \newline
\hspace*{\algorithmicindent} $\pre(o_{init}) = \{I\}$, \newline
\hspace*{\algorithmicindent} $\add(o_{init}) = s$, \newline
\hspace*{\algorithmicindent} $\del(o_{init}) = \emptyset$, \newline
\hspace*{\algorithmicindent} $\pre(o_{goal}) = s_{goal}$, \newline
\hspace*{\algorithmicindent} $\add(o_{goal}) = \{G\}$, \newline
\hspace*{\algorithmicindent} $\del(o_{goal}) = \emptyset$, \newline
\hspace*{\algorithmicindent} $c_1(o_{init}) = 0$, \newline
\hspace*{\algorithmicindent} $c_1(o_{goal}) = 0$ and \newline
\hspace*{\algorithmicindent} $c_1(o) = c(o), \forall o \in \mathcal{O}$
\While{$\h{max}(\Pi_i, s'_{init}) \ne 0$}
    \State Construct a justification graph $G_i$ from $\Pi_i$
    \State Construct an s-t-cut $\mathcal{C}_i(G_i, n_I, n_G) = (N_i^0, N_i^* \cup N_i^b)$
    \State Create a landmark $L_i$ as a set of labels of edges that cross the cut $\mathcal{C}_i$, i.e. they lead from $N_i^0$ to $N_i^*$
    \State $m_i \gets \min_{o \in L_i} c_i(o)$
    \State $\h{lm-cut}(s) \gets \h{lm-cut}(s) + m_i$
    \State Set $\Pi_1 = \langle \mathcal{F}', \mathcal{O}', s'_{init}, s'_{goal}, c_{i + 1} \rangle$, where $c_{i + 1} = c_i(o) - m_i$ of $o \in L_i$ and $c_{i + 1}(o) = c_i(o)$ otherwise
    \State $i \gets i + 1$
\EndWhile
\end{algorithmic}
\end{algorithm}

\clearpage

### Merge and Shrink Heuristic

A **transition system** is a tuple $\mathcal{T} = \langle S, L, T, I, G \rangle$ where

* $S$ is a finite set of **states**,
* $L$ is a finite set of **labels**, each label has **cost** $c(l): L \rightarrow \mathbb{R}_0^+$,
* $T \subseteq S \times L \times S$ is a **transition relation**,
* $I \subseteq S$ is a set of initial states and
* $G \subseteq S$ is a set of goal states.

Given a FDR planning task $P = \langle \mathcal{V}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$, $\mathcal{T}(P) = \langle S, L, T, I, G \rangle$ denote a **transition system of $P$** where

* $S$ is a set of states over $\mathcal{V}$,
* $L = \mathcal{O}$,
* $T = \{(s, o, t) \ | \ \f{res}{o, s} = t \}$,
* $I = \{ s_{init} \}$ and
* $G = \{ s \ | \ s \in S, s \text{ is consistent with } s_{goal}\}$.

Let $\mathcal{T}^1 = \langle S^1, L, T^1, I^1, G^1 \rangle$ and $\mathcal{T}^2 = \langle S^2, L, T^2, I^2, G^2 \rangle$ denote two transition systems with the same set of labels and let $\alpha: S^1 \mapsto S^2$. We say that $S^2$ is an **abstraction of $S^1$** with **abstraction function $\alpha$** if it holds

* for every $s \in I^1$ that $\alpha(s) \in I^2$,
* for every $s \in G^1$ that $\alpha(s) \in G^2$ and
* for every $(s, l, t) \in T^1$ that $(\alpha(s), l, \alpha(t)) \in T^2$.

Let $P$ denote a FDR planning task, let $\mathcal{A}$ denote an abstraction of transition system $\mathcal{T}(P) = \langle S, L, T, I, G \rangle$ with the abstraction function $\alpha$. The **abstraction heuristic** induced by $\mathcal{A}$ and $\alpha$ is the function $\h{\mathcal{A}, \alpha}(s) = \h{*}(\mathcal{A}, \alpha(s)), \forall s \in S$.

Given two transition systems $\mathcal{T}^1 = \langle S^1, L, T^1, I^1, G^1 \rangle$ and $\mathcal{T}^2 = \langle S^2, L, T^2, I^2, G^2 \rangle$ with the same set of labels, the **synchronized product** $\mathcal{T}^1 \otimes \mathcal{T}^2 = \mathcal{T}$ is a transition system $\mathcal{T} = \langle S, L, T, I, G \rangle$ where

* $S = S^1 \times S^2$,
* $T = \{((s_1, s_2), l, (t_1, t_2)) \ | \ (s_1, l, t_1) \in T^1, (s_2, l, t_2) \in T^2 \}$,
* $I = I^1 \times I^2$ and
* $G = G^1 \times G^2$.

\begin{algorithm}[H]
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

### LP-Based Heuristics

Let $P = \langle \mathcal{V}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$ denote a FDR planning task. The **domain transition graph** for a variable $V \in \mathcal{V}$ is a tuple $\mathcal{A}_V = (N_V, L_V, T_V)$ where

* $N_V = \{ n_v \ | \ v \in D_V \} \cup \{ n_\bot \}$ is a set of nodes,
* $L_V = \left\{ o \ | \ o \in \mathcal{O}, v \in \vars(\pre(o)) \cup \vars(\eff(o)) \right\}$ is a set of labels and
* $T_V \subseteq N_V \times L_V \times N_V$ is a set of transitions
\begin{multline*}
T_V = \{(n_u, o, n_v) \ | \ o \in L_V, V \in \vars(\eff(o)), \pre(o)[V] = u, \eff(o)[V] = v \} \\
\cup \{(n_v, o, n_v) \ | \ o \in L_V, V \notin \vars(\eff(o)), \pre(o)[V] = v\}.
\end{multline*}

#### \h{flow}

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

#### \h{pot}

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
