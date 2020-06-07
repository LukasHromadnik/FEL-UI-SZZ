# Trie

## Binary trie

Keys are represented as a sequence of bits. Keys are stored in leaves only, inner nodes serve as routers only.

Null pointers in internal nodes are called **null links**. When trie has no null link it is a complete perfectly balanced binary tree containing $2^{d + 1} - 1$ nodes and $2^d$ leaves.

### \texttt{Insert}

To insert a new node into a trie we search as usual, then distinguish the two cases that can occur for a search miss.

1. If the miss was not on a leaf, then we replace the null link that caused us to detect the miss with a link to a new node.
2. If the miss was on a leaf then we use a function split to make one new internal node for each bit position where the search key and the key found agree, finishing with one internal node for the leftmost but position where the keys differ.

### \texttt{Delete}

Operation \verb|Delete| is complementary to \verb|Insert| operation.

## Patricia trie

### \texttt{Search}

To search we start at the root node and proceed down the tree, using the bit index in each node to tell us which bit to examine in the search key – we go right if that bit is 1, left if it is 0. The keys in the nodes are not examined at all on the way down the tree. Eventually, an upward link is encountered: each upward link points to the unique key in the tree that has the bits that would cause a search to take that link. Thus, if the key at the node pointed to by the first upward link encountered is equal to the search key, then the search is successful; otherwise is unsuccessful.

It is easy to test whether a link points up because the bit indices in the nodes (by definition) increase as we travel down the tree.

### \texttt{Insert}

We gain information on where a new key belongs from a search miss. During the search we have to compare each key with the new key.

There are two cases that can occur during insertion:

1. The new node could replace an internal link (if the search key differs from the key found in a bit position that was skipped), or
2. an external link (if the bit that distinguishes the search key from the found key was not needed to distinguish the found key from all the other keys in the trie).
