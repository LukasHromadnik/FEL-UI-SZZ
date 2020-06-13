# PAC-learning Model

Now we will assume that $s_{k + 1}$ does not depend on $s_k$ or $a_k$ so all $s_k$ are sampled from the same distribution $P_S(s)$ so the $s_k$ are i.i.d. As a consequence, observations $o_k$ are also i.i.d. from $P_O(o)$ where
$$P_O(o) = \sum_{s \in \{0, 1\}} \pc[P_O]{o}{s} P_S(s)$$

The i.i.d. assumption lets us defined the **error of a hypothesis $h$** as the total probability of observations, which $h$ decides incorrectly
$$\f{err}{h} = P_O\left( [C \setminus C(h)] \bigcup [C(h) \setminus C] \right)$$
and the **accuracy** of $h$ as
$$\f{acc}{h} = 1 - \f{err}{h}$$

Informally, PAC-learning means finding a low-error hypothesis with high probability using a polynomial number of observations.

Agent **probably approximately correctly (PAC) learns** $\mathcal{H}$ if for any $C \in \mathcal{C}(\mathcal{H})$ and number $0 < \varepsilon, \delta < 1$, there is $k < poly(n, 1/\varepsilon, 1/\delta)$ where $n$ is the size of observations such that the agent's hypothesis $h_k$ has $\f{err}{h_k} \leq \varepsilon$ with probability at least $1 - \delta$. $\mathcal{H}$ is **PAC-learnable** if there is an agent that PAC-learns it.

We say the agent PAC-learns $\mathcal{H}$ **efficiently** if it spends at most $poly(n, 1/\varepsilon, 1/\delta)$ time between each percept and the subsequent action; if there is such an agent, $\mathcal{H}$ is **efficiently PAC-learnable**.

With the additional condition that $h_k \in \mathcal{H}$, we say that the agent **properly** (efficiently) PAC-learns $\mathcal{H}$, and if there is such an agent for $\mathcal{H}$, we say that $\mathcal{H}$ is **properly** (efficiently) PAC-learnable.

## Generalizing Agent

Let $O_l \subseteq O$ denote the set of all observations inconsistent with a literal $l$. We know already that a hypothesis $h$ makes a mistake for an observation only if it has a literal inconsistent with it, so
$$\f{err}{h} \leq \sum_{l \in h} P_O(O_l)$$
With $n$ variables, there are at most $2n$ literals in $h$ so if $P_O(O_l) \leq \varepsilon / 2n$ for each literal $l \in h$ then $\f{err}{h} \leq \varepsilon$. Call literal $l$ **bad** if
$$P_O(O_l) > \frac{\varepsilon}{2n}$$
Let $l$ be bad. At time $k + 1$ the probability that $l \in h_{k + 1}$ is consistent with $k$ i.i.d. observations is $(1 - P_O(O_l))^k$. Due to the previous equation we have
$$(1 - P_O(O_l))^k < \left(1 - \frac{\varepsilon}{2n}\right)^k$$
Probability that some bad literal is consistent with the $k$ observations is upper bounded by the above times the number of all literals so it is at most
$$2n \left(1 - \frac{\varepsilon}{2n}\right)^k < 2ne^{-k \frac{\varepsilon}{2n}}$$
To satisfy PAC-learning conditions, we need to make it
$$2ne^{-k\frac{\varepsilon}{2n}} < \delta$$
which is equivalent to
$$k \geq \frac{2n}{\varepsilon} \ln \frac{2n}{\delta}$$
So for $k = \frac{2n}{\varepsilon} \ln \frac{2n}{\delta}, \f{err}{h_{k + 1}} \leq \varepsilon$ with probability at least $\delta$. Since $k + 1 \leq poly(n, 1/\delta, 1/\varepsilon)$, **the agent PAC-learns conjunctions**.

It also learns them efficiently as it spends only $2n$ unit steps (checking each literal's consistency) on each observation.

## Standard On-line Agent

An on-line agent deciding by $\pi(h, o)$ is *standard* if it changes its hypothesis iff $h_k$ makes an error ($r_{k + 1} = -1$). This includes the generalizing and separating agent but not the version-space.

Consider any standard on-line agent with mistake bound $M$. Let $q \in \mathbb{N}$ and $k = Mq$. In the agent's sequence of hypotheses $h_1, h_2, \dots, h_{k + 1}$, there must be a hypothesis $h$ retained for at least $q$ consecutive steps, i.e. $\exists K \leq k$ such that $h = h_K = h_{K + 1} = \cdots = h_{K + q}$.

The probability that a hypothesis $h$ is consistent with $q$ i.i.d. observations is $(1 - \f{err}{h})^q$. Call a hypothesis **bad** if $\f{err}{h} > \varepsilon$. So a bad hypothesis is consistent with $q$ i.i.d. observations with probability at most $(1 - \varepsilon)^q$.

With $q = \frac{1}{\varepsilon} \ln \frac{1}{\delta}$, we get $(1 - \varepsilon)^q \leq e^{-q\varepsilon} = e^{-\varepsilon \frac{1}{\varepsilon} \ln \frac{1}{\delta}} = \delta$. Since both $M$ and $q$ are $\leq poly(n, 1/\delta, 1/\varepsilon)$, so is $k + 1 = Mq + 1$, thus if a standard agent (efficiently) learns $\mathcal{H}$ online it also (efficiently) PAC-learns it.

## Batch Learning

Consider concept learning in an interaction with a finite horizon $m + 1$. The agent's goal is to minimize the error of its last hypothesis $\f{err}{h_{m + 1}}$. At time step $m + 1$ the agent has received exactly $m$ observations with determined classes $T = \{ \langle o_1, s_1 \rangle, \dots, \langle o_m, s_m \rangle \}$ which is called the **training (multi-)set**.

Rather than updating the hypothesis at each $k = 2, 3, \dots, m + 1$, the agent can simply store the training set in its state and only at time $m + 1$ compute a hypothesis from $T$. We will call this **batch learning**.

The hypothesis a PAC-learning agent computes from any training set is conosistent with it.

## Consistent Agent

Consider a general **consistent agent** learning $\mathcal{H}'$ and equipped with some hypothesis class $\mathcal{H}$. Given a training set $T$ of size $m$ it produces an arbitrary $h \in \mathcal{H}$ consistent with $T$.

Note that producing a consistent hypothesis for any given $T$ is only possible if the target concept $C$ is in $\mathcal{C}(\mathcal{H})$. $C \in \mathcal{C}(\mathcal{H})$ is arbitrary, so $\mathcal{C}(\mathcal{H}) \supseteq \mathcal{C}(\mathcal{H}')$ is a necessary condition.

The probability that a hypothesis $h \in \mathcal{H}$ consistent with $T$ is bad is $(1 - \f{err}{h})^m < (1 - \varepsilon)^m$. There are at most $|\mathcal{H}|$ hypotheses so the probability that some bad hypothesis is consistent with $T$ is at most
$$|\mathcal{H}| (1 - \varepsilon)^m < |\mathcal{H}| e^{-\varepsilon m}$$

$|\mathcal{H}| e^{-\varepsilon m}$ is smaller than $\delta$ if
$$m \geq \frac{1}{\varepsilon} \ln \frac{|\mathcal{H}|}{\delta}$$
