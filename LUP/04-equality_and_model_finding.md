# Equality and model finding

We say that an interpreation is normal if the equality predicate is interpreted as the identity relation on its domain.

Any set of formulae $\Gamma$ has a normal model iff $\Gamma$ has a model satisfying the equality axioms.

**Paramodulation.** We say $s \dot\approx t$ if $s \approx t$ or $t \approx s$, because order will be important for us later on.

Let $l, l_1, \dots, l_m, l_{m + 1}, \dots, l_{m + n}$ be literals and $s, s'$ and $t$ be terms. Moreover $l[s']$ means that the literal $l$ contains $s'$
$$\frac{\{l_1, \dots, l_m, \textcolor{red}{s \dot\approx t} \} \quad \{ l[s'], l_{m + 1}, \dots, l_{m + n}\}}{\{ l_1, \dots, l_m, l_{m + 1}, \dots, l_{m + n}, l[t]\}\sigma}$$
where $\sigma = mgu(s, s')$ and $l[t]$ is the result of replacing an occurence of $s'$ in $l[s']$ by $t$. We assume that the input classes do not share variables.

**Completeness.** Let $\Gamma$ be a set of clauses in the FOL language with equality. $\Gamma$ is unsatisfiable iff $\Gamma \vdash_\approx \square$.

**Terms orderings.** We say that a binary relation $\rewrite$ is a *rewrite relation* if it is

* stable under contexts: $s \rewrite t$ implies $u[s] \rewrite u[t]$ and
* stable under substitutions: $s \rewrite t$ implies $s\sigma \rewrite t \sigma$

where $s, t$ and $u$ are terms and $\sigma$ is a substitution.

## Model finding

A general method is to provide a counterexample. A model of $\Gamma$ where $\phi$ is false, for simplicity assume that $\phi$ is a closed formula.
