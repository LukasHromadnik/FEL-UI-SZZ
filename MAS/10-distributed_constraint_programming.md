# Distributed Constraint Programming

Set of agents must come to some agreement, typically via some form of negotiation, about which action each agent should take in order to jointly obtain the best solution for the whole system.

Each agent negotiates locally with just a subset of other agnets (usually called neighbors) that are those that can directly influence his behavior.

## Constraint network

A **constraint network** $\mathcal{N}$ is formally defined as a tripe $\langle X, D, C \rangle$, where

* $X = x_1, \dots, x_n$ is a set of variables,
* $D = \{D_1, \dots, D_n\}$ is a set of variable domains which enumerate all possible values of the corresponding variables and
* $C = \{C_1, \dots, C_n\}$ is a set of constraints where a constraint $C_i$ is deifned on a subset of variables $S_i \subseteq X$ which comprise the scope of the constraint ($r_i = |S_i|$ is the arity of a constraint $i$).

Hard constraint $C_i^h$ is a boolean predicate $P_i$ that defines valid joints assignment of variables in the scope
$$P_i: D_1^i \times  \cdots \times D_{r_i}^i \rightarrow \{F,T\}.$$

Soft constraint $C_i^s$ is a function $F_i$ that maps every possible joint assignment of all variables in the scope to a real value
$$F_i: D_1^i \times \cdots \times D_{r_i}^i \rightarrow \mathbb{R}.$$

Binary constraint networks are those where each constraint is defined over two variables. These networks can be represented by a constraint graph.

## Constraint Reasoning Problems

**Constraint Satisfaction Problem (CSP).** Find an assignment for all variables in the network that satisfies all constraints.

**Constraint Optimization Problem (COP).** Find an assignment for all the variables in the network that satisfies all cosntraints and optimizes a global function.

## Distributed Constraint Reasoning

A distributed constraint reasoning problem consists of a constraint network $\langle X, D, C \rangle$ and a set of agents $A = A_1, \dots, A_k$ where each agent:

* controls a subset of variables $X_i \subseteq X$
* is only aware of constraints that involve variable it controls
* communicates only (locally) with its neighbors 1:1  
    agent-to-variable mapping assumed for algorithm explanation

each node communicates its domain to its neighbors, eliminates from its domain the values that are not consistent with the values received from the neighbors, and the process repeats. Specifically each node $x_i$ with domain $D_i$ repeatedly executes the procedure **Revise**($x_i, x_j$) for each neighbor $x_j$.

## Asynchronous Backtracking Algorithm (ABT)

* Agents communcate by sending messages (directed communication / no broadcasting)
* For any pair of agents, messages are delivered in the order they were sent.
* Agents know the constraints in which they are involved, but not the other constraints
* Each agent owns a single variable
* Constraints are binary (2 variables involed)

### Algorithm

The algorithm makes an ordering on agents and assigns them priority numbers. A higher-priority agent $j$ informs a lower-priority agent $k$ oof its assignment. Lower-priority agent $k$ evaluates the shared $C_{jk}$ constraint with its own assignment.

1. Assignment: agent $j$ takes value $a$, $j$ informs all lower priority agents in the neighborhood (**ok?** message)
2. Backtrack (no good): $k$ has no consistent values with higher-priority agents. $k$ resolves nogoods and sends a backtrack (**nogood**) message to the higher-priority agent in the neighborhood with the lowest priority
3. New links: $j$ recieves a nogood mentioning $i$, however it is not connected with $j$. $j$ asks $i$ to set up a link
4. Stop: "no solution" (empty set in nogood) detected by an agent: stop

Solution: when agents are silent for a while, every constraint is satisfied $\rightarrow$ solution (detected by specialized algorithms outside ABT)

### Data structures

**Current context / agent view:** values of higher-priority constrained agents

**NoGood store:** each removed value has a justifying nogood
$$x_i = a \wedge x_j = b \Rightarrow x_k \ne c$$

If a nogood is no longer active, it is removed and the value is available again.
