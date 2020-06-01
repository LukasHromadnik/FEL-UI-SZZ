# Scheduling

Scheduling is an assignment of a task to a resource in time.

* set of $n$ tasks $\mathcal{T} = \{ T_1, T_2, \dots, T_n \}$
* set of $m$ types of resources with capacities $R_k, \mathcal{P} = \left\{ P_1^1, \dots, P_1^{R_1}, P_2^1, \dots, P_2^{R_2}, \dots \dots, P_m^1, \dots, P_m^{R_m} \right\}$

Each task must be **completed**. Set of tasks is known when executing the scheduling algorithm – off-line scheduling.

General constraints:

* Each task is to be processed **by at most one resource at a time**
* Each resource is capable of processing **at most one task at a time**

Specific constraints:

* Task $T_i$ has to be processed during time interval $\langle r_i, \tilde{d_i} \rangle$
* When the precedence constraint is defined between $T_i$ and $T_j$, the processing of the task $T_j$ can't start before task $T_i$ is completed
* If scheduling is non-preemptive, a task cannot be stopped and completed later
* If scheduling is preemptive, the number of preemptions must be finite

## Graham's Notation $\alpha | \beta | \gamma$

Classify scheduling problems by **resources | tasks | criterion**

### Optimality criterion $\gamma$

+----------------+-------------------------------------------------------------+
| $C_{max}$      | minimize schedule length $C_{max} = \max \{ C_j \}$ \       |
|                | (makespan, i.e. completion time of the last task)           |
+----------------+-------------------------------------------------------------+
| $\sum C_j$     | minimize the sum of completion times                        |
+----------------+-------------------------------------------------------------+
| $\sum w_j C_j$ | minimizes weighted completion time                          |
+----------------+-------------------------------------------------------------+
| $L_{max}$      | minimizes maximum lateness $L_{max} = \max \{ C_j - d_j \}$ |
+----------------+-------------------------------------------------------------+

## Bratley's Algorithm for $1 \, | \, r_j, \tilde{d_j} \, | \, C_{max}$

A **branch and bound** algorithm. Every node is labeled by: (the order of tasks)/(completion time of the last task).

### Bounding

1. **eliminate the node** exceeding the deadline (and all its "brothers")
2. **problem decomposition** due to idle waiting  
Consider node $v$ on level $k$. If $C_i$ of the last scheduled task is less than or equal to $r_i$ of all unscheduled tasks, there is no need for backtrack above $v$

### Block with Release Time Property (BRTP)

BRTP is a set of $k$ tasks that satisfy:

* first task $T_1$ starts at it's release time
* all $k$ tasks until the end of the schedule run without "idle waiting"
* $r_1 \leq r_i, \forall u = 2, \dots, k$

If BRTP exists, the schedule is optimal.

## Problem $1 \, || \, L_{max}$

Can be solved by EDD (Earliest Due Date first), i.e. **tasks are scheduled in order of nondecreasing due dates**.

Time complexity is $\mathcal{O}(n \cdot \log n)$.

## Problem $1 \, | \, r_j, p_j = 1 \, | \, L_{max}$

Optimal schedule can be found by **iterative calls of EDD**: at every moment we schedule the task which is ready and has the lowest $d_j$ among all ready tasks

\begin{algorithm}[!htp]
\caption{Problem $1 \, | \, r_j, p_j = 1 \, | \, L_{max}$}
\hspace*{\algorithmicindent} \textbf{Input:} $\mathcal{T}$, set of $n$ non-preemptive tasks with unit processing time, release dates $(r_1, r_2, \dots, r_n)$ and due-dates $(d_1, d_2, \dots, d_n)$. \\
\hspace*{\algorithmicindent} \textbf{Output:} Start times $(s_1, s_2, \dots, s_n)$
\begin{algorithmic}[1]
\State $t \gets 0$
\While{$\mathcal{T} \ne \emptyset$}
    \State $t \gets \max\{t, \min_{T_j \in \mathcal{T}} r_j\}$                  \Comment shift time if no task is ready
    \State $\mathcal{T}' = \{ T_j \, | \, T_j \in \mathcal{T}, r_j \leq t\}$    \Comment set of ready tasks
    \State choose $T_j \in \mathcal{T}'$ with minimal $d_j$                     \Comment EDD in $\mathcal{T}'$
    \State $\mathcal{T} \gets \mathcal{T} \setminus \{ T_j \}$
    \State $s_j \gets t$
    \State $t \gets t + 1$
\EndWhile
\end{algorithmic}
\end{algorithm}

## Problem $1 \, | \, \mathrm{pmtn}, r_j \, | \, L_{max}$ – Horn's Algorithm

\begin{algorithm}[!htp]
\caption{Problem $1 \, | \, r_j, p_j = 1 \, | \, L_{max}$}
\hspace*{\algorithmicindent} \textbf{Input:} $\mathcal{T}$, set of $n$ preemptive tasks, its processing times, release dates and due-dates \\
\hspace*{\algorithmicindent} \textbf{Output:} Start times of preempted parts of tasks.
\begin{algorithmic}[1]
\While{$\mathcal{T} \ne \emptyset$}
    \State $t_1 \gets \min_{T_j \in \mathcal{T}} r_j$                               \Comment set $t_1$ to the smallest release time
    \If{all tasks are ready at time $t_1$} \State $t_2 = \infty$
    \Else \State $t_2 = \min_{T_j \in \mathcal{T}} \{ r_j \, | \, r_j > t_1 \}$       \Comment set $t_2$ to the next smallest release time
    \EndIf
    \State $\mathcal{T}' \gets \{ T_j \, | \, T_j \in \mathcal{T}, r_j = t_1 \}$    \Comment set of ready tasks
    \State choose $T_k \in \mathcal{T}'$ with minimal $d_j$                         \Comment EDD in $\mathcal{T}'$
    \State $\delta \gets \min \{ p_k, t_2 - t_1 \}$                                 \Comment scheduled window length
    \State schedule $T_k$ or its part in interval $\langle t_1, t_1 + \delta)$
    \If{$\delta = p_k$}
        \State $\mathcal{T} \gets \mathcal{T} \setminus \{ T_k \}$
    \Else
        \State $p_k \gets p_k - \delta$                                             \Comment preemption
    \EndIf
    \For{$T_j \in \mathcal{T}'$}
        \State $r_j \gets t_1 + \delta$
    \EndFor
\EndWhile
\end{algorithmic}
\end{algorithm}

Given a set of $n$ independent preemptive tasks with arbitrary release times, any algorithm that at any instant executes the task with the earliest due date among all the ready tasks is optimal with respect to $L_{max}$ minimization.

\clearpage

## McNaughton's Algorithm for $P \, | \, \mathrm{pmtn} \, | \, C_{max}$

* $\mathcal{O}(n)$

\begin{algorithm}[!htp]
\caption{McNaughton's Algorithm}
\hspace*{\algorithmicindent} \textbf{Input:} $R$, number of parallel identical resources, $n$ number of preemptive tasks and computation times $(p_1, p_2, \dots, p_n)$. \\
\hspace*{\algorithmicindent} \textbf{Output:} $n$-element vectors $s^1, s^2, z^1, z^2$ where $s_i^1$, resp. $s_i^2$, is start time of the first, resp. second, part of task $T_i$ and $z_i^1$, resp. $z_i^2$, is the resource ID on which the first, resp. second, part of task $T_i$ will be executed.
\begin{algorithmic}[1]
\State $s_i^2 \gets s_i^2 \gets z_i^1 \gets z_i^2 \gets 0, \forall i \in 1, \dots, n$
\State $t \gets 0, \quad v \gets 1, \quad i \gets 1$
\State $C_{max}^* \gets \max\{ \max_{i = 1, \dots, n} \{ p_i \}, \frac{1}{R} \sum_{1}^n p_i \}$
\While{$i \leq n$}
    \If{$t + p_i \leq C_{max}^*$}
        \State $s_i^1 \gets t, \quad z_i^1 \gets v, \quad t \gets t + p_i, \quad i \gets i + 1$
    \Else
        \State $s_i^2 \gets t, \quad z_i^2 \gets v, \quad p_i \gets p_i - (C_{max}^* - t), \quad t \gets 0, \quad v \gets v + 1$
    \EndIf
\EndWhile
\end{algorithmic}
\end{algorithm}

## List Scheduling – Approximation algorithm for $P \, | \, \mathrm{prec} \, | \, C_{max}$

* $\mathcal{O}(n)$

\begin{algorithm}[!htp]
\caption{List Scheduling}
\hspace*{\algorithmicindent} \textbf{Input:} $R$, number of parallel identical resources, $n$ number of non-preemptive tasks and computation times $(p_1, p_2, \dots, p_n)$. DAG of precedence constraints. \\
\hspace*{\algorithmicindent} \textbf{Output:} $n$-element vectors $s$ and $z$ where $s_i$ is the start time $T_i$ and $z_i$ is the resource ID.
\begin{algorithmic}[1]
\State $t_v \gets 0, \forall v \in 1, \dots, R$ \Comment availability of resource
\State $s_i \gets 0, z_i \gets 0, \forall i \in 1, \dots, n$
\State Sort tasks in list $L$
\For{$i \in 1, \dots, n$}
    \State $k = \mathrm{arg}\, \min_{v \in 1, \dots, R} \{ t_v \}$ \Comment choose resource with the lowest $t_v$
    \State In the set of free tasks, choose $T_i$ which is first in the list $L$
    \State Remove $T_i$ from the list $L$
    \State $s_i = \max\left\{t_k, \max_{j \in Pred(T_i)} \left\{ s_j + p_j \right\} \right\}$
    \State $z_i = k$
    \State $t_k = s_i + p_i$
\EndFor
\end{algorithmic}
\end{algorithm}

Task $T_i$ is free if its predecessors have been completed.

For $P \, | \, \mathrm{prec} \, | \, C_{max}$ (and also for $P \, || \, C_{max}$) and arbitrary (unsorted) list $L$, List scheduling is an approximation algorithm with factor $r_{LS} = 2 - \frac{1}{R}$.

## Longest Processing Time First (LPT) for $P \, || \, C_{max}$

The approximation factor of the LS algorithm can be decreased using the LPT strategy. During the initialization of LS, we sort list $L$ in a non-increasing order of $p_i$.

LPT algorithm for $P \, || \, C_{max}$ is an approximation algorithm with factor $r_{LPT} = \frac{4}{3} - \frac{1}{3R}$. Time complexity of LPT is $\mathcal{O}(n \cdot \log{n})$ due to the sorting.

## Muntz & Coffman's Level Algorithm for $P \, | \, \mathrm{pmtn, prec} \, | \, C_{max}$

Principle:

* tasks are picked from the **list ordered by the level** of tasks
* **the level of task $T_j$** is the sum of $p_i$ (including $p_j$) along the **longest path** from $T_j$ to a terminal task (a task with no successor)
* when more tasks of the same level are assigned to less resources, each task gets part of the resource capacity $\beta$

For $P2 \, | \, \mathrm{pmtn, prec} \, | \, C_{max}$ and $P \, | \, \mathrm{pmtn, forest} \, | \, C_{max}$, the algorithm is **exact**. For $P \, | \, \mathrm{pmtn, prec} \, | \, C_{max}$ approximation algorithm with factor $r_{MC} = 2 - \frac{2}{R}$.

Time completixy is $\mathcal{O}(n^2)$.

\begin{algorithm}[!htp]
\caption{Muntz \& Coffman's Level Algorithm}
\begin{algorithmic}[1]
\State compute the level of all tasks
\State $t \gets 0, \quad h \gets R$
\While{unfinished tasks exists}
    \State construct $\mathcal{Z}$ \Comment subset $\mathcal{T}$ of free tasks in time $t$
    \While{$h > 0 \wedge | \mathcal{Z} | > 0$} \Comment free resources and free tasks
        \State construct $\mathcal{S}$ \Comment subset $\mathcal{Z}$ of tasks of the highest level
        \If{$|\mathcal{S}| > h$}
            \State assign part of capacity $\beta \gets \frac{h}{|\mathcal{S}|}$ to tasks in $\mathcal{S}$
            \State $h \gets 0$
        \Else
            \State assign one resource to each task in $\mathcal{S}$
            \State $\beta \gets 1$
            \State $h \gets h - |\mathcal{S}|$
        \EndIf
        \State $\mathcal{Z} \gets \mathcal{Z} \setminus \mathcal{S}$
    \EndWhile
    \State compute $\delta$ \Comment explanation below
    \State decrease the level of tasks by $\delta \cdot \beta$
    \State $t \gets t + \delta$
    \State $h \gets R$
\EndWhile
\end{algorithmic}
\end{algorithm}

$t + \delta$ is time when

* EITHER one of the assigned tasks is finished
* OR a current level of an assigned task becomes lower than a level of an unassigned ready task
* OR a task executed at faster rate $\beta$ started to have current level below the current level of a task executed at slower rate

## Project scheduling

### Temporal Constraints

* A set of non-preemptive tasks $\mathcal{T} = \{ T_1, T_2, \dots, T_n \}$ is represented by the nodes of the directed graph $G$.
* Processing time $p_i$ is assigned to each task.
* The edges represent temporal constraints. Each edge from $T_i$ to $T_j$ has the length $l_{ij}$.
* Each temporal constraint is characterized by one inequality $s_i + l_{ij} \leq s_j$ – the start time of one task depends on the start time of another task.

### Time-indexed Model for $PS1 \, | \, \mathrm{temp} \, | \, C_{max}$

\begin{equation*}
\begin{array}{lllr}
\text{minimize} & C_{max} & & \\
\text{subject to} & \displaystyle\sum_{t = 0}^{UB - 1}(t \cdot x_{it}) + l_{ij} \leq \displaystyle\sum_{t = 0}^{UB - 1}(t \cdot x_{jt}) & \forall l_{ij} \ne -\infty \wedge i \ne j &\text{prec. const.} \\
& \displaystyle\sum_{i = 1}^n \left( \displaystyle\sum_{k = \max(0, t - p_i + 1)}^t x_{ik} \right) \leq 1 & \forall t \in 0, \dots, UB - 1 & \text{resource} \\
& \displaystyle\sum_{t = 0}^{UB - 1} x_{it} = 1 & \forall i \in 1, \dots n & T_i \text{ is scheduled} \\
& \displaystyle\sum_{t = 0}^{UB - 1} (t \cdot x_{it}) + p_i \leq C_{max} & \forall i \in 1, \dots, n & \\ 
\end{array}
\end{equation*}

$x_{it} = 1$ if $s_i = t$.

$UB$ is the upper bound of $C_{max}$ (e.g. $UB = \sum_{i = 1}^n \max\{p_i, \max_{i, j \in 1, \dots, n} l_{ij}\})$.

Start time of $T_i$ is $s_i = \sum_{t = 0}^{UB - 1}(t \cdot x_{it})$.

### Relative-order Model for $PS1 \, | \, \mathrm{temp} \, | \, C_{max}$

\begin{equation*}
\begin{array}{lllr}
\text{minimize} & C_{max} & & \\
\text{subject to} & s_i + l_{ij} \leq s_j & \forall l_{ij} \ne -\infty \wedge i \ne j & \text{temporal constraint} \\
& p_j \leq s_i - s_j + UB \cdot x_{ij} \leq UB - p_i & \forall i, j \in 1, \dots, n \wedge i < j & \text{resource constraint} \\
& s_i + p_i \leq C_{max} & \forall i \in 1, \dots, n & \\
\end{array}
\end{equation*}

### Comparisons of the Two Models

Time-indexed model:

* (+) Can be easily extended for parallel identical processors.
* (+) ILP formulation does not need many constraints.
* (–) The size of the model grows with the size of $UB$.

Relative-order model:

* (+) The size of ILP model does not depend on $UB$.
* (–) Require a big number of constraints.
