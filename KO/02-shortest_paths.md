# Shortest paths

* **Instance:** Directed graph $G$, weights $c: E(G) \rightarrow \mathbb{R}$, nodes $s, t \in V(G)$.
* **Goal:** Find the shortest $s - t$ path $P$, i.e. one of minimum weight $c(E(P))$, or decide that $t$ is unreachable from $s$.

We consider oriented graphs:

* negative weights are allowed
* negative cycles are not allowed, since the shortest path problem becomes $\mathcal{NP}$-hard.

If path from $s$ to $t$ exists in the graph, then the shortest path from $s$ to $t$ exists too.

If there is no **negative weight or zero weight cycle** in the graph, then every shortest edge progression from $s$ to $t$ is the shortest path from $s$ to $t$.

If there is no **negative weight cycle** in the graph, then every shortest edge progression from $s$ to $t$ contains the shortest path from $s$ to $t$ and the length of this path is the same.

**Triangle inequality.** If the graph does not contain a cycle of negative weight then distances between **all triplets of nodes** $i, j, k$ satisfy:
$$l(i, j) \leq l(i,k) + l(k, j).$$

**Bellman's principle of optimality.** Suppose we have directed graph $G$, weights $c: E(G) \rightarrow \mathbb{R}$, no negative cycles. Let $k \in \mathbb{N}$, and let $s$ and $w$ be two vertices. Let $P^k$ be a shortest one among all $s-w$ paths with at most $k$ edges, and let $e = (v, w)$ be its final edge. Then $P^{k - 1}[s, v]$ (i.e. $P^k$ without the edge $e$) is a shortest one among all $s-v$ paths with at most $k - 1$ edges.

## Dijsktra's Algorithm

* $\mathcal{O}(n^2)$ or $\mathcal{O}(m + n \log n)$ using priority queue

\begin{algorithm}[!htp]
\caption{Dijkstra's Algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} directed graph $G$, weights $c: E(G) \rightarrow \mathbb{R}_0^+$ and node $s \in V(G)$ \\
\hspace*{\algorithmicindent} \textbf{Output:} $l(v)$ length of the shortest path from $s$ to $v$, $p(v)$ predecessor of $v$ on the shortest path
\begin{algorithmic}[1]
\State $l(s) \gets 0; \quad l(v) \gets \infty, \forall v \ne s; \quad R \gets \emptyset$
\While{$R \ne V(G)$}
    \State Find $v \in V(G) \setminus R$ such that $l(v) = \min_{i \in V(G) \setminus R} l(i)$
    \State $R \gets R \cup \{ v \}$
    \For{$w \in V(G) \setminus R$ such that $(v, w) \in E(G)$}
        \If{$l(w) > l(v) + c(v, w)$}
            \State $l(w) \gets l(v) + c(v, w)$
            \State $p(w) = v$
        \EndIf
    \EndFor
\EndWhile
\end{algorithmic}
\end{algorithm}

To accelerate the computation time we can add **additional information** to Dijkstra's algorithm in order to perform **informed search**. This is idea of A* algorithm which is generalization of Dijkstra that cuts down on the size of the subgraph that must be explored.

Dijkstra is so-called **label setting algorithm**, since label $l(v)$ becomes permanent (optimal) at each iteration.

In contrast, **label-correcting algorithms** (e.g. Bellman-Ford's or Floyd's algorithm) consider all labels as temporary until the final step, when they all become permanent.

## Bellman-Ford Algorithm

* $\mathcal{O}(nm)$

\begin{algorithm}[!htp]
\caption{Bellman-Ford Algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} directed graph $G$ without negative cycle, weights $c: E(G) \rightarrow \mathbb{R}$ and node $s \in V(G)$ \\
\hspace*{\algorithmicindent} \textbf{Output:} $l(v)$ length of the shortest path from $s$ to $v$, $p(v)$ predecessor of $v$ on the shortest path
\begin{algorithmic}[1]
\For{$i \gets 1$ to $n - 1$}
    \ForAll{edge $(v, w) \in E(G)$}
        \If{$l(w) > l(v) + c(v, w)$}
            \State $l(w) \gets l(v) + c(v, w)$
            \State $p(w) \gets v$
        \EndIf
    \EndFor
\EndFor
\end{algorithmic}
\end{algorithm}

If the iteration of the main loop terminates without making any changes, the algorithm can be terminated, as subsequent iterations will not make any more changes.

Bellman-Ford algorithm can **detect negative cycle** that is reachable from vertex $s$ while checking triangular inequality for resulting $l$.

\begin{algorithm}[!htp]
\caption{Bellman-Ford Algorithm – negative cycle detection}
\begin{algorithmic}[1]
\ForAll{edge $(v, t) \in E(G)$}
    \If{$l(t) > l(v) + c(v, t)$}
        \State \textbf{error} Graph contains a negative-weight cycle
    \EndIf
\EndFor
\end{algorithmic}
\end{algorithm}

\newpage

## Floyd Algorithm {#sec:floyd-algorithm}

* $\mathcal{O}(n^3)$

\begin{algorithm}[!htp]
\caption{Floyd Algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} directed graph $G$, weights $c: E(G) \rightarrow \mathbb{R}_0^+$ \\
\hspace*{\algorithmicindent} \textbf{Output:} $l_{ij}$ is the length of the shortest path from $i$ to $j$, $p_{ij}$ is the predecessor of $j$ on such path
\begin{algorithmic}[1]
\State $l_{ij} \gets c((i, j)), \forall (i, j) \in E(G)$
\State $l_{ij} \gets \infty, \forall (i, j) \notin E(G) \text{ where } i \ne j$
\State $l_{ii} \gets 0, \forall i$
\State $p_{ij} = i, \forall (i, j)$
\For{$k \gets 1, \dots, n$}
    \For{$i \gets 1, \dots, n$}
        \For{$j \gets 1, \dots, n$}
            \If{$l_{ij} > l_{ik} + l_{kj}$}
                \State $l_{ij} \gets l_{ik} + l_{kj}$
                \State $p_{ij} \gets p_{kj}$
            \EndIf
        \EndFor
    \EndFor
\EndFor
\end{algorithmic}
\end{algorithm}

The best known algorithm for **all pairs shortest path** problem without negative cycles. Negative cycle can be detected by check $l_{ii} < 0$ for some $i$.

## Johnson's Algorithm

Is better suited for sparse graphs then Floyd \ref{sec:floyd-algorithm}. Uses Dijkstra and Bellmand-Ford with total time complexity $\mathcal{O}(|V| \cdot |E| \cdot \log |V|)$.

## Dynamic programming perspective

**Optimal substructure.** The solution to a given optimization problem can be obtained by the **combination of optimal solutions to its subproblems**. Such optimal substructures are usually described by means of **recurrent formula** (examples are Bellman equation in Bellman-Ford algorithm and "shortest path consists of shortests paths in Floyd algorithm").

**Overlapping subproblems.** Computed **solutions to subproblems are stored** so that there don't have to recomputed. Dynamic programming is not useful when there are no common (overlapping) subproblems because there is no point of storing the solution if they are not needed again.
