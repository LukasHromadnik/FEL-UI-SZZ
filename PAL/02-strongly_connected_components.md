# Strongly connected components

A directed graph $G = (V, E)$ is called **strongly connected** if there is a path in each direction between every couple of vertices in the graph.

The **strongly connected component** of a directed graph $G$ are its maximal strongly connected subgraphs.

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
\State Revese the directioons of all arcs to obtain the transpose graph
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

The Kosaraju-Sharir algorithm performs two complete traversals of the graph. If the graph is represented as an *adjacency list* then the algorithm runs in $\Theta(|V| + |E|)$ time. If the graph is represented as an *adjacency matrix* then the algorithm runs in $\mathcal{O}(|V|^2)$ time.

## Tarjan's algorithm

The Tarjan's algorithm performs only one complete traversal of the graph. If the graph is represented as an *adjacency list* then the algorithm runs in $\Theta(|V| + |E|)$ time. If the graph is represented as an *adjacency matrix* then the algorithm runs in $\mathcal{O}(|V|^2)$ time.

In absolute number the Tarjan's algorithm runs faster then Kosaraju-Sharir algorithm.

## Euler Trail problem

Does a graph $G$ contain a trail (trail is similar to path but vertices can repeat and edges cannot repeat) that visits every edge exactly once?

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

* adjacency list: $\Theta(|V| + |E|)$
* adjacency matrix: $\mathcal{O}(|V|^2)$
