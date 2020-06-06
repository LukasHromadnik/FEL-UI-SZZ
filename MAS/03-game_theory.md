# Introduction to Game Theory

*Game theory* is the study of strategic decision making, the study of mathematical models of conflicts and cooperation between intelligent rational decison-makers, interactive decision theory.

Given the **rule of the game**, game theory studies strategic behaviour of the agents in the form of a strategy (e.g. optimality, stability).

Given the **strategic behaviour of the agents**, *mechanism design* (reverse game theory) studies / designs the rules of games with respect to a specific outcome of the game.

**Game.** Finite, $n$-person *game* is $(\mathcal{N}, \mathcal{A}, u)$ where

* $\mathcal{N}$ is a finite set of $n$ players, indexed by $i$
* $\mathcal{A} = \mathcal{A}_1 \times \cdots \times \mathcal{A}_n$ where $\mathcal{A}_i$ is the **action set** for player $i$
    * $\mathcal{A}_i \in \mathcal{A}$ is an **action profile** and so $\mathcal{A}$ is the space of action profiles
* $u \in (u_1, \dots, u_n)$ is an **utility function** for each player, where $u_i: \mathcal{A} \rightarrow \mathbb{R}$

Writing a 2-player game as a matrix:

* row player is player 1, column player is player 2
* rows are actions $a \in \mathcal{A}_1$, columns are $a' \in \mathcal{A}_2$
* cells are outcomes, written as a tuple of utility values for each player

**Strategy $s_i$** refers to a decison (about an action choice) at each stage of the game that the agent $i$ makes and which leads to an outcome.

**Outcome** is the set of possible states resulting from agent's decision making.

**Strategy profile** refers to the set of strategies played by the agents. Set of strategy profiles: $S = S_1 \times \dots \times S_n$.

**Social welfare** (collective utility):
$$U(a) = \sum_{\forall i} u_i(a_i)$$

Cooperative agents choose such $a_i$ that maximizes $U(a)$. Self-interested agents choose such $a_i$ that maximizes $u_i(a_i)$.

## Solution concepts

### Pareto efficiency

Action (strategy) profile is **Pareto optimal** if there is no other action that at least one agent is better off and no other agent is worse off than in the given profile (one of them does better and nobody does worse).

**Dominance.** $b$ *dominates weakly* $a$ as follows:
$$a \preceq b \text{ iff } \forall i: u_i(a_i) \leq u_i(b_i)$$

**Dominant strategy** is such a strategy that is not dominated by any other strategy. **Pareto efficient strategy** is such a strategy that is not weakly dominated by any other strategy.

\input{assets/pareto-efficient.latex}

### Nash Equilibrium

Let $a_i = \langle a_1, \dots, a_{i - 1}, a_{i + 1}, \dots, a_n \rangle$, now $a = (a_{-i}, a_i)$.

**Best response.**
$$a_i^* \in BR(a_{-i}) \text{ iff } \forall a_i \in A_i, u_i(a_i^*, a_{-i}) \geq u_i(a_i, a_{-i})$$

The strategy profile $a = \langle a_1, \dots, a_n \rangle$ is in **Nash Equilibrium** iff $\forall i, a_i \in BR(a_{-i})$.

*Nash Equilibrium* is a set of strategies, one for each player, such that no player has incentive to unilaterally change his action. Players are in an equilibrium if a change in strategies by anyone of them would lead that player to earn less than if he remained with his current strategy.

**Strong Nash Equilibrium** is such an equilibrium that is stable against deviations by a cooperation.

The strategy profile $a = \langle a_1, \dots, a_n \rangle$ is in **Strict Nash Equilibrium** iff $\forall i, a_i \in BR(a_{-i})$ where $|BR(a_{-i})| = 1$.

The strategy profile is in **Weak Nash Equilibrium** iff it is not *Strict Nash Equilibrium*.

\input{assets/nash-equilibrium.latex}
