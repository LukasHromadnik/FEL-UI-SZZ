# K-d tree

K-d tree is a binary search tree representing a rectangular area in $D$-dimensinoal space. The area is divided (and recursively subdivided) into **rectangular cells**. Denote dimensions naturally by their indexes $0, 1, 2, \dots, D-1$. Denote by $R$  the root of a tree or a subtree.

A rectangular $D$-dimensional cell $C(R)$ (hyperrectangle) is associated with $R$. Let $R$ coordinates be $R[0], R[2], \dots, R[D - 1]$ and let $h$ be its depth in the tree. The cell $C(R)$ is splitted into two subcells by such **hyperplane** of $\dim D - 1$, for whose all points $y$ it holds:
$$y[h \% D] = R[h \% D].$$

All nodes in the left subtree of $R$ are characterised by their $(h \% D)$-th coorindate being **less than** $R[h \% D]$.

All nodes in the right subtree of $R$ are characterised by their $(h \% D)$-th coordinate being **greater than or equal to** $R[h \% D]$.

Let us call the value $h \% D$ **splitting / cutting dimension** of a node in depth $h$.

## \texttt{Find}

Operation \verb|Find| is analogous to \verb|Find| in 1D tree. During the search we alternate between all coordinates on each level.

## \texttt{Insert}

Insert is very similar to \verb|Find|. Only difference is that we're looking for a place where to add the new node.

## \method{FindMin}{dim = k}

Searching for a key whose $k$-th coordinate is minimal of all keys in the tree.

The k-d tree offers no simple method of keeping track of the keys with minimum coordinates in any dimension because \texttt{Delete} operation may often significantly change the structure of the tree.

\verb|FindMin| is the most costly operation with complexity $\mathcal{O}(n^{1 - \frac{1}{d}})$ in a k-d tree with $n$ nodes and dimension $d$.

## \texttt{Delete}

Only leaves are physically deleted.

Deleting an inner node $X$ is done by substituting its key values by key values of another suitable node $Y$ deeper in the tree. If $Y$ is a leaf physically delete $Y$ otherwise set $X = Y$ and continue recursively.

Denote cutting dimension of $X$ by $cd$.

If the right subtree $X.R$ of $X$ is unempty use the operation \verb|FindMin| to find node $Y$ in $X.R$ whose coordinate in $cd$ is minimal.

If the right subtree $X.R$ of $X$ is empty use operation \verb|FindMin| to find in the left subtree such node $Y$ whose coordinate in $cd$ is minimal. Subtitute key values of $X$ by those of $Y$. Move $X.L$ to the (empty) right subtree of updated $X$ (swap $X.R$ and $X.L$). Now $X$ has unempty right subtree, continue the process with the previous case.

## Nearest Neighbor

Search starts in the root and run recursively in $L$ and $R$ subtree of the current node.

Register and update **partial results**: $\{point, distance\}$

**Pruning.** During the search dismiss cells (and associated subtrees) which are too far from a query.

During the search it uses heuristic based on the distance of the rectangle that is represented by the left and right subtree of a given node.
