# Concept Learning

In *concept learning*, the agent tries to guess the environment state $s_k \in S$ at each $k$ from the observation $o_k \in O$ and it's immediately (at $k + 1$) rewarded for a correct guess.

The agent learns a representation of a *concept*, which is the set of all observations in $O$ for which the correct answer is yes.

At time $k$

* states are distributed by $\pc[P_s]{s_{k + 1}}{s_k, a_k}$,
* observations are distributed by $\pc[P_o]{o_k}{s_k}$,
* rewards are distributed by $\pc[P_r]{r_k}{s_k}$, alternatively $\pc[P_r]{r_{k + 1}}{s_k, a_k}$.

**Concept.** We assume $S = \{0, 1\}$ and some function $c: O \to S$ that is unknown to the agent. We call a *concept* on $O$
$$C = \{ o \in O; c(o) = 1 \}.$$
The agent's goal is to learn the concept so that it can make correct predictions of states.

**Reward.** The *reward* is dependent on the previous state and the action
$$r_{k + 1} = r(s_k, a_k) = \begin{cases}
0 & \text{if } s_k = a_k \\
-1 & \text{otherwise}
\end{cases}
$$

**Hypotheses.** A *hypotesis* $h$ is any finite description, from which $\pi$ can derive a $0/1$ decision for an observation.

**Hypothesized concept.**
$$C(h) = \{ o \in O; \pi(h, o) = 1 \}$$

A good concept-learning agent will find a $h$ such that $C = C(h)$, which means the same as $c(o) = \pi(h, o), \forall o \in O$.

## Generalizing Agent

Assume $O = \{0, 1\}^n$ and let $h_k$ be **conjunctions** using $n$ propositional variables. Then try this

* start with the conjunction of **all literals**, i.e. include both $p$ and $\neg p$ for each variable $p$,
* on each error, remove from the conjuction exactly all literals inconsistent with the previous observation, i.e. literals logically false in it.

If $h_k$ misclassifies a negative example, then $o_k$ is consistent with the example, therefore $h_k$ cannot remove any literals that are logically false, because there aren't any.

### Mistake bound

The initial hypothesis $h_1$ has $2n$ literals, **no more than $2n$ mistakes** are made before $h_k = h^*$.

So the cumulative reward for an arbitrary horizon $m \in \mathbb{N}$ is
$$\sum_{k = 1}^m r_k \geq -2n$$

## Mistake-Bound Learning Model

Let $\mathcal{H}$ be a **hypothesis class**, i.e. any set of hypothesis. $\mathcal{H}$ induces the **concept class** $\mathcal{C}(\mathcal{H}) = \{ C(h) \ | \ h \in \mathcal{H} \}$, where $C(h) = \{ o \in O, \pi(h, o) = 1 \}$. Let $n$ be the size (complexity) of observations (usually their arity).

Agent **learns class $\mathcal{H}$ on-line** (in the mistake-bound model) if with any target concept $C \in \mathcal{C}(\mathcal{H})$ it will make no more than a polynomial (in the size $n$) number of mistakes. Furthermore, it learns $\mathcal{H}$ **efficiently** if it spends at most polynomial time between each percept and the next action. $\mathcal{H}$ is **(efficiently) learnable on-line** if there is an agent that learns it (efficiently) on-line.

The definition only assumes $C \in \mathcal{C}(\mathcal{H})$ but makes no assumption about the sequence of states $s_k$ from which observations are sampled with $\pc[P_O]{o_k}{s_k}$. The mistake bound must hold for any such sequence.

## Generality Relation

We call concept $C$ **more general** than concept $C'$ if $C \supseteq C'$. A hypothesis $h$ is **more general** than hypothesis $h'$ if
$$C(h) \supseteq C(h')$$
When $h \subseteq h'$ for conjuctions $h, h'$, we say that $h$ **subsumes** $h'$.

## Least Upper Bound

In a subsumption lattice induces by relation $\preceq$, every two elements $a, b$ have exactly one **least upper bound** $c = \f{lup}{a, b}$ such that

* $c \preceq a$ and $c \preceq b$,
* there is no "lesser bound" $d$, i.e. no $d$ such that $c \preceq d, d \npreceq c, d \preceq a, d \preceq b$.

Properties of $\mathrm{lup}$:

* $\f{lup}{a, b} = a$ if $a \preceq b$
* $\f{lup}{a, b} = \f{lup}{b, a}$ (commutativity)
* $\f{lup}{a, \f{lup}{b, c}} = \f{lup}{\f{lup}{a, b}, c}$ (associativity)

## Least General Generalization

When the lattice members are conjuctions or disjunctions of literals, we call the $\mathrm{lup}$ the *least general generalization* denoted $\mathrm{lgg}$ and clearly
$$\f{lgg}{a, b} = a \cap b.$$
Due to commutativity and associativity of any $\mathrm{lup}, \mathrm{lgg}$ is defined uniquely for any finite set $\mathcal{H}$ of lattice elements
$$\f{lgg}{\mathcal{H}} = \f{lgg}{h1, \f{lgg}{h_2, \f{lgg}{h_2, \dots}}\dots} = \bigcap_{h \in \mathcal{H}} h$$

## Generalizing Agent: Design

When $h_k$ makes a mistake, $h_{k + 1}$ should exclude all literals of $h_k$ inconsistent with $o_k$. This is done at time $k + 1$ so the agent needs to remember $o_k$ as a part of its state. So we will maintain the state in the form of a tuple
$$t_k = \langle h_k, o_k \rangle.$$
The hypothesis will then be updated by
$$h_{k + 1} = \begin{cases}
h_k & \text{if } r_{k + 1} = 0 \\
\f{lgg}{h_k, \bar{o}_k} & \text{otherwise}
\end{cases}$$
where $\bar{o}$ denotes a conjunction representing observation $o$
$$\bar{o} = \bigwedge_{o^i = 1} p_i \bigwedge_{o^j = 0} \neg p_j$$

Since negative examples are irrelevant, assume that all of $o_1, \dots, o_m$ are positive. Since $h_1$ contains all literals, we have $\bar{o}_1 \subseteq h_1$ and thus
\begin{align*}
h_2 &= \f{lgg}{h_1, \bar{o}_1} = \bar{o}_1 \\
h_3 &= \f{lgg}{h_2, \bar{o}_2} = \f{lgg}{\f{lgg}{h_1, \bar{o}_1}, \bar{o}_2} = \f{lgg}{\bar{o}_2, \bar{o}_1}
\end{align*}
So the agent's output can be written as
$$h_m = \f{lgg}{\bar{o}_{m - 1}, \f{lgg}{\bar{o}_{m - 2}, \dots \f{lgg}{\bar{o}_2, \bar{o}_1} \dots}} = \f{lgg}{\{\bar{o}_1, \dots, \bar{o}_m\}}$$

## Generalizing Agent for Disjunctions

Try the inverse strategy: ignore positive examples and take the $\mathrm{lgg}$ of the negative examples. Assume this time that $o_1, \dots, o_m$ are all negative.

Say $h'_m = \f{lgg}{\{\bar{o}_1, \dots, \bar{o}_m\}}$ covers no positives. Then clearly $\neg h'_m$ covers no negatives and all positives just like $h_m$.

But $h_m$ and $\neg h'_m$ are not the same. $h_m$ is a conjunction while $\neg h'_m$ is the negation of a conjunction, i.e. a **disjunction**. So this inverse approach is suitable when the target concept can be expressed through a disjunction.

## Generalizing Agent for s-CNF, s-DNF

An s-CNF is a conjunction of s-clauses, which is a disjuction of at most $s \in \mathbb{N}$ literals. s-CNF's can be learned using the generalization strategy. Given $n$ propositional variables

* set $h_1$ to the conjunction of **all** s-clauses on these variables,
* for each positive example, remove from $h_k$ all clauses false for the example.

The number of mistakes will not be greater than the number of all s-clauses on $n$ variables. This number is $\mathcal{O}[\binom{2n}{s}] = \mathcal{O}(n^s)$, i.e. polynomial. Therefore s-CNF's are **efficiently learnable online$$.

## Separating Agent

Besides generalization, another prominent learning technique is to **separate** $C$ from its complement with a hyperplane in $O$. We continue with $O = \{0, 1\}^n$. Agent's hypothesis is a tuple of integers ("weights"), i.e.
$$h_k = \langle h_k^1, h_k^2, \dots, h_k^n \rangle$$

and $h_1 = \langle 1, 1, \dots, 1 \rangle$. Decisions are
$$a_k = \pi(h_k, o_k) = \begin{cases}
1 & \text{if } h_k \cdot o_k > \frac{n}{2} \text{ (dot product)} \\
0 & \text{otherwise}
\end{cases}
$$

The agent has a simple learning rule

* on a false negative $o_k$, double weights $h^i$ for all $i, o_k^i = 1$,
* on a false positive, nullify weights of these features.

Formally
$$h_{k + 1} = \begin{cases}
h_k & \text{if } r_{k + 1} = 0 \text{ (keep $h_k$ if it did not make a mistake)} \\
\f{update}{2, h_k, o_k} & \text{if } r_{k + 1} = -1 \wedge h_k \cdot o_k \leq \frac{n}{2} \\
\f{update}{0, h_k, o_k} & \text{if } r_{k + 1} = -1 \wedge h_k \cdot o_k > \frac{n}{2}
\end{cases}
$$
where $\f{update}{\alpha, h_k, o_k}$ mutliplies all features with value 1 by $\alpha$, i.e.
$$h_{k + 1}^i = \begin{cases}
\alpha \cdot h_k^i & \text{if } o_k^i = 1 \\
h_k^i & \text{otherwise}
\end{cases}
$$

The separating agent learns efficiently any class $\mathcal{H}$  of linearly separable hypotheses.

The agent makes at most $2 + 2s \log n$ mistakes. For sufficiently small $s$,  this is better than generalizing agent which has a mistake bound in linear $n$.

## General Learning Agent

It keeps a set $\mathcal{H}_k$ of hypotheses, rather than a single one starting with $\mathcal{H}_1 = \mathcal{H}$.

At each $k$, the agent picks an arbitrary $h \in \mathcal{H}_k$ and makes a decision by it. If it maks an error, it deletes $h$ from $\mathcal{H}_k$.

If $C \in \mathcal{C}( \mathcal{H})$, then this agent makes at most $|\mathcal{H}| - 1$ mistakes (if all hypotheses made a mistake, the last one must be the target).

The agent learns online (not necessarily efficiently) any $\mathcal{H}$ such that $|\mathcal{H}| \leq poly(n)$.

It cannot learnn online unconstrained conjunctions or disjunctions.

## Version Space

The *version space* agent is similar to the general agent but decides by a majority vote among all hypotheses in $\mathcal{H}_k$ and deletes from $\mathcal{H}_j$ **all** hypotheses inconsistent with the last observation.

If a mistake is made, at least half of the hypootheses in $\mathcal{H}_k$ are deleted. In the worst case, the last remaining hypothesis is correct.

So the agent makes at most $\log |\mathcal{H}|$ mistakes, i.e. the cumulative reward is
$$\sum_{k = 1}^m r_k \geq -\log |\mathcal{H}|$$
for any horizon $m \in \mathbb{N}$.

Version space is **not efficient** even for super-poly $\mathcal{H}$. Needs to verify each $h \in \mathcal{H}$ in the update step.

If $|\mathcal{H}|$ is at most exponential then $\log |\mathcal{H}|$ is polynomial and VS agent learns $\mathcal{H}$ online. This includes s-clause CNF's and s-term DNF's.

## VC Dimension

Concept class $\mathcal{C}$ **shatters** $O' \subseteq O$ if any subset of $O'$ coincides with $C \cap O'$ where $C \in \mathcal{C}$. A hypothesis class $\mathcal{H}$ shatters $O'$ if $\mathcal{C}(\mathcal{H})$ shatters $O'$.

So $O'$ is shattered by $\mathcal{C}$, resp. $\mathcal{H}$, if its elements can be classified in all $2^{O'}$ possible ways by concepts from $\mathcal{C}$, resp. hypotheses from $\mathcal{H}$.

**VC-dimension.** The *VC-dimension* of $\mathcal{C}$ (on $O$) denoted $\f{VC}{\mathcal{C}}$ is the cardinality of the largest subset of $O$ shattered by $\mathcal{C}$. The VC-dimensioon of hypothesis class $\mathcal{H}$ is defined as $\f{VC}{\mathcal{C}(\mathcal{H})}$, also denoted $\f{VC}{\mathcal{H}}$.

### Lower Bounds on Mistake Bounds

A mistake bound with no special assumptions cannot be lower than $|O|$ as each $o \in O$ may have an arbitrary class.

A mistake bound assuming only $C \in \mathcal{C} \subset 2^O$ for the target concept $\mathcal{C}$ cannot be smaller than $\f{VC}{\mathcal{C}}$ as there is a set $\{o_1, o_2, \dots, o_\f{VC}{\mathcal{C}}\} \subseteq O$ shattered by $\mathcal{C}$.

As a corollary the agent using hypothesis class $\mathcal{H}$ cannot be guaranteed to make fewer than $\f{VC}{\mathcal{H}}$ mistakes.
