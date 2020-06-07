# Asymptotic notation

* $f(n) \in \mathcal{O}(g(n))$  
    The value of the function $f$ is on or below the value of the function $g$ within a constant factor
    $$(\exists c > 0) (\exists n_0) (\forall n > n_0): \left| f(n) \right| \leq \left| c \cdot g(n) \right|$$
* $f(n) \in \Omega(g(n))$  
    The value of the function $f$ is on or above the value of the function $g$ within a constant factor
    $$(\exists c > 0) (\exists n_0) (\forall n > n_0): | c \cdot g(n) | \leq | f(n) |$$
* $f(n) \in \Theta(g(n))$  
    The value of the function $f$ is equal to the value of the function $g$ within a constant factor
    $$(\exists c_1, c_2 > 0) (\exists n_0) (\forall n > n_0): |c_1 \cdot g(n)| \leq |f(n)| \leq |c_2 \cdot g(n)|$$

# Graphs

A graph $G$ is an ordered pair of a set of vertices $V$ (nodes) and a set of edges $E$ (arcs) $G = (V, E)$.

**Incidence.** If two nodes $x, y$ are linked by the edge $e$, nodes $x, y$ are said to be *incident* to the edge $e$ or the edge $e$ is *incident* to nodes $x, y$.

**Node degree.** It's a function that returns a number of edges incident to a given node.
$$\deg(u) = \left|\{e \in E \ | \ u \in e \}\right|$$
For directed graphs
\begin{align*}
\deg^+(u) = |\{e \in E \ | \ (\exists v \in V): e = (v, u) \}| \\
\deg^-(u) = |\{e \in E \ | \ (\exists v \in V): e = (u, v) \}|
\end{align*}

**Handshaking lemma.**
$$\sum_{v \in V} \deg(v) = 2|E|$$
and for directed graphs
$$\sum_{v \in V} \left(\deg^+(v) + \deg^-(v)\right) = 2|E|$$

**Path.** A *path* is a sequence of vertices and edges $(v_0, e_1, v_1, \dots, e_t, v_t)$, where all vertices $v_0, \dots, v_t$ **differ from each other** and for every $i = 1, 2, \dots, t, e_i = \{ v_{i-1}, v_i\} \in E(G)$. Edges are traversed in a forward direction.

**Circuit.** A *circuit* is a closed path, i.e. a sequence $(v_0, e_1, v_1, \dots, e_t, v_t = v_0)$.

**Cycle.** A *cycle* is a closed simple chain. Edges can be traveresed in both directions.

**Connectivity.** Graph $G$ is *connected* if for every pair of vertices $x$ and $y$ in $G$ there is a path from $x$ to $y$.

**Tree.** The following definitions of a *tree* (graph $G$) are equivalent:

* $G$ is a connected graph without cycles.
* $G$ is such a graph so that a cycle occurs if an arbitrary new edge is added.
* $G$ is such a connected graph so that it becomes disconnected if any edge is removed.
* $G$ is a connected graph with $|V| - 1$ edges.
* $G$ is a graph in which every two vertices are connected by just one path.

**Leaf**.

* A *leaf* is a node of degree 1 in undirected graphs.
* A *leaf* is a node with no outgoing edge in directed graphs.

**Root.** A *root* is a node with no incoming edges in directed graphs.

**Adjacency matrix.** Let $G = (V, E)$ be a graph with $n$ vertices. Let's label vertices $v_1, \dots, v_n$ (in some order). *Adjacency matrix* of graph $G$ is a square matrix
$$A_G = (a_{i,j})_{i, j=1}^n$$
defined as follows
$$a_{i,j} =
\begin{cases}
1 & \text{for } \{v_i, v_j\} \in E \\
0 & \text{otherwise}
\end{cases}
$$

**Laplacian matrix.** Let $G = (V, E)$ be a graph with $n$ vertices. Let's label vertices $v_1, \dots, v_n$ (in an arbitrary order). *Laplacian matrix* of graph $G$ is a square matrix
$$L_G = (l_{i,j})^n_{i, j = 1}$$
defined as follows
$$l_{i,j} =
\begin{cases}
\deg(v_i) & \text{for } i = j \\
-1 & \text{for } \{v_i, v_j \} \in E \\
0 & \text{otherwise}
\end{cases}
$$

**Distance matrix.** Let $G = (V, E)$ is a graph with $n$ vertices and a weight function $w$. Let's label vertices $v_1, \dots, v_n$ (in an arbitrary order). *Distance matrix* of $G$ is a square matrix
$$A_G = (a_{i,j})_{i,j = 1}^n$$
defined by the formula
$$a_{i,j} =
\begin{cases}
w(\{v_i, v_j\}) & \text{for } \{v_i, v_j\} \in E \\
0 & \text{otherwise}
\end{cases}
$$

**Directed Acyclic Graph (DAG).** *Directed acyclic graph* is a directed graph without cycles.

**Multigraph.** It's a graph where multiple edges and/or edges incident to a single node are allowed.

**Incidence matrix.** Let $G = (V, E)$ be a graph where $|V| = n$ and $|E| = m$. Let's label vertices $v_1, \dots, v_n$ (in some arbitrary order) and edges $e_1, \dots, e_m$ (in some arbitrary order). *Incidence matrix* of graph $G$ is a matrix of type $\{-1, 0, 1\}^{n\times m}$ defined by the formula
$$I_{i,j} =
\begin{cases}
-1 & \text{for } e_j = (v_i, *) \\
+1 & \text{for } e_j = (*, v_i) \\
0 & \text{otherwise}
\end{cases}
$$

In other words, every edge has $-1$ at the source vertex and $+1$ at the target vertex. There is $+1$ at both vertices for undirected graphs.

**Adjacency list.** In an *adjacency list* representation we keep for each vertex in the graph a list of all other vertices which it has an edge to (a list of neighbours).

## Comparison of graph representations

\begin{tabular}{|p{3cm}|c|c|c|c|}
\hline
& Adjacency matrix & Laplacian matrix & Adjacency list & Incidence matrix \\
\hline
Storage       & \multicolumn{2}{c|}{$V \cdot V \in \mathcal{O}(V^2)$} & $\mathcal{O}(|V| + |E|)$      & $|V| \cdot |E| \in \mathcal{O}(|V| \cdot |E|)$ \\ \hline
Add vertex    & \multicolumn{2}{c|}{$\mathcal{O}(|V|^2)$}             & $\mathcal{O}(|V|)$            & $\mathcal{O}(|V| \cdot |E|)$ \\ \hline
Add edge      & \multicolumn{3}{c|}{$\mathcal{O}(1)$}                                                 & $\mathcal{O}(|V| \cdot |E|)$ \\ \hline
Remove vertex & \multicolumn{2}{c|}{$\mathcal{O}(|V|^2)$}               & $\mathcal{O}(|E|)$            & $\mathcal{O}(|V| \cdot |E|)$ \\ \hline
Remove edge   & \multicolumn{2}{c|}{$\mathcal{O}(1)$}                 & $\mathcal{O}(|V|)$            & $\mathcal{O}(|V| \cdot |E|)$ \\ \hline
Query: are vertices $u, v$ adjacent? & \multicolumn{2}{c|}{$\mathcal{O}(1)$}                   & $\deg(v) \in \mathcal{O}(|V|)$ & $\mathcal{O}(|E|)$ \\ \hline
Query: get node degree of vertex $v$ & $|V| \in \mathcal{O}(|V|)$ & $\mathcal{O}(1)$        & $\deg(v) \in \mathcal{O}(|V|)$ & $|E| \in \mathcal{O}(|E|)$ \\ \hline
\end{tabular}

*Adjacency matrix* and *Laplacian matrix* are slow to add or remove vertices because matrix must be resized / copied. *Incidence matrix* is also slow to add or remove edges for the same reason. When removing edges or vertices from the *adjacency list*, we need to find all vertices or edges.

\clearpage

## Depth First Search (DFS)

\begin{algorithm}[!htp]
\caption{Depth First Search (DFS)}
\begin{algorithmic}[1]
\State $\mathrm{to\_visit}: \mathbf{Stack} \gets \emptyset$
\State $\mathrm{visited} \gets \emptyset$
\State $\mathrm{to\_visit}.push(\mathrm{start\_vertex})$
\While{$size(\mathrm{to\_visit}) \ne 0$}
    \State $v \gets \mathrm{to\_visit}.pop()$
    \If{$v \notin \mathrm{visited}$}
        \State $\mathrm{visited}.add(v)$
        \ForAll{$x \in neighbors(v)$}
            \State $\mathrm{to\_visit}.push(x)$
        \EndFor
    \EndIf
\EndWhile
\end{algorithmic}
\end{algorithm}

## Breadth First Search (BFS)

Same as DFS. Only difference is that it uses $\mathbf{Queue}$ instead of $\mathbf{Stack}$.

## Advanced graphs

**Subgraph.** A graph $H$ is a *subgraph* of the graph $G$, if the following two inclusions are satisfied:
\begin{align*}
V(H) &\subseteq V(G) \\
E(H) &\subseteq E(G) \cap \binom{V(H)}{2}
\end{align*}

**Topological ordering.** Let $G$ be a DAG. Let's define a binary relation $R$ of a *topological ordering* over vertices of the graph $G$ such as $R(x, y)$ is valid iff there exists a directed path from $x$ to $y$, that is whenever $y$ is reachable from $x$.

**Connected component.** A *connected component* of the graph $G = (V, E)$ with regard to the vertex $v$ is a set
$$C(v) = \{ u \in V \ | \ \text{there exists a path in } G \text{ from } u \text{ to } v \}.$$

**Spanning tree.** Let $G = (V, E)$ be a graph. A *spanning tree* of the graph $G$ is such a subgraph $H$ of the graph $G$ that $V(G) = V(H)$ and $H$ is a tree.

**Minimum spanning tree.** Let $G = (V, E)$ be a graph and $w: E \rightarrow \mathbb{R}$ be its weight function. A *minimum spanning tree* of the graph $G$ is such a tree $K = (V, E_K)$ of graph $G$ that
$$ \argmin_K \sum_{e \in E_K} w(e).$$

$$\exists U \subset V \ | \ F = \{\{u, v\} \in E \ | \ u \in U, v \notin U \}.$$
**Cut.** A *cut* of graph $G = (V, E)$ is a subset of edges $F \subseteq E$ such that

Let $G$ be a graph, $w$ be its injective real-valued weight function, $F$ be a cut of graph $G$ and $f$ be its lightest edge of cut $F$ (crossing), then every minimum spanning tree $K$ of graph $G$ contains $f \in E(K)$.

### Jarník (Prim)'s algorithm

\begin{algorithm}[!htp]
\caption{Jarník (Prim)'s algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} A graph $G$ with a weight function $w: E(G) \rightarrow \mathbb{R}$. \\
\hspace*{\algorithmicindent} \textbf{Output:} A minimum spanning tree $K$.
\begin{algorithmic}[1]
\State Select an arbitrary vertex $v_0 \in V(G)$
\State $K \gets (\{v_0\}, \emptyset)$
\While{$|V(K)| \ne |V(G)|$}
    \State Select edge $\{u, v\} \in E(G)$ where $u \in V(K)$ and $v \notin V(K)$ so that $w(\{u, v\})$ is minimum
    \State $K \gets K + \text{ edge } \{u, v\}$
\EndWhile
\end{algorithmic}
\end{algorithm}

Jarník's algorithm stops after maximum of $|V(G)|$ steps and the result is a minimum spanning tree of the graph $G$.

* The edges among vertices of the tree $K$ and the rest of the graph $G$ determines a cut. The algorithm always adds the lightest edge of this cut to $K$. Following the previous lemma, all edges of $K$ must belong to every minimum spanning tree. As $K$ is a tree, then it must be a minimum spanning tree.

### Borůvka's algorithm

\begin{algorithm}[!htp]
\caption{Borůvka's algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} A graph $G$ with a weight function $w: E(G) \rightarrow \mathbb{R}$ where all weights are different. \\
\hspace*{\algorithmicindent} \textbf{Output:} A minimum spanning tree $K$.
\begin{algorithmic}[1]
\State $K \gets (V(G), \emptyset)$
\While{$K$ has at least two connected components}
    \ForAll{components $T_i$ of graph $K$}
        \State Select the light incident edge $t_i$ \Comment connects two components and has the lowest weight
        \State Add $t_i$ to $K$
    \EndFor
\EndWhile
\end{algorithmic}
\end{algorithm}

\clearpage

### Kruskal's (greedy) algorithm

\begin{algorithm}[!htp]
\caption{Kruskal's algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} A graph $G$ with a weight function $w: E(G) \rightarrow \mathbb{R}$ and $m$ edges. \\
\hspace*{\algorithmicindent} \textbf{Output:} A minimum spanning tree $K$.
\begin{algorithmic}[1]
\State Sort all edges $e_1, \dots, e_m$ from $E(G)$ so that $w(e_1) \leq \cdots \leq w(e_m)$
\State $K \gets (V(G), \emptyset)$
\For{$i \in 1, \dots, m$}
    \If{$K + edge\{u, v\}$ is an acylic graph}
        \State $K \gets K + edge \{u, v\}$
    \EndIf
\EndFor
\end{algorithmic}
\end{algorithm}

We can stop the main loop when we successfully add $|V(G) - 1|$ edges to $K$. Then $K$ has already reached a spanning tree.

#### Union-find problem

Question: "Do vertices $u$ and $v$ belong to the same connected component of $G$?"

* Let's assume all vertices are assigned with a number from 1 to $n$. Let's use an array $R[1, \dots, n]$, where $R(i)$ represents number of one node from the component.
* Operation FIND($v$) just returns the value of $R[v]$.
    * $\mathcal{O}(1)$
* To perform UNION($u, v$) we have to find representatives $R(u)$ and $R(v)$. If they are different then we process all items of the array $R$. Any value of $R(u)$ is rewritten to $R(v)$.
    * $\mathcal{O}(n)$
* We can improve the implementation by using a directed tree as a component representation, where every node has a pointer to its father.
