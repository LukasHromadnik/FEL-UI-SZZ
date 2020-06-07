# Strongly connected components

A directed graph $G = (V, E)$ is called **strongly connected** if there is a path in each direction between every couple of vertices in the graph.

The **strongly connected components** of a directed graph $G$ are its maximal strongly connected subgraphs.

## Kosaraju-Sharir algorithm

\begin{algorithm}[!htp]
\caption{Kosaraju-Sharir algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} Graph $G = (V, E)$ \\
\hspace*{\algorithmicindent} \textbf{Output:} Set of strongly connected components (sets of vertices)
\begin{algorithmic}[1]
\State $S: \mathrm{Stack} \gets \emptyset$
\While{$size(S) \ne |V|$}
    \State Choose an arbitrary vertex $v \notin S$
    \State $\text{DFS-Walk'}(v)$ \Comment After execution, $v$ is automatically pushed onto $S$
\EndWhile
\State Revese the directions of all arcs to obtain the transpose graph
\While{$S \ne \emptyset$}
    \State $v = S.pop()$
    \If{$v = \text{UNVISITED}$}
        \State DFS-Walk($v$)
    \EndIf
    \State The set of visited vertices will give the strongly connected component containing $v$
\EndWhile
\end{algorithmic}
\end{algorithm}

\begin{algorithm}[!htp]
\begin{algorithmic}
\Procedure{DFS-Walk}{Vertex $u$}
    \State $state[u] \gets \mathrm{OPEN}$
    \State $d[u] \gets time\mathrm{++}$
    \ForAll{$v \in successor(u)$}
        \If{$state[v] = \mathrm{UNVISITED}$}
            \State $p[v] = u$
            \State $\text{DFS-Walk}(v)$
        \EndIf
    \EndFor
    \State $state[u] = \mathrm{CLOSED}$
    \State $f[u] = \mathrm{++}time$
\EndProcedure
\end{algorithmic}
\end{algorithm}

\begin{algorithm}[!htp]
\begin{algorithmic}
\Procedure{DFS-Walk'}{Vertex $u$}
    \State $state[u] \gets \mathrm{OPEN}$
    \State $d[u] \gets time\mathrm{++}$
    \ForAll{$v \in successor(u)$}
        \If{$state[v] = \mathrm{UNVISITED}$}
            \State $p[v] = u$
            \State $\text{DFS-Walk'}(v)$
        \EndIf
    \EndFor
    \State $state[u] = \mathrm{CLOSED}$
    \State $f[u] = \mathrm{++}time$
    \State $S.push(u)$
\EndProcedure
\end{algorithmic}
\end{algorithm}

The Kosaraju-Sharir algorithm performs two complete traversals of the graph:

* adjacency list: $\Theta(|V| + |E|)$,
* adjacency matrix: $\mathcal{O}(|V|^2)$.

## Tarjan's algorithm

Tarjan's algorithm can determine strongly connected components with only one full DFS traversal of the graph. Each node has an \verb|index| and a \verb|lowlink|. \verb|index| can be seen as a time when the node was visited. \verb|lowlink| is an index to lowest element in the component. This value is updated during the search and it determines the node in a given component.

In each step the algorithm visits a node. This node is push onto the stack, its \verb|index| and \verb|lowlink| are set to the same value. Then we continue with its successors. If one of its successors is on the stack, we update the \verb|lowlink| value to the value of this successor.

The node is marked as visited when all of its successors were visited or when there is no outgoing edge from it. A successor that was already visited and it's not on the stack is not considered in later stages of the algorithm. When closing a node its \verb|lowlink| value is set to the minimum of the current value and \verb|lowlink|s of all successors.

When a node has \verb|index| = \verb|lowlink|, it's the root of the strongly connected component and we can remove all nodes from this component from the stack.

The Tarjan's algorithm performs only one complete traversal of the graph:

* adjacency list: $\Theta(|V| + |E|)$,
* adjacency matrix: $\mathcal{O}(|V|^2)$.

Within absolute numbers the Tarjan's algorithm runs faster then Kosaraju-Sharir algorithm.

## Euler Trail problem

Does a graph $G$ contain a trail (nodes can repeat, edges cannot) that visits every edge exactly once?

A graph $G$ has an Euler trail iff it is connected and has 0 or 2 vertices of odd degree.

\begin{algorithm}[!htp]
\caption{Euler Trail}
\hspace*{\algorithmicindent} \textbf{Input:} Graph $G = (V, E)$ \\
\hspace*{\algorithmicindent} \textbf{Output:} Trail (as a stack with edges)
\begin{algorithmic}
\Procedure{Euler-Trail}{vertex $v$}
\ForAll{$u \in successor(v)$}
    \State Remove edge$(v, u)$ from graph
    \State Euler-Trail($u$)
    \State Push(edge($v, u$))
\EndFor
\EndProcedure
\end{algorithmic}
\end{algorithm}

The Euler trail algorithm performs only one complete traversal of the graph:

* adjacency list: $\Theta(|V| + |E|)$,
* adjacency matrix: $\mathcal{O}(|V|^2)$.
