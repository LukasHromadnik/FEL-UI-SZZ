# Path planning

## Notation

* $\mathcal{W}$ – **world model** describes the robot workspace and its boundary determines the obstacles $\mathcal{O}_i$.
* A **robot** is defined by its geometry, parameters (kinematics) and it is controllable by the motion plan.
* $\mathcal{C}$ – **configuration space** ($\mathcal{C}$-space) is a concept to describe possible configurations of the robot. The robot's configuration completely specify the robot location in $\mathcal{W}$ including specification of all degrees of freedom.
* **Path** is a continuous mapping in $\mathcal{C}$-space such that
$$\pi: [0, 1] \to \mathcal{C}_{free}, \text{ with } \pi(0) = q_0, \text{ and } \pi(1) = q_f.$$
* **Trajectory** is a path with explicate parametrization of time, e.g. accompanied by a description of the motion laws.
* **Path planning** is a planning of a collision-free path in $\mathcal{C}$-space.
* **Motion planning** is a planning of a collision-free motion in the state space.

## Planning methods

### Roadmap based methods

* Visibility graph
* Minimal Construct – algorithm computes visibility graph during the A${}^*$ search
* Voronoi graph – roadmap that maximizes clearance from the obstacles
* Cell decomposition – decompose free space into parts, any two points in a convex region can be directly connected by a segment
* Shortest Path Map – speedup computation of the shortest path towards a particular goal location $p_g$ for a polygonal domain $\mathcal{P}$ with $n$ vertices
* Potential field method – the idea is to create a function $f$ that will provide a direction towards the goal for any configuration of the robot
