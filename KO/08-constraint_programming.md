# Constraint Programming

**Constraint Satisfaction Problem (CSP)** is defined by the triplet $(X, D, C)$ where

* $X = \{x_1, \dots, x_n\}$ is a finite set of variables,
* $D = \{D_1, \dots, D_n\}$ is a finite set of domains of variables,
* $C = \{C_1, \dots, C_n\}$ is a finite set of constraints.

**Domain** $D_i = \{v_1, \dots, v_k\}$ is a **finite** set of all possible values of $x_i$.

**Constraint** $C_i$ is a couple $(S_i, R_i)$ where $S_i \subseteq X$ and $R_i$ **is a relation** over the set of variables $S_i$. For $S_i = \{ x_{i_1}, \dots, x_{i_r}\}$ is $R_i \subseteq D_{i_1} \times \cdots \times D_{i_r}$.

CSP is an $\mathcal{NP}$-complete problem.

## Terminology

* **Solution** to CSP is the complete **assignment of values** from the domains to the variables such that **all constraints are satisfied** (it's a decision problem).
* Constraint Satisfaction Optimization Problem (CSOP) is defined by $(X, D, C, f(X))$ where $f(x)$ is the objective function. The search is not finished when the first acceptable solution was foundm, but it is finished when the **otpimal solution** was found (e.g. by using branch & bound).
* Constraint Solving is defined by $(X, D, C)$ where $D_i$ is defined on $\mathbb{R}$ (e.g. the solution of the set of linear equations-inequalities).
* Constraint Programming (CP) includes Constraint Satisfaction and Constraint Solving.

## Comparison with ILP

* CSP allows one to formulate **complex constraints**. It's possible to form any kind of relation between variables. In ILP only inequalities are possible.
* It's difficult to represent continuous problems by CSP. Can be bypassed by using hybrid approaches, e.g. combination with LP.

## Arc consistency

We will continue to consider only **binary CSP**, where every constraint is a binary relation. Binary CSP can be represented by **digraph $G$**.

Arc $(x_i, x_j)$ is **Arc Consistent (AC)** iff for each value $a \in D_i$ there exists a value $b \in D_j$ such that the assignment $x_i = a, x_j = b$ meeting all binary constraints for the variables $x_i, x_j$. A **CSP is arc consistent** if all arc are arc consistent. Note that AC is **oriented** – the consistence of arc $(x_i, x_j)$ does not guarantee the consistence of arc $(x_j, x_i)$.

## REVISE Procedure

From domain $D_i$ delete any value $a$ which is not consistent with domain $D_j$

\begin{algorithm}[!htp]
\caption{REVISE Procedure}
\hspace*{\algorithmicindent} \textbf{Input:} Domain $D_i$ to be revised. Domain $D_j$. Set of constraints $C$. \\
\hspace*{\algorithmicindent} \textbf{Output:} Binary variable $deleted$ indicating deletion of some value from $D_i$. Revised domain $D_i$.
\begin{algorithmic}[1]
\State $deleted \gets 0$
\For{$a \in D_i$}
    \If{there is no $b \in D_j, x_i = a, x_j = b$ that satisfies all cosntraints on $x_i, x_j$}
        \State $D_i \gets D_i \setminus a$
        \State $deleted \gets 1$
    \EndIf
\EndFor
\end{algorithmic}
\end{algorithm}

## AC-3 Algorithm

Maintain a queue of arcs to be revised (the arc is put in the queue only if it's consistency could have been affected by thee reduction of the domain).

\begin{algorithm}[!htp]
\caption{AC-3 Algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} $X, D, C$ and graph $G$ \\
\hspace*{\algorithmicindent} \textbf{Output:} Binary variable $fail$ indicating no solution in this part of the state space. The set of revised domains $D$.
\begin{algorithmic}[1]
\State $fail \gets 0$
\State $Q \gets E(G)$
\While{$Q \ne \emptyset$}
    \State select and remove arc $(x_k, x_m)$ from $Q$
    \State $(deleted, D_k) \gets \mathrm{REVISE}(k, m, D_k, D_m, C)$
    \If{$deleted$}
        \If{$D_k = \emptyset$}
            \State $fail \gets 1$
            \State \textbf{exit}
        \Else
            \State $Q \gets Q \cup \{(x_i, x_k)\}$ such that $(x_i, x_k) \in E(G)$ and $i \ne m$
        \EndIf
    \EndIf
\EndWhile
\end{algorithmic}
\end{algorithm}

The revision of $(x_k, x_m)$ does not change the arc consistency of $(x_m, x_k)$.
