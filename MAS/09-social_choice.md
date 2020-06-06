# Social Choice

Consider

* a finite set $N = \{ 1, \dots, n \}$ of at least two agents,
* a finite universe $U$ of at least two alternatives (candidates),
* each agent $i$ has preferences over the alternatives in $U$, which are represented by a transitive and complete preference relation $\succeq_i$
* the set of all preference relations over the universal set of alternatives $U$ is denoted as $\mathcal{R}(U)$,
* the set of preference profiles, associating one preference relation with each individual agent is then given by $\mathcal{R}(U)^n$.

A **social welfare function** (SWF) is a function $f: \mathcal{R}(U)^n \rightarrow \mathcal{R}(U)$.

A social welfare function $f$ is *Pareto optimal* if $a \succ_i b, \forall i \in N$ implies that $a \succ_f b$.

An SWF satisfies *independence of irrelevant alternatives* (IIA) if the social preference between any pair of alternatives only depends on the individual preferences restricted to these two alternatives.

Let $R$ and $R'$ be two preference profiles and $a$ and $b$ be two alternatives such that $R|_{\{a, b\}} = R'|_{\{a, b\}}$, i.e. the pairwise comparison between $a$ and $b$ are identicial in both profiles. Then IIA requires that $a$ and $b$ are also ranked identically in $\succ_f|_{\{a, b\}} = \ \succ'_f|_{\{a, b\}}$.

An SWF is **non-dictatorial** if there is no agent who can dictate a strict ranking no matter which preferences the other agents have. Formally, an SWF is non-dictatorial if there is no agent $i$ such that for all preference profiles $\mathcal{R}$ and alternatives $a, b, a \succ_i b$ implies that $a \succ_f b$.

**Arrow's Theorem.** There exists no SWF that simultaneously satisfies IIA, Pareto-optimality and non-dictatorship whenever $|U| \geq 3$.

A **social choice function** (SCF) is a function $f: \mathcal{R}(U)^n \times \mathcal{F}(U) \rightarrow \mathcal{F}(U)$ such that $f(R, A) \subseteq A, \forall R, A$ where $\mathcal{F}(U)$ is the set of all non-empty subsets of $U$.

Arrows theorem can be reformulated for SCFs by appropriately redefining Pareto-optimality, IIA and non-dictatorship and introducing w new property called the *weak axiom of revealed preference*.

* *Pareto optimality*: $a \notin f(R, A)$ if there exists some $b \in A$ such that $b \succ_i a, \forall i \in N$
* *Non-dictatorship*: an SCP is non-dictatorial iff there is no agent $i$ such that for all preference profiles $R$ and alternatives $a$ such that $a \succ_i b, \forall \in A \setminus \{a\}$ implies $a \in f(R, A)$
* *IIA*: an SCF satisfies IIA iff $f(R, A) = f'(R, A)$ if $R|_A = R'|_A$

An SCF $f$ satisfies **weak axiom of revelaed preference** (WARP) iff for all feasible sets $A$ and $B$ and preference profiles $R$:
$$\text{if } B \subseteq A \text{ and } f(R, A) \cap B \ne \emptyset \text{ then } f(R, A) \cap B = f(R, B).$$

WARP requires that the choice set of $B$ consists precisely of those alternatives in $B$ that are also chosen in $A$, whenever this set is non-empty.

**Arrow Theorem.** There exists no social choice function that simultaneously satisfies IIA, Pareto optimality, non-dictatorship and WAP whenever $|U| \geq 3$.

## Voting rule

A *voting rule* is a function $f: \mathcal{R}(U)^n \rightarrow \mathcal{F}(U)$.

**Positional Scoring Rules.** Assuming $m = |U|$ alternatives, we define a score vector $s = (s_1, \dots, s_m) \in \mathbb{R}^m$ such that $s_1 \geq \cdots \geq s_m$ and $s_1 > s_m$. Each time an  alternative is ranked $i$-th by some voter, it gets a particular score $s_i$.

* **Borda's rule:** $s = (m - 1, m - 2, \dots, 0)$
* **Plurality rule:** $s = (1, 0, \dots, 0)$
* **Anti-plurality rule / Approval voting:** $s = (1, 1, \dots, 1, 0)$

An alternative $a$ is a **Condorcet winner** if, when compared with every other candidate, is preffered by more voters (or is the winner in every pairwise comparison). Condorcet winner is unique but does not always exist.

*Condorcet extension:* a voting rule that selects Condorcet winner whenever it exists.

Positional scoring rules don't satisfy the Condorcet extension. Let's assume plurality rule and the following preferences

* 2: $A \succ B \succ D \succ C$
* 2: $C \succ B \succ A \succ D$
* 3: $D \succ B \succ C \succ A$  
    $B$ is the Condorcet winner, but plurality rule selects $D$.

Rules that satisfy Condorcet extensions:

* **Copelands rule:** an alternative gets a point for every pairwise majority win, and some fixed number of points between 0 and 1 (say 1/2) for every pairwise tie.
* **Maximin rule:** evaluate every alternative by its worst pairwise defeat by another alternative; the winners are those who lose by the lowest margin in their pairwise defeat.

## Other Voting Rules

**Single transferable vote (STV):** looks for the alternatives that are ranked in the first place the least often, removes them from all voters' ballots and repeat. The alternatives removed in the last round win.

**Pairwise elimination:** pair the candidates according to some ordering. The loser of the pairwise election drops out; repeat.

A resolute voting rule $f$ is **manipulable** by voter $i$ if there exists preference profiles $R$ and $R'$ such that $R_j = R'_j, \forall j \ne i$ and $f(R) \succ_i f(R')$. A voting rule is **strategyproof** if it is not manipulable.

Every non-imposing, strategyproof, resolute voting rule is dictatorial when $|U| \geq 3$.
