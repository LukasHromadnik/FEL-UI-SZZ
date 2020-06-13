# General Framework

## Percepts and Actions

* Discrete time: $k = 1, 2, \dots$
* Percepts: $\forall k: x_k \in X$
* Actions: $\forall k: a_k \in A$

**History.** Interaction or *history* up to time $m$ which we denote $\histe$
$$\histe = x_1, a_1, x_2, a_2, \dots, x_m, a_m$$
starts with a percept $x_1$ and has a probability
$$P(\histe) = P(x_1) \cdot \pc{a_1}{x_1} \cdot \pc{x_2}{x_1, a_1} \cdots \pc{x_m}{\hist} \cdot \pc{a_m}{x_m, \hist}.$$

**Deterministic agent.** We will only assume *deterministic agent*
$$\pc{a_k}{\hist, x_k} = \begin{cases}
1 & \text{if } a_k = \pi(\hist, x_k) \\
0 & \text{otherwise}
\end{cases}$$
where $\pi(\hist, x_k)$ is the agent's **policy**.

**Rewards, observations.** *Rewards* $r_k \in R \subset \mathbb{R}$ are a distinguished part of percepts
$$x_k = \langle o_k, r_k \rangle$$
while everything else in the percepts are *observations* $o_k \in O$. The set $R$ of possible rewards must be **bounded**, i.e. $\exists a, b \in \mathbb{R}, \forall r \in R, a \leq r \leq b$.

## Policy value

The agent's goal is to maximize the value $V^\pi$ of its policy $\pi$ defined as

* for a **finite** time horizon $m \in \mathbb{N}$, the expected cumulative reward
$$V^\pi = \mathbb{E}\left(\sum_{k = 1}^m r_k \right) = \sum_{x_{\leq m}} \pc{x_{\leq m}}{a_{< m}}(r_1 + r_2 + \cdots + r_m)$$
* for the **infinite** horizon, use a *discount sequence* $\delta_k$ such that $\sum_{i = 1}^\infty \delta_i < \infty$ (usually $\delta_k = \gamma^k, 0 < \gamma < 1$), and maximize
$$V^\pi = \mathbb{E}\left(\sum_{k = 1}^\infty r_k \delta_k \right) = \lim_{m \to \infty} \sum_{x_{\leq m}} \pc[P_R]{r_{\leq m}}{a_{< m}} \sum_{k = 1}^m r_k \delta_k$$

**Markovian Environment.** A *Markovian* or state-based *environment* is one for which a state variable $s: \mathbb{N} \to S$ and distributions $P_X, P_S$ exist such that $S$ has bounded size and

* $\pc{x_k}{\hist[k]} = \pc[P_X]{x_k}{s_k}$, i.e. $x_k$ depends only on the current state.
* State $s_{k + 1}$ is distributed accoding to $\pc[P_S]{s_{k + 1}}{s_k, a_k}$, i.e. it depends only on the previous state and the action taken by the agent.

**Markovian Agent.** A *Markovian* or state-based *agent* is one for which a state variable $t: \mathbb{N} \to T$ and functions $\pi, \mathcal{T}$ exist such that $T$ has bounded size and

* $\pi(x_{\leq k}) = \pi(t_k, x_k)$. Since $T$ is bounded, some different histories will result in the same action of the agent. One can view $t_k$ as agent's flexible (learnable) decision model while $\pi$ its fixed interpreter.
* For $k > 1, t_{k + 1} = \mathcal{T}(t_k, x_{k + 1})$, i.e. it depends only on the previous state and the latest percept. $\mathcal{T}$ is the state update function, which will be the core of the learning.

## Markovian Interaction Model

Agent                                             Environment 
-----         -----                               -----         -----
actions:      $a_k = \pi(t_k)$                    percepts:     $x_k \sim \pc[P_X]{x_k}{s_k}$
state update: $t_k = \mathcal{T}(t_{k - 1}, x_k)$ state update: $s_k \sim \pc[P_S]{s_k}{s_{k - 1}, a_{k - 1}}$

## Proper Policies

If $s_k$ is a **terminal** then $s_{k + 1}$ is sampled independently of $s_k, a_k$ from $P_S(s_{k  + 1})$, i.e. just like the initial state $s_1$. The interaction history between a terminal (or an initial) state and the next terminal state is called an **episode**.

Informally, the environment is "restarted" after a terminal state. However, the agent is not restarted, so it can learn from one episode to another.

**Proper policy.** For a given environment, a policy $\pi$ is *proper* if it is guaranteed to achieve a terminal state.

With a proper policy, we can modify the agent's goal as to maximize
$$\mathbb{E}\left(\sum_{k = 1}^m r_k \right)$$
where $s_m$ is the first terminal state in the interaction (no need for a discount factor).
