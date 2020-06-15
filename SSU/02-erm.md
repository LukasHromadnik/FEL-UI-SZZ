# Empirical Risk Minimization

Empirical risk:
$$R_{\mathcal{S}^l} (h) = \frac{1}{l} \sum_{i = 1}^l \ell(y^i, h(x^i))$$

**Law of large numbers.** Arithmetic mean of the results of random trials gets closer to the expected value as more trials are performed.

**Hoeffding inequality.** Let $\{z^1, \dots, z^l\} \in [a, b]^l$ be realizations of independent variables with the same expected value $\mu$. Then for any $\varepsilon > 0$ it holds that
$$P\left(\left| \frac{1}{l} \sum_{i = 1}^l z^i - \mu \right| \geq \varepsilon \right) \leq 2e^{-\frac{2l\varepsilon^2}{(b - a)^2}}$$

## Confidence intervals

* For which $\varepsilon$ is $\mu \in (\mu_l - \varepsilon, \mu_l + \varepsilon)$ with probability at least $\gamma$?
\begin{equation}
P\left(|\mu_l - \mu| < \varepsilon\right) = 1 - P\left( |\mu_l - \mu| \geq \varepsilon \right) \geq 1 - 2e^{-\frac{2l\varepsilon^2}{(b - a)^2}} = \gamma
\label{eq:conf-int}
\end{equation}
Using Hoeffding inequality we can write

and solving the last equality for $\varepsilon$ yields
$$\varepsilon = |b - a| \sqrt{\frac{\log(2) - \log(1 - \gamma)}{2l}}$$
where with increasing number of examples the interval decreases.

* What is the minimal number of examples such that $\mu \in (\mu_l - \varepsilon, \mu_l + \varepsilon)$ with probablity $\gamma$ at least?

Solving the \ref{eq:conf-int} for $l$ yields
$$l = \frac{\log(2) - \log(1 - \gamma)}{2\varepsilon^2} (b - a)^2$$

## Learning algorithm

Find a strategy $h: \mathcal{X} \to \mathcal{Y}$ minimizing $R(h)$ using the training set of examples $\mathcal{T}^m = \{(x^i, y^i) \in (\mathcal{X} \times \mathcal{Y}) \ | \ i = 1, \dots, m \}$ drawn from i.i.d. according to unknown $p(x, y)$.

The learning algorithm
$$A: \bigcup_{m = 1}^\infty (\mathcal{X} \times \mathcal{Y})^m \to \mathcal{H}$$
selects the strategy $h_m  = A(\mathcal{T}^m)$ based on the training set $\mathcal{T}^m$.

The expected risk $R(h)$, i.e. the true but unknown objective, is replaced by the empirical risk computed from examples
$$R_{\mathcal{T}^m}(h) = \frac{1}{m} \sum_{i = 1}^m \ell(y^i, h(x^i))$$
The ERM learning algorihtm returns $h_m$ such that
\begin{equation}
h_m \in \argmin_{h \in \mathcal{H}} R_{\mathcal{T}^m}(h).
\label{eq:erm}
\end{equation}
Depending on the choice of $\mathcal{H}, \ell$ and the algorithm solvin \ref{eq:erm} we get individual instances, e.g. SVM, Linear Regression, Neural Networks learned by back-propagation, etc.

Errors charactering a learning algorithm:

* $R^* = \inf_{h \in \mathcal{Y}^\mathcal{X}} R(h)$ bet attainable (Bayes) risk
* $R(h_\mathcal{H})$ best risk in $\mathcal{H}; h_\mathcal{H} \in \argmin_{h \in \mathcal{H}} R(h)$
* $R(h_m)$ risk of $h_m = A(\mathcal{T}^m)$ learned from $\mathcal{T}^m$

**Excess error:** the quantity we want to minimize
$$\underbrace{\left( R(h_m) - R^* \right)}_\text{excess error} = \underbrace{\left( R(h_m) - R(h_\mathcal{H}) \right)}_\text{estimation error} + \underbrace{\left( R(h_\mathcal{H}) - R^* \right)}_\text{approximation error}$$

**Statistically consistent.** The algorithm $A: \cup_{m = 1}^\infty (\mathcal{X} \times \mathcal{Y})^m \to \mathcal{H}$ is *statistically consistent* in $\mathcal{H} \subseteq \mathcal{Y}^\mathcal{X}$ if for any $p(x, y)$ and $\varepsilon > 0$ it holds that
$$\lim_{m \to \infty} P\left(\underbrace{R(h_m) - R(h_\mathcal{H})}_\text{estimation error} \geq \varepsilon \right) = 0$$
where $h_m = A(\mathcal{T}^m)$ is the hypothesis returned by the algorithm $A$ for training set $\mathcal{T}^m$ generated from $p(x, y)$.

The *statistically consistent* means that we can make the estimation error arbitrary small if we have enough examples.

**Uniform Law of Large Numbers.** The hypothesis space $\mathcal{H} \subseteq \mathcal{Y}^\mathcal{X}$ satisfies the uniform law of large numbers if for all $\varepsilon > 0$ it holds that
$$\lim_{m \to \infty} P\left(\sup_{h \in \mathcal{H}} \left| \underbrace{R(h) - R_{\mathcal{T}^m}(h)}_\text{generalization error} \right| \geq \varepsilon \right) = 0$$

ULLN says that the probability of seaing a "bad training set" can be made arbitrarily low if we have enough examples.

If $\mathcal{H}$ satisfies ULLN then ERM is statistically consistent in $\mathcal{H}$.

## Generalization bound for finite hypothesis space

Hoeffding inequality generalized for a finite hypothesis space $\mathcal{H}$
$$P\left( \max_{h \in \mathcal{H}} \left| R_{\mathcal{T}^m}(h) - R(h) \right| \geq \varepsilon \right) \leq 2 |\mathcal{H}| e^{-\frac{2m\varepsilon^2}{(b - a)^2}}$$

* For which $\varepsilon$ is $R(h)$ in the interval $(R_{\mathcal{T}^m}(h) - \varepsilon, R_{\mathcal{T}^m}(h) + \varepsilon)$ with the probability $1 - \delta$ at least, regardless what $h \in \mathcal{H}$ we consider?

$P\left( \max_{h \in\mathcal{H}} \left| R_{\mathcal{T}^m}(h) - R(h) \right| < \varepsilon \right) = 1 - P \left( \max_{h \in \mathcal{H}} \left| R_{\mathcal{T}^m}(h) - R(h) \right| \geq \varepsilon \right) \geq 1 - 2 |\mathcal{H}| e^{-\frac{2m\varepsilon^2}{(b - a)^2}} = 1 - \delta$$
and solving the last equality for $\varepsilon$ yields
$$\varepsilon = (b - a) \sqrt{\frac{\log 2 |\mathcal{H}| + \log \frac{1}{\delta}}{2m}}$$

Let $\mathcal{H}$ be a finite hypothesis space and $\mathcal{T}^m = \{ (x^1, y^1), \dots, (x^m, y^m) \} \in (\mathcal{X} \times \mathcal{Y})^m$ a training set draw from i.i.d. random variables with distribution $p(x, y)$. Then, for any $0 < \delta < 1$, with probability at least $1 - \delta$ the ineqaulity
$$R(h) \leq R_{\mathcal{T}^m} + (b - a) \sqrt{\frac{\log 2 | \mathcal{H} | + \log \frac{1}{delta}}{2m}}$$
holds for any $h \in \mathcal{H}$ and any loss function $\ell: \mathcal{Y} \times \mathcal{Y} \to [a, b]$.

The second term suggests that we have too use $\mathcal{H}$ with appropriate cardinality (complexity), e.g. if $m$ is small and $|\mathcal{H}|$ is high we can overfit.
