# Extensive-Form Games

Formal definition:

* players $\mathcal{N} = \{1, 2, \dots, n\}$
* actions $\mathcal{A}$
* choice nodes (histories) $\mathcal{H}$
* action function $\chi: \mathcal{H} \rightarrow 2^\mathcal{A}$ (which action to play)
* player function $\rho: \mathcal{H} \rightarrow \mathcal{N}$ (which player has a turn)
* terminal nodes $\mathcal{Z}$
* successor function $\varphi: \mathcal{H} \times \mathcal{A} \rightarrow \mathcal{H} \cup \mathcal{Z}$
* utility function $u = (u_1, u_2, \dots, u_n); u_i : \mathcal{Z} \rightarrow \mathbb{R}$

A pure strategy of player $i$ in an EFG is an assignment of an action for each state where player $i$ acts
$$S_i = \prod_{h \in \mathcal{H}, \rho(h) = i} \chi(h)$$

**Subgame.** Given a perfect-information extensive-form game $G$, the *subgame* of $G$ rooted at node $h$ is the restriction of $G$ to the descendants of $h$. The set of subgames of $G$ consists of all subgames of $G$ rooted at some node in $G$.

**Subgame-perfect equilibrium.** The *subgame-perfect equilibra (SPE)* of a game $G$ are all strategy profiles $s$ such that for any subgame $G'$ of $G$, the restriction of $s$ to $G'$ is a Nash equilibrium of $G'$.

Every extensive-form game with perfect information has at least one Nash equilibrium in pure strategies that is also a Subgame-perfect equilibrium.

Not every game can be represented as an EFG with perfect information.

## EFGs with Chance

Formal definition:

* players $\mathcal{N} = \{1, 2, \dots, n\} \cup \{ c \}$
* actions $\mathcal{A}$
* choice nodes (histories) $\mathcal{H}$
* action function $\chi: \mathcal{H} \rightarrow 2^\mathcal{A}$
* player function $\rho: \mathcal{H} \rightarrow \mathcal{N}$
* terminal nodes $\mathcal{Z}$
* successor function $\varphi: \mathcal{H} \times \mathcal{A} \rightarrow \mathcal{H} \cup \mathcal{Z}$
* stochastic transitions $\gamma: \Delta\{\chi(h) \ | \ h \in \mathcal{H}, \rho(h) = c \}$
* utility function $u = (u_1, u_2, \dots, u_n); u_i : \mathcal{Z} \rightarrow \mathbb{R}$

When players are not able to observe the state of the game perfectly, we talk about **imperfect information games**. The states that are not distinguishable to a player belong to a single **information set**.

Formal definition:

* $\mathcal{G} = (\mathcal{N}, \mathcal{A}, \mathcal{H}, \mathcal{Z}, \chi, \rho, \varphi, \gamma, u)$ is a perfect-information EFG.
* $\mathcal{I} = (\mathcal{I}_1, \mathcal{I}_2, \dots, \mathcal{I}_n)$ where $\mathcal{I}_i$ is a set of equivalence classes on choice nodes of a player $i$ with the property that $\rho(h) = \rho(h') = i$ and $\chi(h) = \chi(h')$, whenever $h, h' \in I$ for some information set $I \in \mathcal{I}_i$
* we can use $\chi(I)$ instead of $\chi(h)$ for some $h \in I$.

There are no guarantees that a pure NE exists in imperfect information games.

Every finite game can be represented as an EFG with imperfect information.

Mixed strategies are defined as before as a probability distribution over pure strategies.

A **behavioral strategy** $\beta_i$ of player $i$ is a product of probability distributions over actions in each information set
$$\beta_i: \prod_{I \in \mathcal{I}_i} \Delta(\chi(I))$$

To compare mixed and behavioral strategy:

* mixed strategy: flip a coin and based on the result use the selected strategy for the whole game,
* behavioral strategy: we need to flip a coin before every action.

## Perfect Recall in EFGs

Player $i$ has *perfect recall* in an imperfect-information game $G$ if for any two nodes $h, h'$ that are in the same information set for player $i$, for any path $h_0, a_0, \dots, h_n, a_n, h$ from the root of the game tree to $h$ and for any path $h_0, a'_0, \dots, h'_m, a'_m, h'$ from the root to $h'$ it must be the case that:

1. $n = m$
2. for all $0 \leq j \leq n, h_j$ and $h'_j$ are in the same equivalence class for player $i$
3. for all $0 \leq j \leq n$, if $\rho(h_j) = j$, then $a_j = a'_j$.

We say that an EFG has a *perfect recall* if all players have perfect recall. Otherwise we say that the game has an *imperfect recall*.
