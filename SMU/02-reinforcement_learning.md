# Reinforcement Learning

*Reinforcement learning* is a collection of techniques by which the agent achieves high rewards in the state-based (Markovian) setting under two assumptions:

* environment is **fully observable**,
* reward is a function of the current state: $\forall k: r_k = r(s_k)$.

There is no $P_x$ anymore because percepts are here as a function of states
$$x_k = (o_k, r_k) = (s_k, r(s_k)).$$

The environment is described by the update (transition) distribution $P_S$ and the reward function $r$, both of which are unknown to the agent.

## Agent State, Fixed Policy

Agent state $t_k$ contains the agent's model at time $k$, prescribing the action (decision) policy
$$a_k = \pi(t_k, s_k).$$
In the simplest case $t_k$ may be a static lookup table $\Pi$
$$\pi(\Pi, s_k) = \Pi[s_k].$$
When the agent state does not change with $k$ as here, we call the policy *fixed*.

To evaluate fixed policy we can use **expected utility** of the state
$$U^\pi(s_k) = \mathbb{E}\left[ \sum_{i = 0}^\infty \gamma^i r(s_{k + i}) \right] = r(s_k) + \gamma U^\pi(s_{k + 1})$$
where $0 < \gamma < 1$ is the **discount factor**.

If $\pi$ is proper, we can have $\gamma = 1$ summing only up to the first terminal state $s_{k + i}$.

Since $s_{k + 1}$ are distributed by $\pc[P_S]{s_{k + 1}}{s_k, a_k}$, we can write this as
$$U^\pi(s_k) = r(s_k) + \gamma \sum_{s \in S} \pc[P_S]{s}{s_k, \pi(s_k)} U^\pi(s).$$

**Optimal policy.**
$$\pi^* = \argmax_\pi U^\pi(s)$$

Considering the definition of $U^\pi(s_k), \pi^*$ maps each $s_k$ to an action maximizing the expected utility of the next state
$$\pi^*(s_k) = \argmax_{a \in A} \sum_{s \in S} \pc[P_S]{s}{s_k, a} U(s)$$
$U(s) = U^{\pi^*}(s)$ is called the **state utility**.

So if the agent knows $P_S$ and $r$ it can decide optimally by $\pi^*(s_k)$. It first needs to compute $U(s), \forall s \in S$. They are solutions of $|S|$ non-linear **Bellman equations** (one for each $s \in S$)
$$U(s) = r(s) + \gamma \max_{a \in A} \sum_{s' \in S} \pc[P_S]{s'}{s, a} U(s').$$
which can be solved by the **value iteration** algorithm.

## Passive Direct Utility Estimation (DUE) Agent

It follows a fixed proper policy $\pi$. With $\gamma = 1$, agent's estimate of $U^\pi(s)$ for state $s$ at time $k$ is the average of all **rewards-to-go** of $s$ until $k$.

A *reward-to-go* of $s$ is the sum of rewards from $s$ until the end of the current episode. If $s$ is visited multiple times in one episode, then that episode produces mutliple rewards-to-go to include in the average.

## Passive Adaptive Dynamic Programming (ADP) Agent

Instead of computing $\hat{U}$ directly from samples, learn a model of $P_S$ and $r$ and compute $\hat{U}$ from them.

For $r$ just collect an array $\hat{r}[s]$ of observed rewards for observed states.

For $\pc[P_S]{s'}{s, a}$ collect the counts $N[s', s, a]$ of observed triples of action $a$ taken in state $s$ and resulting in state $s'$. Then estimate
$$\pc[P_S]{s'}{s, a} \approx \frac{N[s', s, a]}{\sum_{s'' \in S} N[s'', s, a]}.$$

State utilities should satisfy
$$U^\pi(s) = r(s) + \gamma \sum_{s' \in S} \pc[P_s]{s'}{s, \pi(s)} U^\pi(s').$$
The policy evaluation plugs in the computed models and calculates $\hat{U}$ by value iteration for all $s \in S$ until convergence
$$\hat{U} = \hat{r}[s] + \gamma \sum_{s' \in S} \frac{N[s', s, \pi(s)]}{\sum_{s'' \in S} N[s'', s, \pi(s)]} \hat{U}[s'].$$

### Design

Agent's state is a tuple $t_k = \rangle \Pi, s_k^\mathrm{old}, N_k, \hat{r}_k, \hat{U}_k \rangle$ where

* $\Pi$ is a fixed decision array,
* $s_k^\mathrm{old}$ is the last seen state,
* $N_k$ is 3-way contingency array indexed by $[s' \in S, s \in S, a \in A]$,
* $\hat{r}_k$ is the reward array indexed by $s \in S$,
* $\hat{U}_k$ is the state utility estimate array indexed by $s \in S$.

## Passive Temporal Difference (TD) Agent

In the passive *temporal difference agent* the expensive policy evaluation of the ADP agent is replaced by only local changes. We make a small iteration for each executed transition
$$\hat{U}_{k + 1}[s_k] = \hat{U}_k[s_k] + \alpha\left(r_k + \gamma \hat{U}_k[s_{k + 1}] - \hat{U}_k[s_k] \right)$$
where $\alpha$ decreases with the number of times $s_k$ has been visited.

### Design

Agent's state is a tuple $t_k = \langle \Pi, s_k^\mathrm{old}, r_k^\mathrm{old}, N_k, \hat{U}_k, \alpha \rangle$ where

* $\Pi$ is a fixed decision array,
* $s_k^\mathrm{old}$ is the last seen state, $s_1^\mathrm{old} = \mathrm{none}$,
* $r_k^\mathrm{old}$ is the last reward, $r_1^\mathrm{old} = 0$,
* $N_k$ is a state frequency array addressed by $s$, $N_1$ filled with zeros,
* $\hat{U}_k$ is a state utility estimate array addressed by $s \in S$. $\hat{U}_1$ filled with none,
* $\alpha: \mathbb{N} \to \mathbb{R}$ is a positive monotone decreasing function.

This agent has no model of $P_s$ and $r$. It just remembers a single (last state) reward.

## Passive Agents

* Direct utility estimation
    * simple to implement, model-free
    * each update is fast
    * does not exploit state dependence and thus converges slowly
* Adaptive dynamic programming
    * harder to implement, model-based
    * each update is a full policy evaluation (expensive)
    * fully exploits state dependence, fastest convergence in terms of episodes
* Temporal difference learning
    * similar to DUE: model-free, update speed and implementation
    * partially exploits state dependences but does not adjust to *all* possible successors
    * convergence in between DUE and ADP

## Active ADP Agent

Change the passive ADP agent into an *active* one following the optimal policy principle
$$a_k = \pi^*(t_k, s_k) = \argmax_{a \in A} \sum_{s \in S} \pc[P_S]{s}{s_k, a} U(s).$$
With models $N_k, \hat{U}_k$ of $P_S, U$ stored in $t_k = \langle \Pi, s'_k, N_k, \hat{r}_k, \hat{U}_k \rangle$ gives
$$a_k = \pi(t_k, s_k) = \argmax_{a \in A} \sum_{s \in S} \frac{N_k[s, s_k, a]}{\sum_{s' \in S} N_k[s', s_k, a]} \hat{U}_k[s].$$

This agent is **greedy**: never chooses a sub-optimal (w.r.t. $\hat{U}_k$) state just to explore it.

## $n$-armed Bandit

The $n$-armed bandit problem

* set of actions $A$ and rewards $R$,
* agent repeatedly picks $a \in A$ and gets $r \in R$ according to $\pc[P_{r|a}]{r}{a}$,
* no states, just a series of independent trials,
* agent's goal is to, without knowing $P_{r|a}$, maximize mean of received rewards.

**Greedy approach:**
$$a = \argmax_{a \in A} \hat{r}[a]$$
**Explorative approach** with some $0 < \varepsilon < 1$:
$$a = \begin{cases}
\argmax_{a \in A} \hat{r}[a] & \text{with probability } 1 - \varepsilon \\
\text{random action} & \text{with probability } \varepsilon
\end{cases}
$$
Instead of switching, decaying $\varepsilon \to 0$ also possible.

## Greedy in the limit of infinite exploration (GLIE)

A GLIE strategy makes sure that with $k \to \infty$ in each state each action is tried an infinite number of times.

In reinforcement learning, take a random action with a decaying probability $\varepsilon > 0, \varepsilon \xrightarrow{k \to \infty} 0$. For example choose a random action $a$ with a *softmax* probability.

GLIE strategies tend to converge slow.

## Exploration Function

Faster convergence is achieved if unexplored nodes are deliberately promoted by tweaking the utility function
$$U_e^\pi(s_k) = r(s_k) + \gamma \max f\left(\sum_{s \in S} \pc[P_S]{s}{s_k, a_k} U_e^\pi(s_k), N_k(s_k, a_k)\right)$$
where
$$a_k = \pi(s_k) = \argmax_{a \in A} \sum_{s \in S} \pc[P_S]{s}{s_k, a} U_e^\pi(s)$$.
The *exploration function* $f$ trades off between

* the estimated expected utility of the next state and
* $N_k(s, a)$ the number of times action $a$ was taken in state $s$ until time $k$.

## Active TD Agent

Active version of TD agent would need a model of $P_S$ to estimate $U$ to approximate the policy. This can be prevented, instead of learning state utilities $U^\pi(s)$, learn **state-action utilities** $Q^\pi(s, a)$.

$Q^\pi(s, a)$ is the utility of taking an action $a$ in state $s$ under policy $\pi$, so
$$U^\pi(s) = \max_a Q^\pi(s, a)$$

## Explorative Q-Learning Agent

$Q^\pi$ can be computed as the solution to the set of Bellman-like equations
$$Q^\pi(s, a) = r(s) + \gamma \sum_{s' \in S} \pc[P_s]{s'}{s, a} \max_{a' \in A} Q^\pi(s', a'), \quad \forall s \in S, \forall a \in A.$$
This is achieved without $P_S$ by iterating similar to TD
$$Q^\pi(s_k, a_k) = Q^\pi(s_k, a_k) + \alpha \left( r_k + \gamma \max_a Q^\pi(s_{k + 1}, a) - Q^\pi(s_k, a_k) \right).$$
The exploration incentive is put in the policy
$$a_k = \begin{cases}
\text{none} & \text{if $s_k$ is terminal} \\
\argmax_a f\left(Q^\pi(s_k, a), N(s_k, a)\right) & \text{otherwise}
\end{cases}
$$

### Design

Agent's state is a tuple $t_k = \langle s_k^\mathrm{old}, a_k^\mathrm{old}, r_k^\mathrm{old}, N_k, \hat{Q}_k, \alpha \rangle$ where

* $s_k^\mathrm{old}, a_k^\mathrm{old}$ are the last state and action,
* $r_k^\mathrm{old}$ is the last reward,
* $N_k$ is state-action pair frequency array addressed by $[s, a]$,
* $\hat{Q}_k$ is en estimate array of $Q^\pi$ addressed by $[s, a]$,
* $\alpha: \mathbb{N} \to \mathbb{R}$ is a positive monotone descreasing function.

### Greedy Q-Learning Agent

Consider a greedy (non-exploratory) variant of the Q-Learning agent, deciding by
$$a_{k + 1} = \argmax_a Q^\pi(s_{k + 1}, a).$$
We can get rid of the maximization in the iteration
$$Q^\pi(s_k, a_k) = Q^\pi(s_k, a_k) + \alpha(r_k + \gamma Q^\pi(s_{k + 1}, a_{k + 1}) - Q^\pi(s_k, a_k)).$$

### SARSA Agent

*SARSA agent* is the exploratory Q-Learning agent where even for a nono-greedy strategy the iteration is changed to
$$Q^\pi(s_k, a_k) = Q^\pi(s_k, a_k) + \alpha(r_k + \gamma Q^\pi(s_{k + 1}, a_{k + 1}) - Q^\pi(s_k, a_k)).$$
Q-Learning is an **off-policy** stratedy. Tends to learn $Q$ better even if $\pi$ is far frmo optimal.

SARSA is an **on-policy** stratedy. Tends to adapt better to partially enforced policies.
