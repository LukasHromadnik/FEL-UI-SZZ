# Grid-based and Graph-based Planning

## Grid-based Planning

* A subdivision of $\mathcal{C}$-free into smaller cells.
* Grow obstacles
* Neighbor-relations – 4-neighbors, 8-neighbors

Simple grid-based planning:

1. Initial map with a robot and goal
2. Obstacle growing
3. Wave-front propagation – "flood fill"
4. Find a path using a navigation function
5. Path simplification – the "farthest" cells without collisions are used as "turn" points

## Graph-based Planning

* Dijkstra
* A\star
    * Incremental Heuristic Search – repeated planning of the path from the current state to the goal
    * Real-Time Heuristic Search – repeated planning with limited look-ahead (Real-Time Adaptive A\star)
* Jump Point Search algorithm is based on a maxro operator that identifies and selectively expands only certain nodes (jump points)
* Theta\star is an extension of A\star with \verb|LineOfSight()|
* Lazy Theta\star – reduces the number of line-of-sight checks

## D\star Lite

* It searches from the goal node to the start node, i.e. $g$-values estimate the goal distance
* Incrementally repair solution paths when changes occur
* Maintains two estimates of costs per node
    * $g$ – the objective functino value
    * $rhs$ – one-step lookahead of the objective function value
* Inconsistent nodes $g \ne rhs$ are stored in the priority queue for processing
$$rhs(u) = \begin{cases}
0 & \text{if } u = s_{start} \\
\min_{s' \in Succ(u)} (g(s') + c(s', u)) & \text{otherwise}
\end{cases}$$
* The key / priority of a node $s$ on the open list is the minimum of
$$[\min(g(s), rhs(s)) + h(s_{start}, s), \min(g(s), rhs(s))]$$
