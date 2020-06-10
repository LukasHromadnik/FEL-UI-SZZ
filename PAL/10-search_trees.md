# Search Trees

## Binary Search Tree (BST)

For each node $Y$ holds:

* keys in the left subtree of $Y$ are smaller than the key of $Y$,
* keys in the right subtree of $Y$ are bigger than the key of $Y$.

BST may not be balanced and regular, usually it's not.

Apply the INORDER traversal to obtain sorted list of keys of BST.

### Deleting node with 2 children

* Find the **leftmost** node in the **right** subtree or
* find the **rightmost** node in the **left** subtree

then replace this node with the one that is about to be deleted.

## AVL Tree

AVL tree is a BST with additional properties which keep it acceptably balanced.

There are two integers associated with each node: the depth of the last and the depth of the right subtree of the node. Where the depth of an empty node is $-1$.

**AVL Rule.** The difference of the heights of the left and the right subtree may be only $-1$ or 0 or 1 in each node of the tree.

For \verb|Insert| and \verb|Delete| we may need to perform rotations: L, R, LR and RL.

## Skip List

A *skip list* is an ordered linked list where each node contains a variable number of links, with the $k$-th link in the node implementing singly linked list that skips (forward) the nodes with less than $k$ links.

Each element points to its immediate successor. Some elements also point to one or more elements futher down the list.

On **level $k$** element has $k$ forward pointers. The $j$-th pointer points to the next element in level $j$.

There is a **sentinel** with infinite key value at the tail of the list. The level of the sentinel is the same as the whole list level. The list may be implemented as circular with the header serving as the sentinel.

A skip list element contains: **key**, **value**, **forward[]** (an array of pointers).

A skip list data structure contains also:

* **header**: a node with the initial set of forward pointers,
* **sentinel**: optional last node with $\infty$ value, it is the header in circular list,
* **level**: the current number of levels in the skip list,
* **maxLevel**: the maximum number of levels to which a skip list can grow,
* **update[]**: an auxiliary array with predecessors of an inserted/deleted element (see \verb|Insert| and \verb|Delete| operations).

The level of an element is chosen by **flipping a coin**. Flip a coin until it comes up tails. Count **one plus** the **number of times** the coin came up heads before it comes up tails. This result represents the level of the element.

For more general randomness we can choose a fraction $p$ between 0 and 1. This scheme corresponds to flipping a coin that has $p$ chance of coming up heads.

### \texttt{Search}

Scan through the top list until the current node either contains the search key or it contains a smaller key and a link to a node with a larger key.

### \texttt{Insert}

Find the place for the new element. Compute its level $k$ by flipping a coin. Insert the element into first $k$ lists, starting at the bottom list.

The array *update[]* is an auxiliary array supporting \texttt{Insert} / \texttt{Delete} operations. *update[k]* points to that element in the list whose level $k$ pointer points to the inserted (or deleted element).

### \texttt{Delete}

Deleting in a skip list is like deleting the same value independently from each list in which forward pointers of the deleted element are involved.

### Choosing $p$

One might think that $p$ should be chosen to be $0.5$. If it's true then roughly half our elements will be level 1 nodes, 0.25 will be level 2 nodes, 0.125 will be level 3, and so on. This will give us on average $\log N$ search time and 2 pointers per node on average.

However, empirical tests show that choosing $p$ to be 0.25 results in roughly the same search time but only an average of 1.33 pointers per node, somewhat more variability in the search times.

### Index access

Supplement each forward pointer with its "length" = 1 + number of the list elements it skips. A $k$-th list element can be accessed in expected $\mathcal{O}(\log n)$ time. We need to update the "length" after each \texttt{Insert} or \texttt{Delete} operation.

## B-tree

\input{assets/b-tree.tikz}

ALl paths from the root to the leaves have the same length. B-tree is perfectly balanced.

Nodes have lower and upper bounds on the number of keys they can contain. We express these bounds in terms of fixed integer $t \geq 2$ called the **minimum degree** of the B-tree.

* Every node other than the root must have at least $t - 1$ keys. Every internal node other than the root thus has at least $t$ children. If the tree is non-empty, the root must have at least one key.
* Every node may contain at most $2t - 1$ keys. Therefore an internal node may have at most $2t$ children.

### Update strategies

1. **Multi phase strategy:** "Solve the problem when it appears"  
    First insert or delete the item and only then rearrange the tree if necessary. This may require additional traversing up to the root.
2. **Single phase strategy:** "Avoid the future problems"  
    Travel from the root to the node / key which is to be inserted or deleted and during the travel rearrange the tree to prevent the additional traversing up to the root.

### Insert (multi)

When inserting a node to the leaf which has the maximum number of elements in it:

1. sort keys outside the tree,
2. select median, create a new node, move to it the values bigger than the median there,
3. try to insert the median into the parent node,
4. if the parent node is also full – repeat the process analogously.

### Delete (multi)

The deleted key is substituted by the smallest bigger key like in an usual BST.

When deleting a node leads to insufficient number of elements in a node:

1. merge the keys of the two leaves with the dividing key in the parent into one sorted list,
2. insert the median of the sorted list into the parent and distribute the remaining keys into the left and right children of the median.

The \texttt{Delete} can also leads to a situation where the split is not possible due to insufficient number of elements in both leaves. In that situation merge all elements from leaves with the parent and create a new node for them.

### Insert (single)

When inserting new node split every node that is full on the way to the leaf.

### Delete (single)

1. If the key $k$ is in node $X$ and $X$ is a leaf, delete the key $k$ from $X$.
2. If the key $k$ is in node $X$ and $X$ is an inteernal node, do the following:
    1. If the child $Y$ that precedes $k$ in node $X$ has at least $t$ keys, then find the predecessor $k_p$ of $k$ in the subtree rooted at $Y$. Recursively delete $k_p$ and replace $k$ by $k_p$ in $X$. \label{enum:delete-single:2a}
    2. If $Y$ has fewer than $t$ keys, then, symmetrically, examine the child $Z$ that follows $k$ in node $X$ and continue as \ref{enum:delete-single:2a}
    3. Other wise, i.e. booth $Y$ and $Z$ have only $t - 1$ keys, merge $k$ and all of $Z$ into $Y$, so that $X$ loses both $k$ and the pointer to $Z$, and $Y$ now contains $2t - 1$ keys. Then free $Z$ and recursively delete $k$ from $Y$.
3. If the key $k$ is not present in internal node $X$, determine the child $X.c$ of the appropriate subtree that must contain $k$, if $k$ is in the tree at all. if $X.c$ has only $t - 1$ keys, execute step \ref{enum:delete-single:3a} or \ref{enum:delete-single:3b} as necessary to guarantee that we descent too a node containing at least $t$ keys. Then finish by recursing on the appropriate child of $X$.
    1. If $X.c$ and both of $X.c$'s immediate siblings have $t - 1$ keys, merge $X.c$ with one sibling, which involves moving a key from $X$ down into the new merged node to become the median key for that node. \label{enum:delete-single:3a}
    2. If $X.c$ has only $t - 1$ keys but has an immediate sibling with at least $t$ keys, give $X.c$ an extra key by moving a key from $X$ down to $X.c$, moving a key from $X.c$'s immediate left or right sibling up into $X$, and moving the appropriate child pointer from the sibling into $X.c$. \label{enum:delete-single:3b}

## B+ tree

B+ tree is analogous to B-tree. The differences are

* records (or pointers to actual records) are stored only in the leaf nodes,
* internal nodes store only search key values which are used only as routers to guide the search.

The leaf nodes of a B+ tree are linked together to form a linked list. This is done so that the records can be retrived sequentially without accessing the B+ tree index. This also supports fast processing of range-search queries.
