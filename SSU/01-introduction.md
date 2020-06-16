# Introduction

* **object features** $x \in \mathcal{X}$ are observable
* **state of the object** $y \in \mathcal{Y}$ is usually hidden
* **prediction strategy (inference rule)** $h: \mathcal{X} \to \mathcal{Y}$
    * $y$ is a categorical variable $\Rightarrow$ classification
    * $y$ is a real valued variable $\Rightarrow$ regression
* **training examples** $\{(x, y) \ | \ x \in \mathcal{X}, y \in \mathcal{Y}\}$
* **loss function** $\ell: \mathcal{Y} \times \mathcal{Y} \to \mathbb{R}^+$ penalises wrong predictions

**Goal:** optimal prediction strategy $h$ that minimises the loss

Main assumptions:

* $X, Y$ are random variables,
* $X, Y$ are related by an **unknown joint** p.d.f. $p(x, y)$,
* we can collect examples $(x, y)$ drawn from $p(x, y)$.

Typical concepts:

* **regression:** $Y = f(X) + \varepsilon$, where $f$ is unknown and $\varepsilon$ is a random error,
* **classification:** $p(x, y) = p(y) \pc[p]{x}{y}$ where $p(y)$ is the prior class probability and $\pc[p]{x}{y}$ is the conditional feature distribution.

Consequences and problems:

* the inference rule $h(X)$ and the loss $\ell(Y, h(X))$ become random variables,
* risk of the inference rule $h(X) \Rightarrow$ expected loss
$$R(h) = \mathbb{E}\ell(Y, h(X)) = \sum_{x \in \mathcal{X}} \sum_{y \in \mathcal{Y}} p(x, y) \ell(y, h(x))$$

Since $p(x, y)$ is unknown we can estimate $R(h)$ by **empirical risk** based on the test sample $\mathcal{S}^l = \{(x^i, y^i) \in \mathcal{X} \times \mathcal{Y} \ | \ i = 1, \dots, l\}$ drawn from $p(x, y)$
$$R(h) \approx R_{\mathcal{S}^l}(h) = \frac{1}{l} \sum_{i = 1}^l \ell(y^i, h(x^i))$$

The best possible (optimal) inference rule $h(x)$ is the **Bayes inference rule**
$$h^*(x) = \argmin_{y' \in \mathcal{Y}} \sum_{y \in \mathcal{Y}} \pc[p]{y}{x}\ell(y, y')$$
but $p(x, y)$ is **not known** and we can only collect examples drawn from it.

## Learning types

### Discriminative learning

The optimal inference rule $h^*$ is in some class of rules $\mathcal{H} \Rightarrow$ replace the true risk by **empirical risk** based on training data $\mathcal{T}$
$$R_\mathcal{T}(h) = \frac{1}{|\mathcal{T}|} \sum_{(x, y) \in \mathcal{T}} \ell(y, h(x))$$
and minimise it w.r.t. $h \in \mathcal{H}$, i.e. $h_\mathcal{T}^* = \argmin_{h \in \mathcal{H}} R_\mathcal{T}(h)$.

### Generative learning

The true p.d. $p(x, y)$ is in some parametrised family of distributions, i.e. $p = p_{\theta^*} \in \mathcal{P}_\Theta \Rightarrow$ split the dependence on unknown $\theta \in \Theta$ and random $\mathcal{T}$:

1. $\theta_\mathcal{T}^* = \argmax_{\theta \in \Theta} p_\theta(\mathcal{T})$, i.e. **maximum likelihood estimator**,
2. set $h_\mathcal{T}^* = h_{\theta_\mathcal{T}^*}$ where $h_\theta$ denotes the **Bayes inference rule** for the p.d. $p_\theta$.
