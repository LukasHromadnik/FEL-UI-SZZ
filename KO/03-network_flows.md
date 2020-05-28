# Network Flows

By network we mean a 5-tuple $(G, l, u, s, t)$, where

* $G$ denotes the oriented graph,
* $l: E(G) \rightarrow \mathbb{R}_0^+$ denotes the minimum capacity of the arcs,
* $u: E(G) \rightarrow \mathbb{R}_0^+$ denotes the maximum capacity of the arcs,
* $s$ represents the source node,
* $t$ represents the sink node.

There is an oriented path from the source node $s$ to every other node and there is an oriented path from every other node to the sink node $t$.

$f: E(G) \rightarrow \mathbb{R}_0^+$ is the **flow** if Kirchhoff law
$$\sum_{e \in \delta^-(v)} f(e) = \sum_{e \in \delta^+(v)} f(e)$$
is valid for every node except $s$ and $t$. Also **feasible flow** must satisfy $f(e) \in \langle l(e), u(e) \rangle$. There might be no feasible flow when $l(e) > 0$.

Given a network $(G, l, u, s, t)$. The goal is to find the **feasible flow $f$** from the source to the sink that maximizes
$$\sum_{e \in \delta^+(s)} f(e) - \sum_{e \in \delta^-(s)} f(e).$$

## Ford-Fulkerson Algorithm

The algorithm is based on **incremental augmentation** of the flow along the **path* from source $s$ to sink $t$ while maintaining the flow's feasibility. The path from source $s$ to sink $t$ **does not respect the orientation of arcs**.

An augmenting path for flow $f$ is a path from $s$ to $t$ with

* $f(e) < u(e)$ if $e$ is a forward arc $\rightarrow$ the flow can be increased
* $f(e) > l(e)$ if $e$ is a backward ard $\rightarrow$ the flow can be decreased

Capacity $\gamma$ of the augmenting path is the biggest possible increase of the flow on the augmenting path.

### Algorithm

**Input:** Network $(G, l, u, s, t)$ \\
**Output:** Maximum feasible flow $f$ from $s$ to $t$

1. Find the feasible flow $f(e)$ for all $e \in E(G)$.
2. Find an augmenting path $P$. If non exists then stop.
3. Compute $\gamma$, the capacity of an augmenting path $P$. Augment the flow from $s$ to $t$ and go to 2.

Increase flow by $\gamma$ on forward arcs and decrease flow by $\gamma$ on backward arcs. This preserves feasibility of the flow and Kirchhof's law moreover the flow is augmented by $\gamma$.

The flow from $s$ to $t$ is the **maximum** iff there is no augmenting path.

### Finding the Augmenting path

1. Label $m_s = \text{TRUE}, m_v = \text{FALSE}, \forall v \in V(G) \setminus s$.
2. If there exists $e = (v_i, v_j) \in E(G)$ that satisfies $m_i = \text{TRUE}, m_j = \text{FALSE}$ and $f(e) < u(e)$, then $m_j = \text{TRUE}$.
3. If there exists $e = (v_i, v_j) \in E(G)$ that satisfies $m_i = \text{FALSE}, m_j = \text{TRUE}$ and $f(e) > l(e)$, then $m_i = \text{TRUE}$.
4. If $t$ is reached, then the search stops as we have found the augmenting path $P$. If it is not possible to mark another node, thne $P$ does not exists. In other cases go to step 2.

## Minimum Cut Problem

The cut in $G$ is an edge set $\delta(A)$ with $s \in A$ and $t \in V(G) \setminus A$ (i.e. the cut separates nodes $s$ and $t$). The **minimum cut** is the cut of minimum capacity
$$C(A) = \sum_{e \in \delta^+(A)} u(e) - \sum_{e \in \delta^-(A)} l(e).$$

The value of the maximum flow from $s$ to $t$ is equal to the capacity of the **minimum cut**.

When the labeling procedure of "Finding the Augmenting path" algorithm stops, the minimum cut is given by the labeled vertices.

If the capacities of the network are integers, then **an integer-valued maximum flow exists**.

When choosing the augmenting path, if we always choose the shortest one, time complexity is $\mathcal{O}(m^2n)$.
