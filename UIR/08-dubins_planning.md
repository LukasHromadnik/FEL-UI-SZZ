# Data Collection Planning with Curvature-Constrained Vehicles

## Dubins Vehicle

* Constant forward velocity
* Limited minimal turning radius $\rho$
* Vehicle state is represented by a triplet $q = (x, y, \theta)$ where
    * position is $(x, y) \in \mathbb{R}^2$,
    * vehicle heading is $\theta \in \mathbb{S}^2$, and thus $q \in SE(2)$.

**Optimal path.** The *optimal path** connecting $q_1 \in$ SE(2) and $q_2 \in$ SE(2) consists only of straight  line arcs and arvcs with the maximal curvature, i.e. two types of maneuvers CCC and CSC and the solutionn can be found analytically.

The main difficulty is to determine the vehilce headings for a givenn sequence of waypoints.

## Dubing Touring Problem (DTP)

### Sampling-based solution

We can sample possible heading values at each location $i$ a discrete set of $k$ headings and create a graph of all possible Dubins maneuvers. We can further informed the sampling process to sample more probable headings.

## Dubins Interval Problem (DIP)

It's a generalization of Dubins maneuvers to the shortest path connecting two points $p_i$ and $p_j$.

In the DIP the leaving interval $\Theta_i$ at $p_i$ and the arrival interval $\Theta_j$ at $p_j~ are consider (not a single heading value).

The optimal solution can be found analytically and it's a tight lower bound for the DTP but it's not a feasible solution of the DTP.

## Dubins Traveling Salesman Problem (DTSP)

* **Decoupled** approach based on a given sequence of the locations, e.g. found by a solution of the ETSP where the heading are established using straight line segments.
* **Sampling-based** approach with sampling of the headings at the locations into discrete sets of values and considering the problem as the variant of the GTSP.

## Variable Neighborhood search (VNS)

* **Shake** – explored the configuration space and espcaes from a local minima using
    * **Insert** – moves one random element
    * **Exchange** – exchanges two random elements
* **Local search** – optimizes the solution
    * **Path insert** – moves a random sub-sequence
    * **Path exchange** – exchanges two random sub-sequences

It's like $k$-OPT.
