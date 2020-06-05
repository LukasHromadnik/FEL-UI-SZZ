# Solving Extensive-Form Games

An ordered list of actions of player $i$ executed sequentially from the root of the game tree to some node $h \in \mathcal{H}$ is called a sequence $\sigma_h$. Set of all possible sequences if player $i$ is denoted $\Sigma_i$.

We need to extend the utility function to operate over sequences $g: \Sigma_1 \times \Sigma_2 \rightarrow \mathbb{R}$, where
$$g(\sigma_1, \sigma_2) = \begin{cases}
u(z) & \text{iff } $z$ \text{ corresponds to history represented by sequences } \sigma_1 \text{ and } \sigma_2 \\
0 & \text{otherwise}
\end{cases}
$$

In games with chance a combination of sequences can lead to multiple nodes / leads. So
$$g(\sigma_1, \sigma_2) = \begin{cases}
\sum_{z \in \mathcal{Z}'} \mathcal{C}(z) \cdot u(z)
& \text{iff } \mathcal{Z}' \text{ is a set of leafs that correspond to history represented} \\
& \text{by sequences } \sigma_1 \text{ and } \sigma_2, \text{ and } \mathcal{C}(z) \text{ represented the probability of leaf } z \\
& \text{being reached due to chance} \\
0
& \text{otherwise}
\end{cases}
$$

Let's assume that the opponent (player 2) will play everything and assign a probability that certain sequence $\sigma_1$ will be played.

A **realization plan** $r_i(\sigma_1)$ is a probability that sequence $\sigma_i$ will be played assuming player $-i$ plays such actions that allow actions from $\sigma_i$ to be executed.

A player selects the best action (the one that minimizes the expected utility) in each information set.
