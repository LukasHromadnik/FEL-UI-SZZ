# Multi-Goal Planning and Robotic Information Gathering

Having a set of locations to be visited, determine cost-efficient path to visit them and return to a starting location.

**Traveling Salesman Problem (TSP).** Given a set of cities and the distances between each pair of cities, what is the shortest possible route that visits each city exactly once and returns to the origin city.

## MultiGoal Path Planning (MTP)

Given a map of the environment $\mathcal{W}$, mobile robot $\mathcal{R}$, and a set of locations, what is the shoortest possible **collision free path** that visits each location exactly once and returns to the origin location.

Determiniation of the collision-free path in high dimensional configuration space $\mathcal{C}$-space can be a challneging problem itself. Therefore, we can generalize the MTP to multi-goal **motion** planning (MGMP) considering motion planners using the notion of $\mathcal{C}$-space for avoiding collisions.

## MGMP Problem

The working environment $\mathcal{W} \subset \mathbb{R}^3$ is represented as a set of obstacles $\mathcal{O} \subset \mathcal{W}$ and the robot configuration space $\mathcal{C}$ describes all possible configurations of the robot in $\mathcal{W}$.

Multi-goal path $\tau$ is **admissible** if $\tau: [0, 1] \to \mathcal{C}_{free}, \tau(0) = \tau(1)$ adn there are $n$ points such that $0 \leq t_1 \leq t_2 \leq \cdots \leq t_n, d(\tau(t_i), v_i) < \varepsilon$, and $\cup_{1 < i \leq n} v_i = \mathcal{G}$.

The problem is to find the path $\tauž*$ for a cost function $c$ such that $c(\tau^*) = \min\{ c(\tau) \ | \ \tau {text is admissible multi-goal path }\}$.

## Exploration

### Occupancy Grid

A cell is a binary random variables modeling the occupancy of the cell

* cell $m_i$ is occupied $p(m_i) = 1$
* cell $m_i$ is not occupied $p(m_i) = 0$
* *unknown* $p(m_i) = 0.5$

### Frontier-based Exploration

The basic idea of the *frontier-based exploration* is navigation of the mobile robot towards unknown regions.

**Frontier.** A border of the known and unknown regions of the environment.

**Frontier cell** is a free space cell that is incident with an unknown cell.

Variants of the Distance Cost

* next-best view – greedy
* TSP distance cost – consider visitation of all goals

### Unsupervised Leaning based Solution of the TSP

* Self-Organizing Map – select winner, that is then adapted (pushed) to the closer to the goal node
