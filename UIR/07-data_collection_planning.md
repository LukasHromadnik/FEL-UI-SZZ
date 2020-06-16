# Data Collection Planning TSP(N) and OP(N)

## Traveling Salesman Problem with Neighborhoods (TSPN)

Instead of visiting a particular location $s \in S \subseteq \mathbb{R}^2$ we can request to visit a region $r \subset \mathbb{R}^2$ to save travel cost.

The TSP becomes the TSP with Neighborhoods where it is necessary in addition to the determination of the order ofo visits $\Sigma$ also determine suitable locatioons $P = \{p_1, \dots, p_n\}, p_i \in r_i$ of visits to $R$.

### Approaches

* Decoupled approach – determine sequence of visits $\Sigma$ independently on the locations $P$, for the sequence $\Sigma$ determine the locations $P$ to minimize the total tour length.
* Sampling-based approaches – for each region sample possible locations of visits into a discrete set of locations for each region
* Sampling-based Decoupled Solution  
    * sample each neighborhood with, e.g., $k = 6$ samples
    * determine sequence of visits by a solution of the ETSP for the centroids
    * finidng the shortest tour takse in a forward search graph $\mathcal{O}(nk^3)$ for $nk^2$ edges in the sequence

## Generalized Traveling Salesman Problem (GTSP)

For a set of $n$ sets $S = \{ S_1, \dots, S_n \}$ each with particular set of locations (nodes) $S_i = \{s_1^i, \dots, s_{n_i}^i\}$. The problem is to determine the shortest tour visiting each set $S_i$, i.e. determining the order $\Sigma$ of visits of $S$ and a particular locations $s^i \in S_i$ for each $S_i \in S$.

We can transform GTSP to Asymmetric TSP using **Noon-Bean Transformation**.

### Noon-Bean Transformation

Modify weights of the edges such that the optimal ATSP tour visits all vertices of the same cluster before moving to the next cluster

* Adding a large constant $M$ to the weights oof arcs connecting the clusters, e.g., a sum of the $n$ heaviest edges
* Ensure visiting all vertices of the cluster in the prescribed order, i.e., creating zero-length cycles within each cluster.

## Orienteering Problem (OP)

The problem is to collect as many rewards as possible within the given travel budget $T_{max}$ which is especially suitable for robotic vehicles.

The starting and termination locations are prescribed and can be different.

Can be solved with unsupervised learning using self-organizing array.

### Specification

Let the given set of $n$ sensors be located in $\mathbb{R}^2$ with locations $S = \{s_1, \dots, s_n\}, s_i \in \mathbb{R}^2$.

Each sensor $s_i$ has an associated score $\chi_i$ characterizinh the reward if data from $s_i$ are collected.

We aim to determine to subset of $k$ locations $S_k \subseteq S$ that maximizes the sum of the collected rewards while the travel cost to visit them is below $T_{max}$.

The Orienteering Problem combines two NP-hard problems:

* Knapsack problem and
* Traveling Salesman Problem
