# Probabilistic Planning

Main formal model $\langle S, A, D, T, R \rangle$ where

* $S$ is a finite set of states of the world,
* $A$ is a finite set of actions the agent can perform,
* $D$ (*horizon*) is a finite / infinite set of time steps $(1, 2, \dots)$,
* $T: S \times A \times S \rightarrow [0, 1]$ is a transition function with
$$\sum_{s' \in S} T(s, a, s') = 1,$$
* $R: S \times A \times S \rightarrow \mathbb{R}$ is a reward function, that is typically bounded.

A solution to a task is a **history-dependent policy** $\pi$
$$\pi: H \times A \rightarrow [0, 1]; \quad \sum_{a \in A} \pi(h, a) = 1.$$

From now on, the policy is an assignment of an action in each state and time.

**Stationary policy**, when the policy is same every time state $s$ is visited: $\pi: S \rightarrow A$.

## FF-Replan

1. determinize the input domain (remove all probabilistic information from the problem)
2. synthesize a plan
3. execute the plan
4. should an unexpected state occur, replan

There are two main heuristics for discarding the probabilistic information:

* keep only one from all probabilistic outcomes of an action in a state, e.g. using the outcome with the highest probability,
* keep all outcomes, e.g. generate a separate action for each possible outcome.

## Robust-FF

1. deteminize the problem
2. use classical planner to find partial plans
3. aggregate these plans into the partial policy
4. continue until the probability of replanning is below given threshold

Number of options

* selecting determinization (most probable, all outcomes)
* selection goals (only problem goals, random goals, best goals)
* calculating probability of reaching terminal states

In general the algorithm is not (approximately) optimal.

## Value of a policy

We can express an expected reward for every state and time-step when specific policy is followed
$$V_\pi^k(s) = \mathrm{E} \left[ \sum_{t = 0}^k \gamma^t \cdot R(s_t, a_t, s_{t + 1}) \ | \ s_0 = s, a_t = \pi(s_t) \right]$$
where optimal policy is
$$\pi^{*,k}(s) = \argmax_\pi V_\pi^k(s)$$
For large (infinite) $k$ we can approximate the value by dynamic programming
\begin{align*}
V_\pi^0(s) &= O \\
V_\pi^k(s) &= \sum_{s' \in S} T(s, a, s')\left[R(s, a, s') + \gamma V_\pi^{k - 1}(s') \right], \quad a = \pi(s)
\end{align*}

## Value iteration (Bellman backup)

Basic algorithm for solving MDPs based on Bellman's equation
\begin{align*}
V^0(s) &= 0, \forall s \in S \\
V^k(s) &= \max_{a \in A}\sum_{s' \in S} \underbrace{T(s, a, s') \left[ R(s, a, s') + \gamma V^{k - 1}(s') \right]}_\text{$Q$-function $Q(s, a)$}
\end{align*}
for $k \to \infty$ values converge to optimum $V^k \to V^*$.

The optimal policy can be extracted by using a greedy approach
$$\pi^k(s) = \argmax_{a \in A}\sum_{s' \in S} T^k(s, a, s') \left[R^k(s, a, s') + \gamma V^k(s') \right]$$

VI has a stopping criterion (Bellman error): $|V - V'| < \varepsilon$

## Policy iteration

Alternative algorithm to value iteration. Starts with an arbitrary policy

* **policy evaluation:** recalculates value of states given the current policy $\pi^k$
* **policy improvement:** calculates a new maximum expected utility policy $\pi^{k + 1}$

until the strategy changes.

## VI/PI Heuristics

Initial calues can be assigned better – we can use a heuristic function instead of 0. We can use a single run of a planner (FF-Replan / Robust-FF) on the determinted version.
