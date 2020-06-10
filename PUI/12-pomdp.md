# Partially Observable Markov decision Processes

Main formal model for scenarios with uncertain observations $\langle S, A, D, O, b_0, T, \Sigma, R, \gamma \rangle$ where

* $S$ is a finite set of states of the world,
* $A$ is a finite set of actinos the agent can perform,
* $D$ are time steps,
* $O$ is finite set of possible observations,
* $b_0: S \to [0, 1]$ is an initial belief,
* $T: S \times A \times S \to [0, 1]$ is a transition function,
* $\Sigma: A \times O \times S \to [0, 1]$ is an observation probability,
* $R: S \times A \to \mathbb{R}$ is reward function and
* $0 \leq gamma < 1$ is a discount factor.

## Beliefs

Beliefs represent a probability distribution over states. Beliefs are uniquely identified by the history, i.e. $b_1$ is the probablity distributino over states after playing one action.
$$b_t = \mathrm{Pr}(s_t \ | \ b_0, a_0, o_1, \dots, o_{t-1}, a_{t-1}, o_t)$$
We can exploit dynamic programming (define transformation of beliefs, belief update)
$$b_t(s') = \mu \cdot \Sigma(a, o, s') \cdot \sum_{s \in S} T(s, a, s') b_{t-1}(s)$$
where

* $o$ is the last observation,
* $a$ is the last action,
* $\mu$ is the nrormalizing constant.

## Values

Beliefs determine new values
$$V(b) = \max_{a \in A} \left[R(b, a) + \gamma \Sigma_{b' \in B} T(b, a, b') V(b')\right]$$

What we have done here is that we have transformed a POMDP to a continuous state MDP.
