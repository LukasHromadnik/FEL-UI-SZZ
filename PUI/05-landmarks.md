# Landmark Heuristics

**Landmark.** A *landmark* is a formula that must be true at some point in every plan.

Landmarks can be (partially) ordered according to the order in which they must be achieved.

**Action landmark.** An *action landmark* is an action which occurs in every valid plan.

Sound landmark orderings are guaranteed to hold – they do not prune the solution space.

* **Natural ordering:** $A \rightarrow B$, iff $A$ true some time before $B$
* **Necessary ordering:** $A \rightarrow_n B$, off $A$ always true **one step** before $B$ becomes true
* **Greedy-necessary ordering:** $A \rightarrow_{gn} B$, iff $A$ true **one step** before $B$ becomes true for the **first time**.
$$A \rightarrow_n B \quad \Rightarrow \quad A \rightarrow_{gn} B \quad \Rightarrow \quad A \rightarrow B$$

Deciding if a given fact is a landmark, it's the same as deciding if the problem without operators that achieve this fact is unsolvable.

$A$ is a landmark $\Leftrightarrow \Pi'_A$ is unsolvable where $\Pi'_A$ is $\Pi$ without operators that achieve $A$.

Find landmarks and orderings by **backchaining**

* Every goal is a landmark
* If $B$ is a landmark and all actions that achieve $B$ share $A$ as a precondition, then
    * $A$ is a landmark and
    * $A \to_n B$.

Let $P = \langle \mathcal{V}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$ denote a FDR planning task. The **domain transition graph** for a variable $V \in \mathcal{V}$ is a tuple $\mathcal{A}_V = (N_V, L_V, T_V)$ where

* $N_V = \{ n_v \ | \ v \in D_V \} \cup \{ n_\bot \}$ is a set of nodes,
* $L_V = \left\{ o \ | \ o \in \mathcal{O}, v \in \vars(\pre(o)) \cup \vars(\eff(o)) \right\}$ is a set of labels and
* $T_V \subseteq N_V \times L_V \times N_V$ is a set of transitions
\begin{multline*}
T_V = \{(n_u, o, n_v) \ | \ o \in L_V, V \in \vars(\eff(o)), \pre(o)[V] = u, \eff(o)[V] = v \} \\
\cup \{(n_v, o, n_v) \ | \ o \in L_V, V \notin \vars(\eff(o)), \pre(o)[V] = v\}.
\end{multline*}

Find landmarks through DTGs if

* $s_0(v) = d_0$,
* $v \mapsto d$ is a landmark and
* **every path** from $d_0$ to $d$ passes through $d'$,

then $v \mapsto d'$ is a landmark and $(v \mapsto d') \to (v \mapsto d)$.

## LM-Cut Heuristic

A **disjunctive operator landmark** $L \subseteq \mathcal{O}$ is a set of operators such that every plan contains at least one operator from $L$.

Let $\Pi = \langle \mathcal{F}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$ denote a STRIPS planning task, let $\Delta_1$ denote \h{max} function and let $\f{supp}{o} = \argmax_{f \in \pre(o)} \Delta_1(f)$ denote a function mapping each operator to its **supporters**.

A **justification graph** $G = (N, E)$ is a directed labeled multigraph with a set of nodes $N = \{ n_f \ | \ f \in \mathcal{F} \}$ and a set of edges $E = \{ (n_s, o, n_t) \ | \ o \in \mathcal{O}, s = \f{supp}{o}, t \in \add(o)\}$, where the triplet $(a, l, b)$ denotes an edge from $a$ to $b$ with the label $l$.

An **s-t-cut** $\mathcal{C}(G, s, t) = (N^0, N^* \cup N^b)$ is a partitioning of nodes from the justification graph $G = (N, E)$ such that $N^*$ contains all nodes from which $t$ can be reached with a zero-cost path, $N^0$ contains all nodes reachable from $s$ without passing through any node from $N^*$, and $N^b = N \setminus (N^0 \cup N^*)$.

\begin{algorithm}[h]
\caption{Algorithm for computing $\h{lm-cut}(s)$}
\hspace*{\algorithmicindent} \textbf{Input:} $\Pi = \langle \mathcal{F}, \mathcal{O}, s_{init}, s_{goal}, c \rangle$, state $s$ \\
\hspace*{\algorithmicindent} \textbf{Output:} $\h{lm-cut}(s)$
\begin{algorithmic}[1]
\State $\h{lm-cut}(s) \gets 0$
\State $\Pi_1 = \langle \mathcal{F} \cup \{I, G\}, \mathcal{O}' = \mathcal{O} \cup \{o_{init}, o_{goal}\}, s'_{init} = \{I\}, s'_{goal} = \{G\}, c_1 \rangle$, where \newline
\begin{equation*}
\begin{array}{lllll}
\pre(o_{init}) = \{I\}, & \pre(o_{goal}) = s_{goal}, & \add(o_{init}) = s, & \add(o_{goal}) = \{G\}, & \\
\del(o_{init}) = \emptyset, & \del(o_{goal}) = \emptyset, & c_1(o_{init}) = 0, & c_1(o_{goal}) = 0, & c_1(o) = c(o), \forall o \in \mathcal{O} \\
\end{array}
\end{equation*}
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
