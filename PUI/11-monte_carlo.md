# Monte Carlo

**Monte Carlo Simulation.** A technique that can be used to solve a mathemtical or statistical problem using repeated smapling to determine the properties of some phenomenon (or behavioe).

**Monte Carlo Planning.** Compute a good policy for an MDP by interacting with an MDP simulator.

## Using Monte Carlo Methods

We have $k \geq 2$ stochastic actions (arms $a_i$), each parameterized with an unknown probability distribution $v_i$ and a stored expectation $\mu_i$. If executed (pulled) the reward is random from $v_i$.

Our objective is to get the maximal reward after $N$ pulls and to minimize **regret** for pulling the wrong arm(s).

Arm is selected accoring to UCB 1, where the selecting arm $a_i$ maximizes formula
$$u_i + c \cdot \sqrt{\frac{\ln n}{n_i}}$$
and update $\mu_i$ where

* $n$ times the state is visited,
* $n_i$ times the actions is visited and
* $\mu_i$ is the average reward from the previous plays.

**Exploration factor $c$** ensures to evaluate actions that are evaluated rarely.

### UCT (Upper Confidence Trees)

We have to repeat $X$ times the following algorithm of UCB-1 to get correct sampling

1. Selection
2. Expansion
3. Simulation
4. Backpropagation

### PROST

Basic UCT doesn't work very well in practice

* huge branching factor
* long (infinite) horizon
* very difficult to find the correct plan by random rollouts

In PROST we can limit the search depth to $L$ instead of solving to full depth. Also we can heuristically identify unnecessary actions that do not yield any positive reward.

## THTS (Trial-Based Heuristic Tree Search)

Maintains explicit tree of alternating decision and chance nodes. Selection and expansion phases alternate until the **trial length**. In the backup phase all selected nodes are updated in a reverse order. When another selected but not yet visited node appears, continue with the selection phase.

A trial ends when the backup is called on the root node.

The process is repeated until the timeout $T$ allows for another trial.

Highest expectation action is returned – greedy action.

Heuristic function:

* action value initializatino (Q-value): $h: S \times A \mapsto \mathbb{R}$
* state value initialization (V-value): $h: S \mapsto \mathbb{R}$

Action selection: UCB 1, $\varepsilon$-greedy, ...

Outcome selection: Monte Carlo sampling, outcome based on the biggest potential impact

Optimal policy is dervied from the **Bellman optimality equation**
$$V^*(s) = \begin{cases}
0 & \text{if $s$ is terminal} \\
\max_{a \in A} Q^*(a, s) & \text{otherwise}
\end{cases}$$
$$Q^*(a, s) = R(a, s) + \sum_{s' \in S} P(s' \ | \ a, s) \cdot V^*(S')$$

**Monte Carlo backup.**
$$
V^k(s) = \begin{cases}
0 & \text{if $s$ is terminal} \\
\frac{\displaystyle\sum_{a \in A} n_{a,s} \cdot Q^k(a, s)}{n_s} & \text{otherwise}
\end{cases}
$$
$$Q^k(a, s) = R(a, s) + \frac{\sum_{s' \in S} n_{s'} \cdot V^k(s')}{n_{a, s}}$$

## MaxUCT

* Backup function
    * action-value: Monte Carlo backup $Q^k(s)$
    * state-value: Full Bellman backup $V^*(s)$
* Action selection: UCB-1
* Outcome selection: Monte Carlo sampling (MDP based)
* Heuristic function: N/A
* Trial length: UCT (horizon length, i.e. to leafs)

## UCT$^*$

* Backup function: Partial Bellman backup (weighted proportionally to subtree probability)
* Action selection: UCB-1
* Outcome selection: Monte Carlo sampling (MDP based)
* Heuristic function: ITerative Deepening Search with depth 15
* Trial length: explicit tree length + 1  
    (only initialized new nodes using heuristics)
* Resembles classical heuristic BFS
