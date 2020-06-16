# Support Vector Machines

## Primal SVM problem

Find linear classifier $h(w, \bm{w}, b) = \sign ( \langle \bm{\phi}(x), \bm{w} \rangle + b )$ by solving
$$(\bm{w}^*, b^*) = \argmin_{\bm{w} \in \mathbb{R}^n, b \in \mathbb{R}}
\bigg(
    \underbrace{\frac{1}{2} \lVert \bm{w} \rVert^2}
        _\text{penalty term}
    + C
    \underbrace{\sum_{i = 1}^m \max\{0, 1 - y^i ( \langle \bm{w}, \bm{\phi}(x^i) \rangle + b) \}}
        _\text{empirical error}
\bigg)
$$
where $C > 0$ is the regularization constant.

It can be re-formulated as a convext *quadratic program*
$$(\bm{w}^*, b^*, \bm{\xi}^*) = \argmin_{\substack{(\bm{w}, b) \in \mathbb{R}^{n + 1} \\ \bm{\xi} \in \mathbb{R}^m}} \left( \frac{1}{2} \lVert \bm{w} \rVert^2 + C \sum_{i = 1}^m \xi_i \right)$$
subject to
\begin{center}
\begin{tabular}{rcll}
$y^i(\langle \bm{w}, \bm{\phi}(x^i) \rangle + b)$ & $\geq$ & $1 - \xi_i$, & $i \in \{1, \dots, m\}$ \\
$\xi_i$ & $\geq$ & 0, & $i \in \{1, \dots, m\}$
\end{tabular}
\end{center}

Lagrangian of the primal SVM problem
$$L(\bm{w}, b, \bm{\xi}, \bm{\alpha}, \bm{\mu}) =
\underbrace{\frac{1}{2} \lVert \bm{w} \rVert^2 + C \sum_{i = 1}^m \xi_i}_\text{original objective}
-\underbrace{\sum_{i = 1}^m \alpha_i ( y^i ( \langle \bm{w}, \bm{\phi}(x^i) \rangle + b) - 1 + \xi_i) - \sum_{i = 1}^m \mu_i \xi_i}_\text{constraint violation penalty}
$$

## Dual SVM problem

$$\bm{alpha}^* = \argmax_{\bm{\alpha} \in \mathbb{R}^m} \left( \sum_{i = 1}^m \alpha_i - \frac{1}{2} \sum_{i = 1}^m \sum_{j = 1}^m \alpha_i \alpha_j y^i y^j \langle \bm{\phi}(x^i), \bm{\phi}(x^j) \rangle \right)$$
subject to
$$\sum_{i = 1}^m \alpha_i y^i = 0, \quad 0 \leq \alpha_i \leq C, \quad i \in \{ 1, \dots, m \}$$
The primal variables $(\bm{w}, b)$ are obtained from the dual variables $\alpha$ by
\begin{align*}
\bm{w} &= \sum_{i = 1}^m y&i \bm{\phi}(x^i) \alpha_i = \sum_{i \in \mathcal{I}_\mathrm{SV}} y^i \bm{\phi}(x^i) \alpha_i \\
b &= y^i - \langle \bm{w}, \bm{\phi}(x^i) \rangle, \forall i \in \mathcal{I}_\mathrm{SV}^b = \{ j \ | \ 0 < \alpha_j < C \}
\end{align*}

## Kernel SVM

The SVM algorithm required observatinos in terms of for products only. Gen a feature map $\bm{\phi}: \mathcal{X} \to \mathbb{R}^n$, define **kernel function** $k: \mathcal{X} \times \mathcal{X} \to \mathbb{R}$
$$k(x, x') = \langle \bm{\phi}(x), \bm{\phi}(x') \rangle$$

### Radial basis function (RBF) kernel

Assume observation are real-values features $\mathcal{X} = \mathbb{R}^d$. The RBF kernel
$$k(\bm{x}, \bm{x}') = \exp\left(-\gamma \lVert \bm{x} - \bm{x}' \rVert^2 \right)$$
corresponds to dot product $\langle \bm{\phi}(\bm{x}), \bm{phi}(\bm{x}') \rangle$ in infinite dimensional space

### String Subsequence kernel

Input space $\mathcal{X} = \bigcup_{d = 1}^\infty \Sigma^d$ contains all strings on a finite alphabet $\Sigma$.

The features: occurrence + continuity of sub-sequences of length $q$
$$\bm{\phi}: \mathcal{X} \to \mathbb{R}^{|\Sigma|^q} \quad \text{and} \quad \phi_u(s) = \sum_{\bm{i}: u = s[\bm{i}]} \lambda^{l(\bm{i})},\ \forall u \in \Sigma^q$$
where $s[\bm{i}]$ denote a sub-sequence of $\bm{s}$ and $\lambda \in (0, 1]$ is a decay factor.

### Positive definite kernel

Let $\mathcal{X}$ be a non-empty set. The function $k: \mathcal{X} \times \mathcal{X} \to \mathbb{R}$ is a **positive definite kernel** if it is **symetric** and for any finite set of inputs $x^1, \dots, x^m$ the kernel matrix $\mathbf{K} \in \mathbb{R}^{m \times m}$ with element $K_{i,j} = k(x^i, x^j)$ is positive semi-definite.

A matrix $\mathbf{K} \in \mathbb{R}^{m \times m}$ is PSD if for every $\bm{\alpha} \in \mathbb{R}^m, \bm{\alpha}^T \mathbf{K} \bm{\alpha} \geq 0$.

For every positive definite kernel $k: \mathcal{X} \times \mathcal{X} \to \mathbb{R}$ there exists a Hilbert space $\mathcal{H}$ and a feature map $\bm{\phi}: \mathcal{X} \to \mathcal{H}$ such that
$$k(x, x') = \langle \bm{\phi}(x), \bm{\phi}(x') \rangle$$

## Construction of valid kernels

Let $k_1: \mathcal{X} \times \mathcal{X} \to \mathbb{R}$ and $k_2: \mathcal{X} \times \mathcal{X} \to \mathbb{R}$ be p.d. kernels, $\lambda \in [0, 1], \alpha \geq 0, \bm{\phi}: \mathcal{X} \to \mathbb{R}^n$ and $k_3: \mathbb{R}^n \times \mathbb{R}^n \to \mathbb{R}$ a p.d. kernel, $\mathbf{K}$ a symetric positive definite matrix. Then the following functions are also p.d. kernels:
\begin{align*}
k(x, z) &= (1 - \lambda) k_1(x, z) + \lambda k_2(x, z) \\
k(x, z) &= \alpha k_1(x, z) \\
k(x, z) &= k_1(x, z) k_2 (x, z) \\
k(x, z) &= k_3(\bm{\phi}(x), \bm{\phi}(z)) \\
k(\bm{x}, \bm{z}) &= \bm{x}^T \mathbf{K} \bm{z}
\end{align*}
