# Computing Graph Isomorphism

Two graphs $G_1 = (V_1, E_1)$ and $G_2 = (V_2, E_2)$ are **isomorphic** if there is a bijection $f: V_1 \rightarrow V_2$ such that
$$\forall x, y \in V_1, \{ f(x), f(y) \} \in E_2 \Leftrightarrow \{ x, y \} \in E_1$$
The mapping $f$ is said to be an **isomorphism** between $G_1$ and $G_2$.

Let $\mathcal{F}$ be a family of graphs. An **invariant** on $\mathcal{F}$ is a function $\Phi$ with domain $\mathcal{F}$ such that
$$\forall G_1, G_2 \in \mathcal{F}, G_1 \text{ is isomorphic to } G_2 \Rightarrow \Phi(G_1) = \Phi(G_2).$$

* $|V|$ for graph $G = (V, E)$ is an invariant
* Sequence of degrees of the graphs is not an invariant
* Sequence of degrees sorted in non-decreasing order is an invariant

Let $\mathcal{F}$ be a family of graphs on a vertex set $V$ and let $D$ be a function with domain $(\mathcal{F} \times V)$. Then the **partition $B_G$ of $V$ induced** by $D$ is
$$B_G = \left[ B_G[0], B_G[1], \dots, B_G[n - 1]\right]$$
where
$$B_G[i] = \left\{ v \in V \ | \ D(G, v) = i \right\}$$
If the function
$$\Phi_D(G) = \left[ \left| B_G[0] \right|, \left| B_G[1] \right|, \dots, \left| B_G[n - 1] \right| \right]$$
is an invariant, then we say that $D$ is an **invariant inducing function**.

## Certificate

A certificate $Cert$ for family $\mathcal{F}$ of graphs is a function such that
$$\forall G_1, G_2 \in \mathcal{F} \ | \ Cert(G_1) = Cert(G_2) \Leftrightarrow G_1 \text{ is isomorphic to } G_2.$$

### Computing Tree Certificate

1. Label all the vertices of $G$ with the string $01$.
2. While there are more than two vertices of $G$ do for each non-leaf $x$ of $G$:
    - Let $Y$ be the set of labels of the leaves adjacent to $x$ and the label of $x$ with the initial 0 and trailing 1 deleted from $x$.
    - Replace the label of $x$ with concatenation of the labels in $Y$ sorted in an increasing lexicographic order, with 0 prepended and 1 appended.
    - Remove all leaves adjacent to $x$
3. If there is only one vertex left, report the label of $x$ as a certificate.
4. If there are two vertices $x$ and $y$ left, then report labels of $x$ and $y$ concatenated in increasing lexicographic order as the certificate.

Length of the certificate is $2 \cdot |V|$. The number of 1s and 0s is the same.
