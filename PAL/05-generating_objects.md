# Generating objects

## Combinatorial Generation

Suppose that $S$ is a finite set. A **ranking function** will be a bijection $rank: S \rightarrow \{ 0, \dots, |S| - 1 \}$ and $unrank* function is an inverse function to $rank$.

Given a ranking function $rank$ defined on $S$, the $successor$ function satisfies the following rule:
$$successor(s) = t \Leftrightarrow rank(t) = rank(s) + 1$$

## Subsets

Given a subset $T \subseteq S$ let us define the **characteristic vector** of $T$ to be the one-dimensional binary array where
$$x_i = \begin{cases}
1 & \text{if } (n - i) \in T \\
0 & \text{if } (n - i) \notin T
\end{cases}
$$

## Permutations

A **permutation** is a bijection from a set to itself.

## Gray code

The reflected binary code, also know as Gray code, is a binary numeral system where two successive values differ in only one bit.

$G^n$ will denote the reflected binary code for $2^n$ binary $n$-tuples, and it will be written as a list of $2^n$ vectors as follows:
$$G^n = \left[ G_0^n, G_1^n, \dots, G_{2^n - 1}^n \right]$$
The codes $G^n^ are defined recursively:
\begin{align*}
G^1 &= [0, 1] \\
G^n &= \left[ 0 G_0^{n - 1}, 0 G_1^{n - 1}, \dots, 0 G_{2^{n - 1} - 1}^{n - 1}, 1 G_{2^{n - 1} - 1}^{n - 1}, \dots, 1 G_1^{n - 1}, 1 G_0^{n - 1} \right]
\end{align*}

Suppose

* $0 \leq r \leq 2^n - 1$,
* $B = b_{n - 1}, \dots, b_0$ is a binary code of $r$,
* $G = g_{n - 1}, \dots, g_0$ is a Gray code of $r$.

Then for every $j \in \{0, 1, \dots, n - 1\}$
\begin{align*}
g_j &= \left(b_j + b_{j + 1} \right) (\mathrm{mod} \, 2) \\
b_j &= \left(g_j + b_{j + 1} \right) (\mathrm{mod} \, 2) \\
b_j &= \left( \sum_{i = j}^{n - 1} g_i \right) (\mathrm{mod} \, 2)
\end{align*}
