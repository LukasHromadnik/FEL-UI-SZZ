# ILP

The ILP problem is $\mathcal{NP}$-hard and it's given by a matrix $\mathbf{A} \in \mathbb{R}^{m \times n}$ and vectors $\mathbf{b} \in \mathbb{R}^m$ and $\mathbf{c} \in \mathbb{R}^n$. The goal is to find a vector $\mathbf{x} \in \mathbb{Z}^n$ such that $\mathbf{A} \cdot \mathbf{x} \leq \mathbf{b}$ and $\mathbf{c}^T \cdot \mathbf{x}$ is the maximum.

Usually the problem is given as
$$\max \left\{ \mathbf{c}^T \cdot \mathbf{x} \ | \ \mathbf{A} \cdot \mathbf{x} \leq \mathbf{b}, \mathbf{x} \in \mathbb{Z}^n \right\}$$
Since the **ILP solution space is not a convex set**, we cannot use convex optimization techniques.

## Enumerative methods

Based on the idea of **inspecting all possible solutions**. Due to the integer nature of the variables, the number of solutions is countable but their number is huge. So this method is usually suited only for smaller instances with a small number of variables.

## Branch and bound method

This method is based on **splitting** the solution space into disjoint sets. It starts by relaxing on the integrality of the variables and **solves the LP problem**. If all variables $x_i$ are **integers, the computation ends**. Otherwise one variable $x_i \in \mathbb{Z}$ is chosen and its value is assigned to $k$. Then the solution space is **divided into two sets** – in the first one we consider $x_i \leq \lfloor k \rfloor$ and in the second one $x_i \geq \lfloor k \rfloor + 1$. The algorithm **recursively repeats** computation for both new sets untill feasible integer solution is found.

As soon as the algorithm finds an integer solution, its objective function value can be used for bounding. The **node is discarded** whenever *z*, its (integer or real) objective function value, is worse than $z^*$, the value of the best known solution.

## Cutting planes method

Another group of algorithms are cutting planes methods. Its general idea is (similarly to the branch and bound method) to repeat solution of LP problems. It iteratively adds a constraint that cuts off part of the solution space. The new constraint must fulfill these conditions:

* the solution found by LP becomes infeasible,
* all integer solutions feasible in the last step have to remain feasible.

\begin{algorithm}[!htp]
\caption{Gomory cuts}
\begin{algorithmic}[1]
\State (Initialization) Solve the problem as an LP by a simplex algorithm.
\State (Optimality test) If the solution is an integer, the computation ends. \label{alg:gomory:optimality-test}
\State (Reduction) Add new constraint (Gomory cut) into the simplex table. Optimize the problem by dual LP, then goto \ref{alg:gomory:optimality-test}.
\end{algorithmic}
\end{algorithm}

## Special cases of ILP

Matrix $\mathbf{A} = [a_{ij}]$ of size $m \times n$ is **totally unimodular** if the determinant of every square submatrix of the matrix $\mathbf{A}$ is equal to $0$, $+1$ or $-1$. Matrix $\mathbf{A}$ is **totally unimodular** if each column contains one non-zero element or exactly two non-zero elements $+1$ and $-1$.

The ILP problem with a totally unimodular matrix $\mathbf{A}$ and integer vector $b$ can be solved by a simplex algorithm and the solution will be an integer. Also it can be solved in polynomial time for this matrix.

## Representaion formulas as ILP

\begin{center}
\begin{tabular}{ll}
\toprule
Formula & ILP \\ \hline
$x_1 \Rightarrow \overline{x_3}$ & $x_1 + x_3 \leq 1$ \\
$x_2 \Rightarrow x_1$ & $x_2 \leq x_1$ \\
$x_4 \text{ XOR } x_5$ & $x_4 + x_5 = 1$ \\
1 must be chosen but 2 can not & $x_1 = 1, x_2 = 0$ \\
at least 3 items must be chosen & $\sum x_i \geq 3$ \\
exactly 3 items must be chosen & $\sum x_i = 3$ \\
$(x_1 \text{ AND } x_2) \Rightarrow x_3$ & $x_1 \cdot x_2 \leq x_3$ \\
exactly 2 items can not be chosen & $\!\begin{aligned}
                                                \sum x_i & \leq 1 + M \cdot y \\
                                                M \cdot (1 - y) + \sum x_i & \geq 3 \\
                                                y \in \{ 0, 1 \}
                                                \end{aligned}$ \\
\bottomrule
\end{tabular}
\end{center}

### At least $K$ of $N$ constraints must hold

\begin{align*}
f(x_1, x_2, \dots, x_n) &\leq b_1 + M \cdot y_1 \\
f(x_1, x_2, \dots, x_n) &\leq b_2 + M \cdot y_2 \\
& \vdots \\
f(x_1, x_2, \dots, x_n) &\leq b_N + M \cdot y_N \\
\sum_{i = 1}^N y_i &= N - K
\end{align*}
