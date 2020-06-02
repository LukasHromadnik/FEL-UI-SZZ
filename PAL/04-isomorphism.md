# Computing Graph Isomorphism

Two graphs $G_1 = (V_1, E_1)$ and $G_2 = (V_2, E_2)$ are **isomorphic** if there is a bijection $f: V_1 \rightarrow V_2$ such that
$$\forall x, y \in V_1, \{ f(x), f(y) \} \in E_2 \Leftrightarrow \{ x, y \} \in E_1$$
The mapping $f$ is said to be an **isomorphism** between $G_1$ and $G_2$.

Let $\mathcal{F}$ be a family of graphs. An **invariant** on $\mathcal{F}$ is a function $\Phi$ with domain $\mathcal{F}$ such that
$$\forall G_1, G_2 \in \mathcal{F}, G_1 \text{ is isomorphic to } G_2 \Rightarrow \Phi(G_1) = \Phi(G_2).$$

* $|V|$ for graph $G = (V, E)$ is an invariant
* Sequence of degrees of the graphs is not an invariant
* Sequence of degrees sorted in non-decreasing order is an invariant