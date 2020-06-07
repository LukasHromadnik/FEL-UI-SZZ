# Heap

A *heap* is a specialized data structure (usually tree-based) that satisfies the **heap property**: if $B$ is a child node of $A$ then $key(B) \geq key(A)$.

Heap is one the most efficient implementation of an abstract data type called a priority queue.

The operations commonly performed with a heap are:

------------------------------------------------------------------------------
Operation                  Description
-------------------------- ---------------------------------------------------
\method{Insert}{x}         Adds a new key $x$ to the heap

\verb|AccessMin|           Find and returns the minimum item of the heap

\verb|DeleteMin|           Removes the minimum node of the heap
                           (usually the minimum node is the root of the heap)

\method{DecreaseKey}{x, d} Decreases $x$ key within the heap by $d$

\method{Merge}{H_1, H_2}   Joins two heaps $H_1$ and $H_2$ to form a valid
                           new heap containing all the elements of both

\method{Delete}{x}         Removes a key $x$ of the heap

-------------------------- ---------------------------------------------------

## Binary Heap

A *binary heap* is a binary tree with two additional constraints:

1. It's a complete binary tree except the last level; that is, all levels of the tree except possible the last one (deepest) are fully filled. If the last level of the tree is not complete, the nodes of that level are filled from the left to the right.
2. Each node is less than or equal to each of its children according to a comparison predicate $\leq$ over keys.

\input{assets/binary-heap.tikz}

### \method{Insert}{x}

When inserting node the heap we add the node the end of the heap and then swap its location with parents until the heap property is met.

### \texttt{DeleteMin}

Deleting the min (or the root) is simple. At first set the value of the root to $\infty$ and then switch its position with the last node in the heap. Then we need to make sure that the heap property is valid for the switched node. So we check it, if it's not valid then we switch the node with one of its descendants and repeat. At last delete the last node from the heap.

### \method{DecreaseKey}{x, d}

At first decrease the key of $x$ by $d$ and then apply the similar algorithm as in \method{Insert}{x} case.

### \method{Delete}{\&x}

Deleting node at given position is very similar to deleting the min node. Switch the node $x$ with the last node in the heap and then verify the heap property by checking all its descendants and its parent. Continue until the property is met.

### Data representation

We can represent heap with bidirectional tree structure with pointers. But more convenient way is to use array in which the root is placed at the index 0.

Then for any given node $n$ we can get

* parent as $n / 2 \ (n >> 1)$,
* 1st child as $2 * n \ (n << 1)$ and
* 2nd child as $2 * n + 1 \ (n << 1 + 1)$.

### \method{BuildHeap}{A}

Building the heap from the array $A$ starts at the last subtree. Compare parent and its children if the heap property is valid. If not switch parent with the biggest child. Continue to the next subtree and check again. With that at the end we have a valid heap stored in an array.

### Time complexity

Operation                  Time complexity
-----                      -----
\method{Insert}{x}         $\mathcal{O}(\log n)$
\method{Delete}{x}         $\mathcal{O}(\log n)$
\verb|AccessMin|           $\mathcal{O}(1)$
\verb|DeleteMin|           $\mathcal{O}(\log n)$
\method{DecreaseKey}{x, d} $\mathcal{O}(\log n)$
\verb|BuildHeap|           $\mathcal{O}(n)$
\method{Merge}{H_1, H_2}   $\mathcal{O}(n)$ by building a new heap

## $d$-ary Heap

$d$-ary heap is a generalization of the binary heap. Operations for $d$-ary heap are analogical to the binary heap and their time complexity are the same.

$d$-ary heap typically runs much faster than a binary heap for heap sizes that exceed the size of the computer's cache memory.

## Binomial Heap

*Binomial heap* is a collection of binomial trees of degrees $i = 0, \dots, \lfloor \log n \rfloor$. There can only be either one or zero binomial trees for each degree. Each binomial tree in a heap obeys the heap property.

For a binomial tree $B_k$ (of degree $k$) holds

* it satisfies the heap property,
* the height of the tree is $k$,
* its root has $k$ children,
* there are $2^k$ nodes,
* there are exactly $\binom{k}{i}$ nodes at depth $i$ for $i = 0, 1, \dots, k$.

Alternative definition of a binomial tree is that it consists of two binomial trees $B_{k - 1}$ that are linked together: the root of one which is greater than the other, is the leftmost child of the root of the other.

### Representation

Because no operation requires random access to the root nodes of the binomial trees, the roots of the binomial trees can be stored in a linked list, ordered by increasing degree of the tree. But of course, binomial trees can be stored in array as well. We need to have a constant time complexity for accessing the minimum, for that a MIN pointer is created.

### \method{Insert}{x}

1. Create a new heap containing only this element.
2. Merge it with the original heap.

### \method{Merge}{H_1, H_2}

Due to the structure of binomial trees, they can be merged trivially. As their node is the smallest element within the tree, by comparing the two keys, the smaller of them is the minimum key and becomes the new root node. Then the other tree becomes a subtree of the combined tree. In the end we update the MIN pointer.

### \texttt{DeleteMin}

This operation removes only the root of the tree with the minimum. All children subtrees of the root are then merged to the heap.

### \method{Delete}{x}

1. Decrease $x$ key to $-\infty$ by \verb|DecreaseKey|
2. Delete the minimum in the heap by \verb|DeleteMin|

### Time complexity

Operation                  Time complexity
-----                      -----
\method{Merge}{H_1, H_2}   $\mathcal{O}(\log n)$
\method{Insert}{x}         $\mathcal{O}(\log n)$, amortized complexity is $\mathcal{O}(1)$
\verb|AccessMin|           $\mathcal{O}(1)$
\verb|DeleteMin|           $\mathcal{O}(\log n)$
\method{DecreaseKey}{x, d} $\mathcal{O}(\log n)$
\method{Delete}{x}         $\mathcal{O}(\log n)$

## Fibonacci Heap

Fibonacci Heap is in fact a loosely based binomial heap. It has more relaxed structure allowing for improved asymptotic time bounds.

Fibonacci heaps support the same operations but have the advantage that operations that do not involve deleting an element (\verb|AccessMin|, \verb|Merge| and \verb|DecreaseKey|) run in $\mathcal{O}(1)$ amortized time.

Operations \verb|Delete| and \verb|DeleteMin| have $\mathcal{O}(\log n)$ amortized time complexity.

The usage of Fibonacci heaps is not suitable for real-time system, because some operations can have a linear time complexity in the worst case. From a practical point of view the constant factors and programming complexity of Fibonacci heaps make them less desirable than ordinary binary (or $d$-ary) heaps for most applications.

Unlike trees within binomial heaps, trees within Fibonacci heaps are rooted but unordered. The trees don't have a prescribed shape and in the extreme case the heap can have every element in a separate tree.

This flexibility allows some operations to be executed "lazily", postponing the work for later. For example merging heaps is done simply by cooncatenating the two lists of trees.

In each level of the heap / tree all nodes are in a circular doubly linked list.

### \texttt{DeleteMin}

Deleting the minimum is simple. Just cut off the root node of the tree and all its children merge to the heap. At the end we consolidate the heap.

### \texttt{Consolidate}

During consolidation we iterate over all trees in the heap until there are no trees with the same level. When we find during the iteration two trees with the same level we merge them to create a Binomial tree with the higher level. This can be done be storing a reference to the tree in an array where index represents the level of the tree.

Time complexity is $\mathcal{O}(n)$, amortized complexity is $\mathcal{O}(\log n)$

## Comparison of time complexity
                  Binary heap      $d$-ary heap     Binomial heap                                Fibonacci heap
----------------- ---------------- ---------------- -------------------------------------------- -------------------------------------------
\verb|AccessMin|  $\Theta(1)$      $\Theta(1)$      $\Theta(1)$                                  $\Theta(1)$
\verb|DeleteMin|  $\Theta(\log n)$ $\Theta(\log n)$ $\Theta(\log n)$                             $\mathcal{O}(n)$ (A: $\mathcal{O}(\log n)$)
\verb|Insert|     $\Theta(\log n)$ $\Theta(\log n)$ $\mathcal{O}(\log n)$ (A: $\mathcal{O}(1)$)  $\Theta(1)$
\verb|Delete|     $\Theta(\log n)$ $\Theta(\log n)$ $\mathcal{O}(\log n)$                        $\mathcal{O}(n)$ (A: $\mathcal{O}(\log n)$)
\verb|Merge|      $\Theta(n)$      $\Theta(n)$      $\mathcal{O}(\log n)$                        $\Theta(1)$
\verb|DecraseKey| $\Theta(\log n)$ $\Theta(\log n)$ $\Theta(\log n)$                             $\mathcal{O}(\log n)$ (A: $\mathcal{O}(1)$)
