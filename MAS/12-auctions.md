# Auctions

An **auction** is a protocol that allows agents (= bidders) to indicate their interests in one or more resources and that uses these indications of interest to determine both an **allocation of resources** and a set of **payments** by the agent.

Auctions are example of *Mechanism Design* – designing mechanisms (rules, protocols, algorithms), where rational agents participate.

## Resource Allocations

**Pareto optimality.** The chosen agreement should be such that there is no alternative agreement that would be better for some and not worse for any of the other agents.

**Utilitarianism.** If preferences are quantitative, the sum of all payoffs should be as high as possible. The collective utility function is defined as the sum of individual utilities.

**Envy-freeness.** No agent should prefer to take the bundle allocated to one of its peers rather than keeping their own.

**Egalitarianism.** The agent that is going to be worst off should be as well off as possible. The collective utility function is defined as the minimum of individual utilities.

## Simple Auction Mechanism

Single-item one-sided auctions:

* **English** – The auctioneer sets a starting price for the good and agents then have the option to announce successive bids, each of which must be higher than the previous one
* **Japanese** – The auctioneer sets a starting price for the good that is (continuously) increasing and the agents must confirm that they still want to buy the good for that price.
* **Dutch** – The auctioneer begins by announcing a high price and then successively lower the price. The auction ends when the first agent signal the auctioneer that he buys the good for the current price.
* **1st price sealed-bid** – Each agent submits to the auctioneer a secret "sealed" bid for the good that is no accessible to any of the other agents. The agent with the highest bid must purchase the good.
* **2nd price sealed-bid** – In a second-price auction the winning agent pays an amount equal to the next highest bid.

## Auctions as Games

A **Bayesian game** is a tuple $(\mathcal{N}, \mathcal{A}, \Theta, p, u)$ where

* $\mathcal{N} = \{1, \dots, n\}$ is the set of players,
* $\mathcal{A} = \mathcal{A}_1 \times \dots \times \mathcal{A}_n, \mathcal{A}_i$ is the set of actions for player $i$,
* $\Theta = \Theta_1 \times \cdots \times \Theta_n, \Theta_i$ is the type space of player $i$,
* $p: \Theta \rightarrow [0, 1]$ is a common prior over types,
* $u = u_1, \dots, u_n$ where $u_i: \Theta \rightarrow \mathbb{R}$ is the utility function of player $i$.

**Bayes-Nash equilibrium (BNE).** Rational, risk-neutral players are seeking to maximize their expected payoff, given their beliefs about the other players' types.

A sealed bid auction under independent private values (IPV) is a Bayesian game in which

* player $i$'s action corresponds to his bid $b_i$,
* player types $\Theta_i$ correspond to player's private valuations $v_i$ over the auctioned item(s),
* the payoff of a player $i$ corresponds to his valuation of the item $v_i$ minus payed bid $b_i$.

Truth-telling $(b_i = v_i)$ is a dominant strategy in a second-price sealed bid auction (assuming IPV model and risk neutral bidders).

In a first-price sealed bid auction with $n$ risk-neutral agents whose valuations $v_1, v_2, \dots, v_n$ are independently drawn from a uniform distribution on the same bounded interval of the real numberes, the unique symmetric equilibrium is given by the strategy profile
$$\left(\frac{n - 1}{b} v_1, \dots, \frac{n - 1}{n} v_n \right).$$

English and Japanese auctions have much more complicated strategy space. We can model them as an extensive-form game. Bidders are able to condition their bids on information revealed by others.

Under the IPV model, it is a dominant strategy for bidders to bid up to (and not beyond) their valuations in both Japanese and English auctions.

## Multi-Item (Combinatorial) Auctions

Auctions for bundles of goods.

Let $\mathcal{Z} = \{z_1, \dots, z_m\}$ be a set of items to be auctioned. A valuation function $v_i: 2^\mathcal{Z} \rightarrow \mathbb{R}$ indicates how much a bundle $Z \subseteq \mathcal{Z}$ is worth to the agent $i$.

Properties:

* normalization: $v(\emptyset) = 0$
* free disposal: $Z_1 \subseteq Z_2 \Rightarrow v(Z_1) \leq v(Z_2)$

Combinatorial auctions do not have to have additive valuation function:

* complementarity: $v(Z_1 \cup Z_2) > v(Z_1) + v(Z_2)$ (e.g. left and right shoe)
* substitutable items: $v(Z_1 \cup Z_2) < v(Z_1) + v(Z_2)$ (e.g. cinema tickets for the same time)

**Single-minded.** A valuation $v$ is called *single-minded* if there exists a bundle of items $Z^*$ and a value $v^* \in \mathbb{R}^+$ such that $v(Z) = v^*$ for all $Z \supseteq Z^*$ and $v(Z') = 0$ for all other $Z'$. A single-minded bid is a pair $(Z^*, v^*)$.

The allocation problem among single-minded bidders is \NP-hard. More precisely, the decision problem of whether the optimal allocation has social welfare of at least $k$ is \NP-complete.

**Demand.** For a given bidder valuation $v_i$ and given item prices $p_1, \dots, p_m$) a bundle $Z$ is called a *demand* of bidder $i$ if for every other bundle $Z' \subseteq \mathcal{Z}$ we have that
$$v_i(Z') - \sum_{j \in Z'} p_j < v_i(Z) - \sum_{j \in Z} p_j.$$

**Walrasian equilibrium.** A set of nonnegative prices $p_1^*, \dots, p_m^*$ and an allocation $S_1^*, \dots, S_n^*$ of the items is *Walrasian equilibrium* if for every player $i, S_i^*$ is a demand of bidder $i$ at prices $p_1^*, \dots, p_m^*$ and for any item $j$ that is not allocated we have $p_j = 0$.

Walrasian equilibrium does not always have to exist.
