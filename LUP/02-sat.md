# SAT solving

**SAT problem.** Given a formula $\varphi$ in CNF decide wheter $\varphi \in$ \verb|SAT|.

## Resolution rule

Let $l_1, \dots, l_m, l_{m + 1}, \dots, l_{m + n}$ be literals and $p$ be a propositional variable
$$\frac{\{l_1, \dots, l_m, \textcolor{red}{p}\} \quad \{\textcolor{red}{\bar{p}}, l_{m + 1}, \dots, l_{m + n}\}}{\{l_1, \dots, l_m, l_{m + 1}, \dots, l_{m + n}\}}$$
The clause $\{l_1, \dots, l_m, l_{m + 1}, \dots, l_{m + n}\}$ produced by the resolutino rule is called *resolvent* of the two *input* clauses. We call *p* and $\bar{p}$ a *coomplementary pair*.

**Resolution proof.** A *resolution proof* of clause $c$ from clauses $c_1, \dots, c_n$ is a finite sequence of clauses $d_1, \dots, d_m$ such that

* every $d_i$ is among $c_1, \dots, c_n$ or is derived by the resolution rule from input clauses $d_j$ and $d_k$ for $1 \leq j < k < i \leq m$,
* $c = d_m$.

We say that a clause $c$ is **provable** (derivable) from a set of clauses $\{c_1, \dots, c_n\}$, we write $\{c_1, \dots, c_n\} \vdash c$ if there is a proof of $c$ from $c_1, \dots, c_n$.

Let $\varphi$ be a set of clauses. If $\varphi$ is unsatisfiable, then $\varphi \vdash \square$.

Let $\varphi$ be a set of clauses. If $\varphi \vdash \square$ then $\varphi$ is unsatisfiable.

Either we produce the empty clause and hence $\varphi \notin$ \verb|SAT|, or we produce a satured set of clauses and hence $\varphi \in$ \verb|SAT|.

## Davis-Putnam algorithm

We have a set of clauses $\varphi$. We choose a variable $p$ such that both $p$ and $\bar{p}$ occur in $\varphi$ and eliminate it – we produce all posible $p$-resolvents and add them to $\varphi$ and then we remove all clauses in $\varphi$ that contain $p$ or $\bar{p}$. This operation preserves satisfiability.

**Subsumption.** A clause $c_1$ is said to *subsume* a clause $c_2$ if $c_1 \subseteq c_2$.

If $c_1, c_2 \in \varphi$ and $c_1 \subseteq c_2$ then $\varphi \in$ \verb|SAT| iff $\varphi \setminus c_2 \in$ \verb|SAT|. Moreover this can shorten a derivation of the empty clause.

If it is possible to obtain more different resolvents from two clauses, then all there resolvents are tautologies, hence always satisfiable and hance we can ignore them.

## DPLL algorithm
