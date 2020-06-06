# Solving Normal-Form Games


**Mixed Strategies.** Let $\mathcal{G} = (\mathcal{N}, \mathcal{A}, u)$ be a normal-form game, then the set of *mixed strategies* $\mathcal{S}_i$ for player $i$ is the set of all probability distributions over $\mathcal{A}_i, \mathcal{S}_i = \Delta(\mathcal{A}_i)$.

We use $\mathcal{S}_{-i}$ to denote strategies of all other players except player $i$.

We extend the utility function to correspond to the **expected utility**:
$$u_i(s) = \sum_{a \in \mathcal{A}} u_i(a) \prod_{j \in \mathcal{N}} s_j(a_j)$$

**Strong Dominance.** Let $\mathcal{G} = (\mathcal{N}, \mathcal{A}, u)$ be a normal-form game. We say that $s_i$ *strongly  dominates* $s'_i$ if $\forall s_{-i} \in \mathcal{S}_{-i}, u_i(s_i, s_{-i}) > u_i(s'_i, s_{-i})$.

**Weak Dominance.** Let $\mathcal{G} = (\mathcal{N}, \mathcal{A}, u)$ be a normal-form game. We say that $s_i$ *weakly dominates* $s'_i$ if $\forall s_{-i} \in \mathcal{S}_{-i}, u_i(s_i, s_{-i}) \geq u_i(s'_i, s_{-i})$ and $\exists s_{-i} \in \mathcal{S}_{-i}$ such that $u_i(s_i, s_{-i}) > u_i(s'_i, s_{-i})$.

**Very Weak Dominance.** Let $\mathcal{G} = (\mathcal{N}, \mathcal{A}, u)$ be a normal-form game. We say that $s_i$ *very weakly dominates* $s'_i$ if $\forall s_{-i} \in \mathcal{S}_{-i}, u_i(s_i, s_{-i}) \geq u_i(s'_i, s_{-i})$.

**Best response.** Let $\mathcal{G} = (\mathcal{N}, \mathcal{A}, u)$ be a normal-form game and let $BR_i(s_{-i}) \subseteq \mathcal{S}_i$ such that $s_i^* \in BR_i(s_{-i})$ iff $\forall s_i \in \mathcal{S}_i, u_i(s_i^*, s_{-i}) \geq u_i(s_i, s_{-i})$.

**Nash Equilibrium.** Let $\mathcal{G} = (\mathcal{N}, \mathcal{A}, u)$ be a normal-form game. Strategy profile $s = \langle s_1, \dots, s_n \rangle$ is a *Nash equilibirum* iff $\forall i \in \mathcal{N}, s_i \in BR_i(s_{-i})$.

**Theorem.** Every game with a finite number of players and action profiles has at least one Nash equilibrium in mixed strategies.

**Support.** The *support* of a mixed strategy $s_i$ for a player $i$ is the set of pure strategies $\{a_i \ | \ s_i (a_i) > 0 \}$.

**Corollary.** Let $s \in \mathcal{S}$ be a Nash equilibrium and $a_i, a'_i \in \mathcal{A}_i$ are actions from the support of $s_i$. Now, $u_i(a_i, s_{-i}) = u_i(a'_i, s_{-i})$.

Playing a Nash strategy when there are multiple Nash equilibria does not give any guarantees for the expected payoff.

**Maxmin.** The *maxmin* strategy for player $i$ is $\argmax_{s_i} \min_{s_{-i}} u_i(s_i, s_{-i})$ and the *maxmin value* for player $i$ is $\max_{s_i} \min_{s_{-i}} u_i(s_i, s_{-i})$.

**Minmax, two-player.** In a two-player game, the *minmax* strategy for player $i$ against player $-i$ is $\argmin_{s_i} \max_{s_{-i}} u_{-i}(s_i, s_{-i})$ and the *minmax value* for player $-i$ is $\min_{s_i} \max_{s_{-i}} u_{-i}(s_i, s_{-i})$.

Maxmin strategires are conservative strategies against a worst-case opponent. Minmax strategies represent punishment strategies for player $-i$.

**Minimax Theorem.** In any finite, two-player zero-sum game, in any Nash equilibirum each player receives a payoff that is equal to both his maxmin value and his minmax value.

As a consequence we can safely play Nash strategies in zero-sum games and all Nash equilibria have the same payoff.

**Regret.** A player $i$'s *regret* for playing an action $a_i$ if other agents adopt action profile $a_{-i}$.

**MaxRegret.** A player $i$'s *maximum regret* for playing an action $a_i$.

**MinimaxRegret.** *Minimax regret* actions for player $i$ are defined as
$$\argmin_{a_i \in \mathcal{A}_i} \underbrace{\max_{a_{-i} \in \mathcal{A}_{-i}} \underbrace{\left( \left[\max_{a'_i \in \mathcal{A}_i} u_i(a'_i, a_{-i}) \right] - u_i(a_i, a_{-i}) \right)}_\text{Regret}}_\text{MaxRegret}$$

Consider the following game:

\begin{table}[!ht]
\centering
\begin{tabular}{c|c|c|}
    \multicolumn{1}{c}{} & \multicolumn{1}{c}{$L$} & \multicolumn{1}{c}{$R$} \\ \hhline{~|-|-|}
    $U$ & (2, 1) & (0, 0) \\ \hhline{~|-|-|}
    $D$ & (0, 0) & (1, 2) \\ \hhline{~|-|-|}
\end{tabular}
\end{table}

Wouldn't it be better to coordinate 50:50 between outcomes $(U, L)$ and $(D, R)$? We can use a *correlation device* – a coin, a streetlight, commonly observed signal – and use this signal to avoid unwanted outcomes.

**Correlated Equilibirum.** Let $\mathcal{G} = (\mathcal{N}, \mathcal{A}, u)$ be a normal-form game and let $\sigma$ be a probability distribution over joint pure strategy profiles $\sigma \in \Delta(\mathcal{A})$. We say that $\sigma$ is a *correlated equilibrium* if for every player $i$ and every action $a'_i \in \mathcal{A}_i$ it holds
$$\sum_{a \in \mathcal{A}} \sigma(a) u_i(a_i, a_{-i}) \geq  \sum_{a \in \mathcal{A}} \sigma(a) u_i(a'_i, a_{-i})$$

As a corollary, for every Nash equilibrium there exists a corresponding Correlated Equilibrium.

**Stackelberg equilibrium** is a strategy profile that satisfies the conditions:

* *the leader* – publicly commits to a strategy,
* *the follower(s)* – play a Nash equilibrium with respect to the commitment of the leader,

and maximizes the expected utility value of the leader:
$$ \argmax_{s \in \mathcal{S}, \forall i \in \mathcal{N} \setminus \{1\}, s_i \in BR_i(s_{-i})} u_1(s)$$
