# Landmark Heuristics

**FDR planning tasks.** An *Finite Domain Representation (FDR) planning task* is a tuple $\Pi = (V, A, I, G)$

* $V$ is a finite set of state variables with finite domains $dom(v_i)$,
* initial state $I$ is a complete assignment to $V$,
* goal $G$ is a partial assignment to $V$,
* $A$ is a finite set of actions $a$ specified via $\pre(a)$ and $\eff(a)$, both being partial assignments to $V$.

In cost-sensitive planning each action $a$ is also associated with a cost $C(a)$.

**Landmark.** A *landmark* is a formula that must be true at some point in every plan.

Landmarks can be (partially) ordered according to the order in which they must be achieved.

**Action landmark.** An *action landmark* is an action whcih occurs in every valid plan.

Sound landmark orderings are guaranteed to hold – they do not prune the solution space.

* **Natural ordering:** $A \rightarrow B$, iff $A$ true some time before $B$
* **Necessary ordering:** $A \rightarrow_n B$, off $A$ always true **one step** before $B$ becomes true
* **Greedy-necessary ordering:** $A \rightarrow_{gn} B$, iff $A$ true **one step** before $B$ becomes true for the **first time**.
$$A \rightarrow_n B \quad \Rightarrow \quad A \rightarrow_{gn} B \quad \Rightarrow \quad A \rightarrow B$$

$A$ is a landmark $\Leftrightarrow \Pi'_A$ is unsolvable where $\Pi'_A$ is $\Pi$ without operators that achieve $A$.

Find landmarks and orderings by **backchaining**

* Every goal is a landmark
* If $B$ is a landmark and all actionos that achieve $B$ share $A$ as a precondition, then
    * $A$ is a landmark and
    * $A \to_n B$.

**Domain transition graph.** The *domain transition graph* of $v \in V$ ($\mathrm{DTG}_v$) represents how the value of $v$ can change.

Given an FDR task $(V, A, s_0, G)$ $\mathrm{DTG}_v$ is a directed graph with nodes $\mathcal{D}_v$ that has arc $(d, d')$ iff

* $d \ne d'$ and
* exists action with $w \mapsto d'$ as an effect, and either
    * $v \mapsto d$ is a precondition, or
    * no precondition on $v$.

Find landmarks through DTGs if

* $s_0(v) = d_0$,
* $v \mapsto d$ is a landamrk and
* **every path** from $d_0$ to $d$ passes through $d'$,

then $v \mapsto d'$ is a landmark and $(v \mapsto d') \to (v \mapsto d)$.
