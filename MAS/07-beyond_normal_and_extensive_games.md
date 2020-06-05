# Beyond Normal and Extensive Games

## Repeated Game

In repeated games we assume that a normal-form game, termed the stage game, is played repeatedly. If the number of repetitions (or rounds) is finite, we talk about **finitely repeated games**. If the number of repetitions is infinite, we talk about **infinitely repeated games**.

We cannot use extensive-form games as an underlying model (backward induction). There are no leafs to assign utility values to.

Given an infinite sequence of payoffs $r_i^{(1)}, r_i^{(2)}, \dots$ for player $i$, the **average reward** of $i$ is
$$\lim_{k \rightarrow \infty} \frac{\sum_{j= 1}^k r_i^{(j)}}{k}$$

Given an infinite sequence of payoffs $r_i^{(1)}, r_i^{(2)}, \dots$ for player $i$ and a discount factor $\beta$ with $0 \leq \beta \leq 1$, the **future discounted reward** is
$$\sum_{j = 1}^\infty \beta^j r_i^{(j)}$$

A payoff profile $r = (r_1, r_2, \dots, r_n)$ is **enforceable** if $\forall i \in \mathcal{N}, r_i \geq v_i$ where $v_i$ is a minmax value for player i
$$v_i = \min_{s_{-i} \in \mathcal{S}_{-i}} \max_{s_i \in \mathcal{S}_i} u_i(s_{-i}, s_i)$$

A payoff profile $r = (r_1, r_2, \dots, r_n)$ is **feasible** if there exist rational nonnegative values $\alpha_a$ such that for all $i$ we can express $r_i$ as $\sum_{a \in \mathcal{A}} \alpha_a u_i(a)$ with $\sum_{a \in \mathcal{A}} \alpha_a = 1$.

**Folk Theorem.** Consider any $n$-player normal-form game $G$ and any payoff profile $r = (r_1, r_2, \dots, r_n)$.

1. If $r$ is the payoff profile for any Nash equilibrium $s$ of the infinitely repeated $G$ with average rewards, then for each player $i, r_i$ is enforceable.
2. If $r$ is both feasible and enforcable, then $r$ is the payoff profile for some Nash equilibrium of the infinitely repeated $G$ with average rewards.

## Stochastic Games

A *stochastic game* is a tuple $(Q, \mathcal{N}, \mathcal{A}, \mathcal{P}, \mathcal{R})$, where

* $Q$ is a finite set of games,
* $\mathcal{N}$ is a finite set of players,
* $\mathcal{A}$ is a finite set of actions, $\mathcal{A}_i$ are actions available to player $i$,
* $\mathcal{P}$ is a transition function $\mathcal{P}: Q \times \mathcal{A} \times Q \rightarrow [0, 1]$, where $\mathcal{P}(q, a, q')$ is a probability of reaching game $q'$ after a joint action $a$ is played in game $q$,
* $\mathcal{R}$ is a set of rewards functions $r_i: Q \times \mathcal{A} \rightarrow \mathbb{R}$.

Let $h_t = (q_0, a_0, q_1, a_1, \dots, q_{t1}, q_{t})$ denote a **history** of $t$ stages of a stochastic game, and let $H_t$ be the set of all possible histories of this length.

A **behavioral strategy** $s_i(h_t, a_{i_j})$ returns the probability of playing action $a_{i_j}$ for history $h_t$.

A **Markov strategy** $s_i$ is a bahevioral strategy in which $s_i(h_t, a_{i_j}) = s_i(h'_t, a_{i_j})$ if $q_t = q'_t$, where $q_t$ and $q'_t$ are the final games of $h_t$ and $h'_t$ repsectively.

A **stationary strategy** $s_i$ is a Markov strategy in which $s_i(h_{t_1}, a_{i_j}) = s_i(h_{t_2}, a_{i_j})$ if $q_t = q'_t$ where $q_t$ and $q'_t$ are final games of $h_{t_1}$ and $h_{t_2}$ respectively.

A strate profile is called a **Markov perfect equilibrium** if it consists of only Markov strategies and is a Nash equilibrium.

Every $n$-player general-sum discounted-reward stochastic game has a Markov perfect equilibrium.

Standard algorothms from Markov Decision Processes, value and strategy iteration, translates to stochastic games.
