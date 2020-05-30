# Network Flows

By network we mean a 5-tuple $(G, l, u, s, t)$, where

* $G$ denotes the oriented graph (digraph),
* $l: E(G) \rightarrow \mathbb{R}_0^+$ denotes the minimum capacity of the arcs,
* $u: E(G) \rightarrow \mathbb{R}_0^+$ denotes the maximum capacity of the arcs,
* $s$ represents the source node,
* $t$ represents the sink node.

$f: E(G) \rightarrow \mathbb{R}_0^+$ is the **flow** if Kirchhoff law
$$\sum_{e \in \delta^-(v)} f(e) = \sum_{e \in \delta^+(v)} f(e)$$
is valid for every node except $s$ and $t$. Also **feasible flow** must satisfy $f(e) \in \langle l(e), u(e) \rangle$. There might be no feasible flow when $l(e) > 0$.

Given a network $(G, l, u, s, t)$. The goal is to find the **feasible flow $f$** from the source to the sink that maximizes
$$\sum_{e \in \delta^+(s)} f(e) - \sum_{e \in \delta^-(s)} f(e).$$

## Ford-Fulkerson Algorithm

The algorithm is based on **incremental augmentation** of the flow along the **path** from source $s$ to sink $t$ while maintaining the flow's feasibility. The path from source $s$ to sink $t$ **does not respect the orientation of arcs**.

An augmenting path for flow $f$ is a path from $s$ to $t$ with

* $f(e) < u(e)$ if $e$ is a forward arc $\rightarrow$ the flow can be increased
* $f(e) > l(e)$ if $e$ is a backward ard $\rightarrow$ the flow can be decreased

Capacity $\gamma$ of the augmenting path is the biggest possible increase of the flow on the augmenting path.

\begin{algorithm}[!htp]
\caption{Ford-Fulkerson Algorithm}
\hspace*{\algorithmicindent} \textbf{Input:}  Network $(G, l, u, s, t)$ \\
\hspace*{\algorithmicindent} \textbf{Output:} Maximum feasible flow $f$ from $s$ to $t$
\begin{algorithmic}[1]
\State Find the feasible flow $f(e)$ for all $e \in E(G)$.
\State Find an augmenting path $P$. If non exists then stop. \label{alg:ff:main-loop}
\State Compute $\gamma$, the capacity of an augmenting path $P$. Augment the flow from $s$ to $t$ and go to \ref{alg:ff:main-loop}.
\end{algorithmic}
\end{algorithm}

Increase flow by $\gamma$ on forward arcs and decrease flow by $\gamma$ on backward arcs. This preserves feasibility of the flow and Kirchhof's law moreover the flow is augmented by $\gamma$.

The flow from $s$ to $t$ is the **maximum** iff there is no augmenting path.

\begin{algorithm}[!htp]
\caption{Finding the Augmenting path}
\label{alg:finding-augmenting-path}
\begin{algorithmic}[1]
\State Label $m_s = \text{TRUE}, m_v = \text{FALSE}, \forall v \in V(G) \setminus s$.
\State If there exists $e = (v_i, v_j) \in E(G)$ that satisfies $m_i = \text{TRUE}, m_j = \text{FALSE}$ and $f(e) < u(e)$, then $m_j = \text{TRUE}$. \label{alg:finding-augmenting-path:main-loop}
\State If there exists $e = (v_i, v_j) \in E(G)$ that satisfies $m_i = \text{FALSE}, m_j = \text{TRUE}$ and $f(e) > l(e)$, then $m_i = \text{TRUE}$.
\State If $t$ is reached, then the search stops as we have found the augmenting path $P$. If it is not possible to mark another node, then $P$ does not exists. In other cases go to step \ref{alg:finding-augmenting-path:main-loop}.
\end{algorithmic}
\end{algorithm}

## Minimum Cut Problem

The cut in $G$ is an edge set $\delta(A)$ with $s \in A$ and $t \in V(G) \setminus A$ (i.e. the cut separates nodes $s$ and $t$). The **minimum cut** is the cut of minimum capacity
$$C(A) = \sum_{e \in \delta^+(A)} u(e) - \sum_{e \in \delta^-(A)} l(e).$$

The value of the maximum flow from $s$ to $t$ is equal to the capacity of the **minimum cut**.

When the labeling procedure of Finding the Augmenting path algorithm (\ref{alg:finding-augmenting-path}) stops, the minimum cut is given by the labeled vertices.

If the capacities of the network are integers, then **an integer-valued maximum flow exists**.

When choosing the augmenting path, if we always choose the shortest one, time complexity is $\mathcal{O}(m^2n)$.

## Minimum Cost Flow

**Instance:** 5-tuple $(G, l, u, c, b)$ where

* **cost of arcs** $c: E(G) \rightarrow \mathbb{R}$
* **balance** $b: V(G) \rightarrow \mathbb{R}$ that represents the supply /consumption of the nodes and satisfies $\sum_{v \in V(G)} b(v) = 0$.

**Goal:** Find the feasible flow $f$ that minimizes
$$\sum_{e \in E(G)} f(e) \cdot c(e)$$
and satisfies
$$\sum_{e \in \delta^+(v)} f(e) - \sum_{e \in \delta^-(v)} f(e) = b(v)$$
for all $v \in V(G)$, or decide that it does not exists.

## Matching

**Matching** is the set or arcs $P \subseteq E(G)$ in graph $G$ such that the endpoints are all different (no arcs from $P$ are incident with the same node). When all nodes of $G$ are incident with some arc in $P$, we call $P$ a **perfect matching**.

### Maximum Cardinality Matching Problem

Let $G$ be a graph and let $M$ be some matching in $G$. A path $P$ is an **$M$-alternating path** if $E(P) \setminus M$ is a matching. An $M$-alternating path is **$M$-augmenting** if its endpoints are not covered by $M$.

The $M$ is maximum matching iff there is no $M$-augmenting path.

\begin{algorithm}[!htp]
\caption{Maximum Cardinality Matching Problem}
\begin{algorithmic}[1]
\State Find the arbitrary matching.
\State Find the $M$-alternating path with uncovered endpoints. Exchange the matching along the alternating path. Repeat as long as such a path does exist.
\end{algorithmic}
\end{algorithm}

### Maximum Cardinality Matching in Bipartite Graphs

Can be transformed to the maximum flow problem:

1. Add source $s$ and edge $(s, i)$ for all $i \in X$.
2. Add sink $t$ and edge $(j, t)$ for all $j \in Y$.
3. Edge orientation should be $s \rightarrow X \rightarrow Y \rightarrow t$.
4. The upper bound of all edges is equal to 1 and the lower bound is equal to 0.
5. By solving the maximum flow from $s$ to $t$ we obtain maximum cardinality matching.

### Assignment Problem

We have $n$ exmployees and $n$ tasks and we know the cost of execution for each possible employee-task pair. Goal is to assign one task per employee while minimizing the total cost.

Can be solved using **Hungarian Algorithm**.

## Minimum Cost Multicommodity Flow Problem

**Instance:** 5-tuple $(G, l, u, c, b^1, \dots, b^m, \dots, b^{|M|})$ where

* vectors $b^m: V(G) \rightarrow \mathbb{R}$ that express (**supply / consumption**) of nodes by commodity $m$. $\sum_{v \in V(G)} b^m(v) = 0$ **for all commodities** $m \in M$.

**Goal:** Find the feasible flow $f$ which cost $C$ is minimal or decide that such a flow does not exist.

$$C = \sum_{e \in E(G)} \sum_{m \in M} f^m(e) \cdot c(e)$$

Feasible flow satisfies

$$\sum_{e \in \delta^+(v)} f^m(e) - \sum_{e \in \delta^-(v)} f^m(e) = b^m(v)$$

for all $v \in V(G)$ and all $m \in M$.
