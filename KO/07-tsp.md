# Traveling Salesman Problem

## Existence of Hamiltonian Circuit (HC)

* **Instance:** Undirected graph $G$.
* **Goal:** Decide if a Hamiltonian circuit (circuit visiting every node exactly once) exists in the graph $G$.

It's related decision problem to TSP. The directed version of this problem is **Hamiltonian cycle**.

## Problem formulation

* **Instance:** A complete undirected graph $K_n$ ($n \geq 3)$ and weights $c: E(K_n) \rightarrow \mathbb{Q}_0^+$.
* **Goal:** Find a Hamiltonian circuit $T$ which weight $\sum_{e \in E(T)} c(e)$ is minimal.

This problem is called **symetric TSP**. If the distance from city $A$ to city $B$ differs from the one from $B$ to $A$, we have to use a directed graph and we deal with an **asymetric TSP**.

## Strongly $\mathcal{NP}$-hard Problems

Let $L$ be an optimization problem.

For a polynomial $p$ let $L_p$ be the restriction of $L$ to such instances $I$ that consist of non-negative integers with $largest(I) \leq p(size(I))$, i.e. numerical parameters of $L_p$ are bounded by a polynomial in the size of the input.

$L$ is called **strongly $\mathcal{NP}$-hard** if there is a polynomial $p$ such that $L_p$ is $\mathcal{NP}$-hard.

If $L$ is strongly $\mathcal{NP}$-hard, then $L$ **cannot be solved by a pseudopolynomial** time algorithm unless $\mathcal{P} = \mathcal{NP}$.

**TSP** is strongly $\mathcal{NP}$-hard. If we believe $\mathcal{P} \ne \mathcal{NP}$, then there is no polynomial $r$-approximation algorithm for TSP for $r \geq 1$.

## Metric TSP

* **Instance:** Complete undirected graph $K_n$ ($n \geq 3$) with weights $c: E(K_n) \rightarrow \mathbb{R}_0^+$ such that $c(\{i, j\}) + c(\{j, k\}) \geq c(\{k, i\})$ for all $i, j, k \in V(K_n)$
* **Goal:** Find a Hamiltonian circuit $T$ such that $\sum_{e \in E(T)} c(e)$ is minimal.

This variant is also strongly $\mathcal{NP}$-hard. But approximation algorithms do exists.

## Nearest Neighbor

\begin{algorithm}[!htp]
\caption{Nearest Neighbor}
\hspace*{\algorithmicindent} \textbf{Input:} An instance $(K_n, c)$ of metric TSP. \\
\hspace*{\algorithmicindent} \textbf{Output:} Hamiltonian circuit $H$.
\begin{algorithmic}[1]
\State Choose arbitrary node $v_1 \in V(K_n)$
\For{$i \in 2, \dots, n$}
    \State Choose $v_i \in V(K_n) \setminus \{ v_1, \dots, v_{i - 1} \}$ such that $c(\{v_{i - 1}, v_i\})$ is minimal

\EndFor
\State Hamiltonian circuit $H$ is defined by the sequence $\{v_1, \dots, v_n, v_1 \}$
\end{algorithmic}
\end{algorithm}

This is not an approximation algorithm. The nearest city is chosen in each step. Time complexity is $\mathcal{O}(n^2)$.

## Double-tree Algorithm

\begin{algorithm}[!htp]
\caption{Double-tree Algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} An instance $(K_n, c)$ of the metric TSP. \\
\hspace*{\algorithmicindent} \textbf{Output:} Hamiltonian circuit $H$.
\begin{algorithmic}[1]
\State Find a \textbf{minimum weight spanning tree $T$} in $K_n$
\State By \textbf{doubling every edge} in $T$ we get a multigraph in which we find the \textbf{Eulerian walk $L$}
\State Transform the Eulerian walk $L$ to the Hamiltonian circuit $H$ in the complete graph $K_n$
\end{algorithmic}
\end{algorithm}

In the Eulerian walk $L$ we **skip nodes that are already in the sequence**. The rest creates the Hamiltonian circuit $H$.

Time complexity is $\mathcal{O}(n^2)$ and it's a 2-approximation algorithm for metric TSP.

## Christofides' Algorithm

\begin{algorithm}[!htp]
\caption{Christofides' Algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} An instance $(K_n, c)$ of metric TSP. \\
\hspace*{\algorithmicindent} \textbf{Output:} Hamiltonian circuit $H$.
\begin{algorithmic}[1]
\State Find a minimum weight spanning tree $T$ in $K_n$
\State Let $W$ be the set of vertices having an \textbf{odd degree} in $T$
\State Find a \textbf{minimum weight matching $M$} of nodes from $W$ in $K_n$
\State Merge of $T$ and $M$ forms a multigraph $(V(K_n), E(T) \cup M)$ in which we find the Eulerian walk $L$
\State Transform the Eulerian walk $L$ into the Hamiltonian circuit $H$ in the complete graph $K_n$
\end{algorithmic}
\end{algorithm}

Time complexity is $\mathcal{O}(n^3)$ and it's $\frac{3}{2}$-approximation algorithm for the metric TSP.

## Local Search $k$-OPT

One of the most successful techniques for TSP instances in practice.

* Find any Hamiltonian circuit by some heuristic
* Improve it by "local modifications" – delete 2 edges and reconstruct the circuit by some other edges

\begin{algorithm}[!htp]
\caption{$k$-OPT Algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} An instance $(K_n, c)$ of TSP, number $k \geq 2$. \\
\hspace*{\algorithmicindent} \textbf{Output:} Hamiltonian circuit $H$.
\begin{algorithmic}[1]
\State Let $H$ be any Hamiltonian circuit
\State Let $\mathcal{S}$ be the family of $k$-element subsets $S$ of $E(H)$ \label{alg:kOPT:creating-subset}
\ForAll{$S \in \mathcal{S}$}
    \State Outer loop deals with removed edges
    \ForAll{Hamiltonian circuits $H' \ne H$ such that $E(H') \supseteq E(H) \setminus S$}
        \State Inner loop deals with inserted edges
        \If{$c(E(H')) < c(E(H))$}
            \State $H \gets H'$
            \State Go to \ref{alg:kOPT:creating-subset}
        \EndIf
    \EndFor
\EndFor
\end{algorithmic}
\end{algorithm}
