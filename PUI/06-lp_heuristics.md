# LP-Based Heuristics

## Cost Partitioning

* Create copies $\Pi_1, \dots, \Pi_n$ of planning task $\Pi$.
* Each has its own **operator cost function** $cost_i: A \to \mathbb{R}_0^+$ (otherwise identical to $\Pi$)
* $\forall a:$ require $cost_1(a) + \cdots + cost_n(a) \leq cost(a)$

Sum of solution costs in copies is admissible heuristic: $h_{\Pi_1}^* + \cdots h_{\Pi_n}^* \leq h_\Pi^*$
