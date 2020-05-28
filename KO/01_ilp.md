# ILP

The ILP problem is given by matrix $\mathbf{A} \in \mathbb{R}^{m \times n}$ and vectors $\mathbf{b} \in \mathbb{R}^m$ and $\mathbf{c} \in \mathbb{R}^n$. The goal is to find a vector $\mathbf{x} \in \mathbb{Z}^n$ such that $\mathbf{A} \cdot x \leq b$ and $c^T \cdot x$ is the maximum.

Usually the problem is given as

$$\max \left\{ c^T \cdot x : \mathbf{A} \cdot x \leq b, x \in \mathbb{Z}^n \right\}$$

Since the **ILP solution psace is not a convex set**, we cannot use convex optimization techniques.

The most successful method to solve the ILP problem are:

* Enumerative methods
* Branch and bound method
* Cutting planes methods

## Enumerative methods

Based on the idea of **inspecting all possible solutions**. Due to the integer nature of the variables, the number of solutions is countable but their number is huge. So this method is usually suited only for smaller instances with a small number of variables.

## Branch and bound method

The method is based on **splitting** the solutionn space into disjoint sets. It starts by relaxing on the integrality of the variables and **solves the LP problem**. If all variables $x_i$ are **integers, the computation ends**. Otherwise one variable $x_i \in \mathbb{Z}$ is chosen and its value is assigned to $k$. Then the solution space is **divided into two sets** – in the first one we consider $x_i \leq \lfloor k \rfloor$ and in the second one $x_i \geq \lfloor k \rfloor + 1$. The algorithm **recursively repeats** computation for the both new sets till feasible integer solution is found.

As sson as the algorithm finds an integer solutoin, its objective function value can be used for bounding. The **node is discarded** whenever *z*, its (integer or real) objective function value, is worse than $z^*$, the value of the best known solution.

## Special cases of ILP

Matrix $\mathbf{A} = [a_{ij}]$ of size $m/n$ is totally unimodular if the determinant of every square submatrix of matrix $\mathbf{A}$ is equal $0$, $+1$ or $-1$. Matrix $\mathbf{A}$ is totally unimodular if each colum contains onne non-zero element or exactly two non-zero elements $+1$ and $-1$.

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
at leat 3 items must be chosen & $\sum x_i \geq 3$ \\
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

## Cutting planes method

Another group of algorithm are cutting planes methods. Its general idea is (similarly to the branch and bound method) to repeat solution of LP problems. It iteratively addes a constraint that cuts off part of the solution space. The new constraint must fulfill these conditions:

* the solution found by LP becomes infeasible,
* all integer solutions feasible in the last step have to remain feasible.

### Gomory cuts

Algorithm

1. (Initialization) Solve the problem as an LP by a simplex algorithm
2. (Optimality test) If the solution is an integer, the computation ends.
3. (Reduction) Add new constraint (Gomory cut) into the simplex table. Optimize the problem by dual LP, then goto 2.