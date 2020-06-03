## Splay tree

It's a binary search tree with no additional tree shape description.

Each node access or insertion *splays* that node to the root.

Rotations are:

* zig,
* zig-zig and
* zig-zag.

All operations run times are $\mathcal{O}(n)$. Amortized run times of all operations are $\mathcal{O}(\log n)$.

### \texttt{Delete(k)}

1. Find $k$  
    This splays $k$ to the roott
2. Remove the root  
    Splits the tree into $L$ and $R$ subtree of the root
3. $y$ = Find max in $L$ subtree  
    This splays $y$ to the root of $L$ subtree
4. $y.right$ = $R$ subtree

## 2-3-4 tree

A 2-3-4 search tree is structurally a B-tree of min degree 2 and max degree 4. A node is a 2-node or a 3-node or a 4-node.

All leaves are at the same distance from the root, the tree is **perfectly balanced**.

### Splitting strategy

Additionoal insert rule: In our way doown the tree, whenever we reach a 4-node (including a leaf), we split it into two 2-nodes, and move thee middle element up to the parent node.

## \textcolor{red}{Red}-Black tree

Approximately balanced BST

$$h_{RB} \leq 2 \cdot h_{BST}$$

A binary search tree is a \textcolor{red}{red}-black tree if

1. every node is either \textcolor{red}{red} or black,
2. every leaf (nil) is black,
3. if a node is \textcolor{red}{red}, then both its children are black,
4. every simple path from a node to a descendant leaf contains the same number of black nodes,
5. root is black.

**Black height.** $bh(x)$ of a node $x$ is the number of black nodes on any path from $x$ to a leaf, not counting $x$.

**Height.** $h(x) of a RB-tree rooted in node $x$ is at maximum twice of the optimal height of a balanced tree.

### Insert

1. Color the new node $x$ \textcolor{red}{red}.
2. Insert it as in the standard BST.
3. If parent $p$ is black, stop. Tree is  a \textcolor{red}{Red}-Black tree.
4. If parent $p$ is \textcolor{red}{red}

\input{assets/red-black.tikz}

### Delete

* $\Theta(\log n)$, at most three rotations are done

Node $y$ to be physically deleted will have at most one child $x$!

If we delete a \textcolor{red}{red} node, tree is still a \textcolor{red}{Red}-Black tree, stop.

Assume we delete a black node. Let $x$ be the child of the deleted (black) node $y$. If $x$ is \textcolor{red}{red}, color it black and stop.

## Comparison

* For random sequences use *unsorted tree*, no waste time for rebalancing
* For mostly random oordering with occasioonal runs of sorted order use *\textcolor{red}{red}-black trees*
* For insertions often in a sorted order and later accesses tend to be random use *AVL trees*
* For insertions often in a sorted order and later accesses are sequential or clustered use *splay trees*
