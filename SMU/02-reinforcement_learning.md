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

Since $s_{k + 1}$ are distributed by $\Pc[P_S]{s_{k + 1}}{s_k, a_k}$, we can write this as
$$U^\pi(s_k) = r(s_k) + \gamma \sum_{s \in S} \Pc[P_S]{s}{s_k, \pi(s_k)} U^\pi(s).$$

**Optimal policy.**
$$\pi^* = \argmax_\pi U^\pi(s)$$

Considering the definition of $U^\pi(s_k), \pi^*$ maps each $s_k$ to an action maximizing the expected utility of the next state
$$\pi^*(s_k) = \argmax_{a \in A} \sum_{s \in S} \Pc[P_S]{s}{s_k, a} U(s)$$
$U(s) = U^{\pi^*}(s)$ is called the **state utility**.

So if the agent knows $P_S$ and $r$ it can decide optimally by $\pi^*(s_k)$. It first needs to compute $U(s), \forall s \in S$. They are solutions of $|S|$ non-linear **Bellman equations** (one for each $s \in S$)
$$U(s) = r(s) + \gamma \max_{a \in A} \sum_{s' \in S} \Pc[P_S]{s'}{s, a} U(s').$$
which can be solved by the **value iteration** algorithm.

## Passive Direct Utility Estimation (DUE) Agent

It follows a fixed proper policy $\pi$. With $\gamma = 1$, agent's estimate of $U^\pi(s)$ for state $s$ at time $k$ is the average of all **rewards-to-go** of $s$ until $k$.

A *reward-to-go* of $s$ is the sum of rewards from $s$ until the end of the current episode. If $s$ is visited multiple times in one episode, then that episode produces mutliple rewards-to-go to include in the average.

## Passive Adaptive Dynamic Programming (ADP) Agent

Instead of computing $\hat{U}$ directly from samples, learn a model of $P_S$ and $r$ and compute $\hat{U}$ from them.

For $r$ just collect an array $\hat{r}[s]$ of observed rewards for observed states.

For $\Pc[P_S]{s'}{s, a}$ collect the counts $N[s', s, a]$ of observed triples of action $a$ taken in state $s$ and resulting in state $s'$. Then estimate
$$\Pc[P_S]{s'}{s, a} \approx \frac{N[s', s, a]}{\sum_{s'' \in S} N[s'', s, a]}.$$

State utilities should satisfy
$$U^\pi(s) = r(s) + \gamma \sum_{s' \in S} \Pc[P_s]{s'}{s, \pi(s)} U^\pi(s').$$
The policy evaluation plugs in the computed models and calculates $\hat{U}$ by value iteration for all $s \in S$ until convergence
$$\hat{U} = \hat{r}[s] + \gamma \sum_{s' \in S} \frac{N[s', s, \pi(s)]}{\sum_{s'' \in S} N[s'', s, \pi(s)]} \hat{U}[s'].$$

## Passive Temporal Difference (TD) Agent

In the passive *temporal difference agent* the expensive policy evaluation of the ADP agent is replaced by only local changes. We make a small iteration for each executed transition
$$\hat{U}_{k + 1}[s_k] = \hat{U}_k[s_k] + \alpha\left(r_k + \gamma \hat{U}_k[s_{k + 1}] - \hat{U}_k[s_k] \right)$$
where $\alpha$ decreases with the number of times $s_k$ has been visited.

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
