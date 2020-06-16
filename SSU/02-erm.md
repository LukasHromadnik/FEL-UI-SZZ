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
where with increasing number of examples the size of the interval decreases.

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
The ERM learning algorithm returns $h_m$ such that
\begin{equation}
h_m \in \argmin_{h \in \mathcal{H}} R_{\mathcal{T}^m}(h).
\label{eq:erm}
\end{equation}
Depending on the choice of $\mathcal{H}, \ell$ and the algorithm solving \ref{eq:erm} we get individual instances, e.g. SVM, Linear Regression, Neural Networks learned by back-propagation, etc.

Errors charactering a learning algorithm:

* $R^* = \inf_{h \in \mathcal{Y}^\mathcal{X}} R(h)$ best attainable (Bayes) risk
* $R(h_\mathcal{H})$ best risk in $\mathcal{H}; h_\mathcal{H} \in \argmin_{h \in \mathcal{H}} R(h)$
* $R(h_m)$ risk of $h_m = A(\mathcal{T}^m)$ learned from $\mathcal{T}^m$

**Excess error:** the quantity we want to minimize
$$\underbrace{\left( R(h_m) - R^* \right)}_\text{excess error} = \underbrace{\left( R(h_m) - R(h_\mathcal{H}) \right)}_\text{estimation error} + \underbrace{\left( R(h_\mathcal{H}) - R^* \right)}_\text{approximation error}$$

**Statistically consistent.** The algorithm $A: \cup_{m = 1}^\infty (\mathcal{X} \times \mathcal{Y})^m \to \mathcal{H}$ is *statistically consistent* in $\mathcal{H} \subseteq \mathcal{Y}^\mathcal{X}$ if for any $p(x, y)$ and $\varepsilon > 0$ it holds that
$$\lim_{m \to \infty} P(\underbrace{R(h_m) - R(h_\mathcal{H})}_\text{estimation error} \geq \varepsilon ) = 0$$
where $h_m = A(\mathcal{T}^m)$ is the hypothesis returned by the algorithm $A$ for training set $\mathcal{T}^m$ generated from $p(x, y)$.

The *statistically consistent* means that we can make the estimation error arbitrary small if we have enough examples.

**Uniform Law of Large Numbers.** The hypothesis space $\mathcal{H} \subseteq \mathcal{Y}^\mathcal{X}$ satisfies the uniform law of large numbers if for all $\varepsilon > 0$ it holds that
$$\lim_{m \to \infty} P\left(\sup_{h \in \mathcal{H}} |\underbrace{R(h) - R_{\mathcal{T}^m}(h)}_\text{generalization error}| \geq \varepsilon \right) = 0$$

ULLN says that the probability of seaing a "bad training set" can be made arbitrarily low if we have enough examples.

If $\mathcal{H}$ satisfies ULLN then ERM is statistically consistent in $\mathcal{H}$.

## Generalization bound for finite hypothesis space

Hoeffding inequality generalized for a finite hypothesis space $\mathcal{H}$
$$P\left( \max_{h \in \mathcal{H}} \left| R_{\mathcal{T}^m}(h) - R(h) \right| \geq \varepsilon \right) \leq 2 |\mathcal{H}| e^{-\frac{2m\varepsilon^2}{(b - a)^2}}$$

* For which $\varepsilon$ is $R(h)$ in the interval $(R_{\mathcal{T}^m}(h) - \varepsilon, R_{\mathcal{T}^m}(h) + \varepsilon)$ with the probability $1 - \delta$ at least, regardless what $h \in \mathcal{H}$ we consider?

$$P\left( \max_{h \in\mathcal{H}} \left| R_{\mathcal{T}^m}(h) - R(h) \right| < \varepsilon \right) = 1 - P \left( \max_{h \in \mathcal{H}} \left| R_{\mathcal{T}^m}(h) - R(h) \right| \geq \varepsilon \right) \geq 1 - 2 |\mathcal{H}| e^{-\frac{2m\varepsilon^2}{(b - a)^2}} = 1 - \delta$$
and solving the last equality for $\varepsilon$ yields
$$\varepsilon = (b - a) \sqrt{\frac{\log 2 |\mathcal{H}| + \log \frac{1}{\delta}}{2m}}$$

Let $\mathcal{H}$ be a finite hypothesis space and $\mathcal{T}^m = \{ (x^1, y^1), \dots, (x^m, y^m) \} \in (\mathcal{X} \times \mathcal{Y})^m$ a training set draw from i.i.d. random variables with distribution $p(x, y)$. Then, for any $0 < \delta < 1$, with probability at least $1 - \delta$ the ineqaulity
$$R(h) \leq R_{\mathcal{T}^m} + (b - a) \sqrt{\frac{\log 2 | \mathcal{H} | + \log \frac{1}{\delta}}{2m}}$$
holds for any $h \in \mathcal{H}$ and any loss function $\ell: \mathcal{Y} \times \mathcal{Y} \to [a, b]$.

The second term suggests that we have to use $\mathcal{H}$ with appropriate cardinality (complexity), e.g. if $m$ is small and $|\mathcal{H}|$ is high we can overfit.

## Linear classifier with minimal clasification error

* $\bm{\phi}: \mathcal{X} \to \mathbb{R}^n$ is fixed feature map embedding $\mathcal{X} \to \mathbb{R}^n$

Task is to find a linear classification strategy $h: \mathcal{X} \to \mathcal{Y}$
$$h(x; \bm{w}, b) = \sign(\langle \bm{w}, \bm{\phi}(x) \rangle + b) = \begin{cases}
+1 & \text{if } \langle \bm{w}, \bm{\phi}(x) \rangle + b \geq 0 \\
-1 & \text{if } \langle \bm{w}, \bm{\phi}(x) \rangle + b < 0
\end{cases}$$
with minimal expected risk
$$R^{0/1}(h) = \mathbb{E}_{(x, y) \sim p}\left( \ell^{0/1}(y, h(x))\right) \text{ where } \ell^{0/1}(y, y') = \llbracket y \ne y' \rrbracket$$
The ERM principle leads to solving
$$(\bm{w}^*, b^*) \in \argmin_{(\bm{w}, b) \in (\mathbb{R}^n \times \mathbb{R})} R_{\mathcal{T}^m}^{0/1}(h(\cdot; \bm{w}, b))$$
where the emprirical risk is
$$R_{\mathcal{T}^m}^{0/1}(h(\cdot; \bm{w}, b)) = \frac{1}{m} \sum_{i = 1}^m \llbracket y^i \ne h(x^i; \bm{w}, b) \rrbracket$$

## Vapnik-Chervonenkis (VC) Dimension

Let $\mathcal{H} \subseteq \{ -1, +1 \}^\mathcal{X}$ and $\{x^1, \dots, x^m\} \in \mathcal{X}^m$ be a set of $m$ input observations. The set $\{ x^1, \dots, x^m\}$ is said to be shattered by $\mathcal{H}$ if for all $\bm{y} \in \{-1, +1\}^m$ there exists $h \in \mathcal{H}$ such that $h(x^i) = y^i, i \in \{1, \dots, m\}$.

Let $\mathcal{H} \subseteq \{-1, +1\}^\mathcal{X}$. The Vapnik-Chervonenkis dimension of $\mathcal{H}$ is the cardinality of the largest set of points from $\mathcal{X}$ which can be shattered by $\mathcal{H}$.

The VC-dimension of the hypothesis space of all linear classifiers operation in $n$-dimensional feature space
$$\mathcal{H} = \{ h(x; \bm{w}, b) = \sign(\langle \bm{w}, \bm{\phi}(x) \rangle + b ) \ | \ ( \bm{w}, b ) \in ( \mathbb{R}^n \times \mathbb{R} ) \}$$
is $n + 1$.

Let $\mathcal{H} \subseteq \{ -1, +1 \}^\mathcal{X}$ be a hypothesis space with VC dimension $d < \infty$ and $\mathcal{T}^m = \{ (x^1, y^1), \dots, (x^m, y^m) \} \in (\mathcal{X} \times \mathcal{Y})^m$ a training set draw from i.i.d. rand vars with distribution $p(x, y)$. Then for any $\varepsilon > 0$ it holds
$$P \left( \sup_{h \in \mathcal{H}} \left| R^{0/1}(h) - R_{\mathcal{T}^m}^{0/1}(h) \right| \geq \varepsilon \right) \leq 4 \left( \frac{2em}{d} \right)^d e^{-\frac{m\varepsilon^2}{8}}.$$

Let $\mathcal{H} \subseteq \{ -1, +1 \}^\mathcal{X}$ be a hypothesis space with VC dimension $d < \infty$. Then ERM is statistically consistent in $\mathcal{H}$ w.r.t. $\ell^{0/1}$ loss function.

Let $\mathcal{H} \subseteq \{ -1, +1 \}^\mathcal{X}$ be a hypothesis space with VC dimension $d < \infty$. Then for any $0 < \delta < 1$ the inequality
$$R^{0/1}(h) \leq R_{\mathcal{T}^m}^{0/1}(h) + \sqrt{\frac{8(d \log(2m) + 1) + \log\frac{4}{\delta}}{m}}$$
holds for any $h \in \mathcal{H}$ with probability $1 - \delta$ at least.

## Trailing linear classifier from separable examples

The examples $\mathcal{T}^m = \{ (x^i, y^i) \in (\mathcal{X} \times \mathcal{Y}) \ | \ i = 1, \dots, m \}$ are **linearly separable** w.r.t. feature map $\bm{\phi}: \mathcal{X} \to \mathbb{R}^n$ if there exists $(\bm{w}, b) \in \mathbb{R}^{n + 1}$$ such that
$$y^i(\langle \bm{w}, \bm{\phi}(x^i) \rangle + b) > 0, \quad i \in \{ 1, \dots, m \}$$

\begin{algorithm}[h]
\caption{Perceptron algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} linearly separable examples $\mathcal{T}^m$ \\
\hspace*{\algorithmicindent} \textbf{Output:} linear classifier with $R_{\mathcal{T}^m}^{0/1}(h(\cdot; \bm{w}, b)) = 0$
\begin{algorithmic}[1]
\State $\bm{w} \gets \bm{0}$
\State $b \gets 0$
\State Find $(\bm{x}^i, y^i)$ such that $y^i(\langle \bm{w}, \bm{\phi}(x^i) \rangle + b) \leq 0$. If not found, the current $(\bm{w}, b)$ solves the problem.
\State $\bm{w} \gets \bm{w} + y^i \bm{\phi}(x^i)$
\State $b \gets b + y^i$
\State Go to step 2.
\end{algorithmic}
\end{algorithm}

## Training linear classifier from NON-separable examples

The intractable ERM problem we wish to solve
$$(\bm{w}^*, b^*) \in \argmin_{(\bm{w}, b) \in (\mathbb{R}^n \times \mathbb{R})} \frac{1}{m} \sum_{i = 1}^m \underbrace{\llbracket y^i \ne h(x^i; \bm{w}, b)) \rrbracket}_{\ell^{0/1}(y^i, h(x^i; \bm{w}, b))}$$
The ERM problem is approximated by a tractable convex problem
$$(\bm{w}^*, b^*) \in \argmin_{(\bm{w}, b) \in (\mathbb{R}^n \times \mathbb{R})} \frac{1}{m} \sum_{i = 1}^m \underbrace{\max\{ 0, 1 - y^i f(x^i; \bm{w}, b)\}}_{\psi(y^i, f(x^i; \bm{w}, b))}$$
where $f(x; \bm{w}, b) = \langle \bm{w}, \bm{\phi}(x) \rangle + b$ and $\psi(x, f(x))$ is so called **Hingle-loss**.

The hinge-loss is an upper bound of the $0/1$-loss evaluated for the predictor $h(x) = \sign(f(x))$.
