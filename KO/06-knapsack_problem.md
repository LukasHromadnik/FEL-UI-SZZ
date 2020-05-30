# Knapsack Problem

* **Instance:** Non-negative integers $n, c_1, \dots, c_n, w_1, \dots, w_n, W$, where $n$ represents the number of items, $c_1, \dots, c_n$ represents the cost of each item, $w_1, \dots, w_n represent the weight of each item and $W$ is the maximum weight to be carried in the knapsack.
* **Goal:** Find a subset $S \subseteq \{ 1, \dots, n \}$ such that $\sum_{j \in S} w_j \leq W$ and $\sum_{j \in S} c_j$ is the maximum.

## Fractional Knapsack Problem

While relaxing on the indivisibility of each item, we formulate a new problem:

* **Goal:** Find the rational numbers $x_1, \dots, x_j, \dots, x_n$ such that $0 \leq x_j \leq 1$ and $\sum_{j = 1}^n x_j \cdot w_j \leq W$ and $\sum_{j = 1}^n x_j \cdot c_j$ is the maximum.

Since the items can be divided (continous variable $x_j$), we can solve this problem in polynomial time.

Solution to this problem can be found as follows:

1. order and re-index the items by their relative cost:
$$ \frac{c_1}{w_1} \geq \frac{c_2}{w_2} \geq \cdots \geq \frac{c_n}{w_n}$$
2. in the ordered sequence find the first item which does not fit in the knapsack
$$k = \min\left\{ \sum_{i = 1}^j w_i > W \ | \ j \in \{ 1, \dots, n \} \right\}$$
3. in order to find the optimal solution, we cut off a part of $h$-th item, so that this part fits in the knapsack:
$$x_h = \frac{W - \sum_{i = 1}^{h - 1} w_i}{w_h}$$

Sorting of the items take $\mathcal{O}(n \log{n})$, computing $h$ can be done in $\mathcal{O}(n)$ by simple linear scanning

## 2-Approximation Algorithm

Algorithm $A$ for objective function $J$ maximization is called $r$-approximation if there exists a number $r \geq 1$ such that $J^A(I) \geq \frac{1}{r} J^*(I)$ for all instances $I$ of this problem.

Let $n, c_1, \dots, c_n, w_1, \dots, w_n, W, h$ are non-negative integers that satisfy:

* $w_j \leq W$ pro $j = 1, \dots, n$
* $\sum_{i = 1}^n w_i > W$
* $\frac{c_1}{w_1} \geq \frac{c_2}{w_2} \geq \cdots \geq \frac{c_n}{w_n}$
* $h = \min\left\{ \sum_{i = 1}^{j} w_i > W \ | \ j \in \{1, \dots, n\} \right\}$

Then choosing the better of the two solutions $\{1, \dots, h - 1\}$ or $\{h\}$ is **2-approximation algorithm for the Knapsack problem** with the time complexity $\mathcal{O}(n)$.

## Dynamic Programming (Integer Costs) for Knapsack

* Pseudopolynomial algorithm with time complexity $\mathcal{O}(nC)$.
* Variable $x_k^j$ represents the **minimum weight with cost $k$ which can be achieved as a selection of items from set $\{ 1, \dots, j \}$
* Item $j$ is added to the selection of items from $1, \dots, j$ if for the given price $k$ this set reaches the **lower or equal weight as set $1, \dots, j - 1$. The algorithm computes these values using the recursion formula

$$x_k^j = \begin{cases}
x_{k - c_j}{j - 1} + w_j & \text{if item } j \text{ was added} \\
x_k^{j - 1} & \text{if item } j \text{wasn't added}
\end{cases}
$$

Due to the optimal substructure property of the problem, the optimal solution may be found by the recurrent formula using Bellman's Principle of Optimality.

\clearpage

## Approximation Scheme

\begin{algorithm}[!htp]
\caption{Approximation Scheme}
\hspace*{\algorithmicindent} \textbf{Input:} Non-negative integer numbers $n, c_1, \dots, c_n, w_1, \dots, w_n, W$. Number $\epsilon > 0$. \\
\hspace*{\algorithmicindent} \textbf{Output:} Subset $S \subseteq \{ 1, \dots, n\}$
\begin{algorithmic}[1]
\State Run \textbf{2-approximation algorithm for Knapsack}
\State Label the solution as $S_1$ with cost $c(S_1) = \sum_{j \in S_1} c_j$
\State $t \gets \max\left\{1, \frac{\epsilon c(S_1)}{n}\right\}$
\State $c'_j \gets \lfloor \frac{c_j}{t} \rfloor$ for $j \in 1, \dots, n$
\State Run the \textbf{Dynamic programming algorithm for Knapsack} with instance $(n, c'_1, \dots, c'_n, w_1, \dots, w_n, W)$ using the upper bound $C = \frac{2c(S_1)}{t}$
\State Label the solution as $S_2$ with cost $c(S_2) = \sum_{j \in S_2} c_j$
\If{$c(S_1) > c(S_2)$}
    \State $S \gets S_1$
\Else
    \State $S \gets S_2$
\EndIf
\end{algorithmic}
\end{algorithm}
