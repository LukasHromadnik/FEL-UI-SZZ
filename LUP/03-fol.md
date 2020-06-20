# First-order logic

**Terms.** The set of all *terms* in a language $L$ is the smallest set satisfying

* every variable (an element of $Var$) is a term in $L$,
* if $f$ is an $n$-ary function in $L$ and $t_1, \dots, t_n$ are terms in $L$, then $f(t_1, \dots, t_n)$ is a term in $L$.

**Formulae.** The set of all *formulae* in a language $L$ is the smallest set such that

* every atomic formula in $L$ is a formula in $L$,
* if $\phi$ and $\psi$ are formulae in $L, X$ is a variable, then $\forall X \phi, \exists X \phi, (\neg \phi), (\phi \to \psi), (\phi \wedge \psi)$ and $(\phi \vee \psi)$ are formulae in $L$.

We distringuish two types of variables in a formula $\phi$

* **free** – not under a scope of a quantifier,
* **bounded** – under a scope of a quantifier.

**Interpretation.** An *interpretation* (or **model**) for a language $L$, denoted $\mm = (D, i)$, consists of a non-empty set $D$ (domain) and a function $i$ (interpretation) on $D$ such that

* if $f$ is an $n$-ary function symbol in $L$, then $i(f): D^n \to D$,
* if $p$ is an $n$-ary predicate symbol in $L$, then $i(p) \subseteq D^n$.

**Evaluation.** Let $\mm = (D, i)$ be an interpretation for $L$, an *evaluation* in \mm is any function $e: Var \to D$.

A formula $\phi$ is valid (or holds) in \mm, denoted $\mm \vDash \phi$, if $\phi$ is satisfied in \mm by any evaluation $e$.

* $\neg \forall X \phi \equiv \exists X \neg \phi$
* $\exists X(\phi \to \chi) \equiv \forall X \phi \to \exists X \chi$
* $(\forall X \phi \to \psi) \equiv \exists X(\phi \to \psi)$

**Equivalent.** Let $\psi$ be a subformula of a formula $\phi$ and $\chi$ be a formula such that $\psi \equiv \chi$. A formula $\phi'$ is obtained by replacing $\psi$ in $\phi$ by $\chi$. It holds that $\phi \equiv \phi'$.

**Prenexing.** We say that a formula $\phi$ is in *prenex form* if $\phi = Q_1 X_1, \dots, Q_n X_n \psi$ where $Q_1, \dots, Q_n$ are quantifiers and $\psi$ is an open formula.

For every formula $\phi$ there exists a formula $\psi$ in prenex normal form such that $\phi \equiv \psi$.

**Substitution.** A *substitution* is a functin that assigns terms to variables. An application of a substitution $\sigma$ on a formula $\phi$, denoted $\phi \sigma$, is a formula $\phi$ with all free occurrences of variables replaces simultaneously by their $\sigma$ images.

A term $t$ is substituable into a formula $\phi$ for a variable $X$ if no occurrence of a variable $t$ becomes bounded in $\phi$ when all free occurrences of $X$ in $\phi$ are replaced by $t$.

**Sentences.** A term is *closed*, if it contains no variables. A formula $\phi$ is a *sentence* (or closed), if it contains no free occurrence of variables. A formula $\phi$ is open, if it contains no quantifiers.

Let $\phi$ be a sentence, $\sigma$ be a substitution, \mm be an interpretation and $e$ be an evaluation, then

1. $\phi \sigma = \phi$,
2. $\mm \vDash \phi[e]$ iff $\mm \vDash \phi[e']$ for every evaluation $e'$,
3. $\mm \vDash \phi$ or $\mm \vDash \neg \phi$.

**Skolemization.** We say that a formula is in Skolem normal form if it is in prenex normal form and it contains no existential quantifiers.

For example, from
$$\phi = \forall X_1, \dots, \forall X_n, \exists Y \psi$$
we can get a formula in Skolem normal form by
$$\phi' = \forall X_1, \dots, \forall X_n \psi \{Y \mapsto f(X_1, \dots, X_n) \}.$$

**Rectified formula.** A formula $\phi$ is *rectified* if

* no variable occurs both free and bounded in $\phi$,
* no two quantifiers in $\phi$ quantify over the same variable.

We obtain a rectified formula by renaming bounded variables.

We produce a CNF $\phi'$ (implicitly universally quantified) from a sentence $\phi$ by performing the following steps

1. produce a negation normal form (NNF, e.g. $\neg \neg \phi \rightsquigarrow \phi$)),
2. rectify,
3. skolemize,
4. remove all universal quantifiers,
5. produce a CNF as in propositional logic.

**Instance.** We say that $\phi \sigma$ is an *instance* of $\phi$. If an instance contains no variable, then we call it a  **ground instance**.

**Herbrand universe.** The *Herbrand universe* of $\Gamma$, denoted $HU(\Gamma)$, is the set of all ground terms in the language of $\Gamma$. If $\Gamma$ contains no constant, we add a fresh constant $c$ to the language.

**Herbrand base.** The *Herbrand base* of $\Gamma$, denoted $HB(\Gamma)$, is the set of all ground atomic formulae in the language $\Gamma$, where only terms from $HU(\Gamma)$ are allowed.

**Herbrand interpretation.** A *Herbrand interpretation* of $\Gamma$ is a subset of $HB(\Gamma)$.

**Herbrand model.** A *Herbrand model* \mm of $\Gamma$ is a Herbrand interpretation of $\Gamma$ such that $\mm \vDash \Gamma$.

**Herbrand's theorem.** Let $\Gamma$ be a set of clauses. The following conditions are equivalent:

1. $\Gamma$ is unsatisfiable,
2. the set of all ground instance of $\Gamma$ is unsatisfiable,
3. a finite subset of the set of all ground instance of $\Gamma$ is unsatisfiable.

**Unifier.** Let $s$ and $t$ be terms. A *unifier* of $s$ and $t$ is a substitution $\sigma$ such that $s \sigma$ and $t \sigma$ are identical ($s\sigma = t \sigma$).

A unifier $\sigma$ of $s$ and $t$ is said to be a **most general unifier** (or $mgu$), denoted $\sigma = mgu(s, t)$, if for any unifier $\theta$ of $s$ and $t$ there is a substitution $\nu$ such that $\theta = \sigma \nu$ that is $\theta$ is a composition of $\sigma$ and $\nu$.

A set of equations $\{ X_1 \doteq t_1, \dots, X_n \doteq t_n \}$ is said to be in **solved form** if $X_1, \dots, X_n$ are distinct variables that  do not appear in terms $t_1, \dots, t_n$.

Given a finite set of pairs of terms $T = \{ s_1 \doteq t_1, \dots, s_n \doteq t_n \}$. The **unification algorithm** either produces a set of eqautions in solved from that defines an mgu $\sigma$ such that $s_i \sigma = t_i \sigma$, for $1 \leq i \leq n$, or it fails. If it fails, then there is no unifier for the set.

**Resolution.** Let $l_1, \dots, l_m, l_{m + 1}, \dots, l_{m + n}$ be literals and $p$ and $q$ atomic formulae.
$$\frac{\{l_1, \dots, l_m, \textcolor{red}{p}\} \quad \{\textcolor{red}{\neg q}, l_{m + 1}, \dots, l_{m + n} \}}{\{l_1, \dots, l_m, l_{m + 1}, \dots, l_{m + n} \} \sigma}$$
where $\sigma = mgu(p, q)$ and $\{l_1, \dots, l_m, l_{m + 1}, \dots, l_{m + n} \} \sigma$ is equal to $\{ l_1 \sigma, \dots, l_m \sigma, l_{m + 1} \sigma, \dots, l_{m + n} \sigma \}$.

Unlike in propositional logic, it is possible to resolve two clauses in multiple ways and still obtain useful resolvents.

Let $\Gamma$ be a set of clauses. $\Gamma$ is unsatisfiable $\Leftrightarrow \Gamma \vdash \square$.

**Factoring.** We need to add the factoring rule. Let $l_1, \dots, l_m, l_{m + 1}, l, k$ be literals.
$$\frac{\{l_1, \dots, l_m, \textcolor{red}{l}, \textcolor{red}{k}\}}{\{l_1, \dots, l_m, \textcolor{red}{l}\}\sigma}$$
where $\sigma = mgu(l, k)$. Note that $l$ and $k$ are either both positive or both negative. Moreover, $\{ l_1, \dots, l_m, l, k\} \vDash \{l_1, \dots, l_m, l\} \sigma$.

**Subsumption.** A clause $\phi$ *subsumes* a clause $\psi$, denoted $\phi \sqsubseteq \psi$, if there is a substitution $\sigma$ such that $\phi \sigma \subseteq \psi$.

If $\phi \sqsubseteq \psi$, then $\psi \vDash \psi$.

**Positive resolution.** Let $\Gamma$ be a set of clauses. We split it into the positive part $\Gamma^+$ and $\Gamma' = \Gamma \setminus \Gamma^+$. If $\Gamma^+ = \emptyset$, then making all atomic predicates *false* satisfies $\Gamma' = \Gamma$. If $\Gamma' = \emptyset$, then making all atomic predicates *true* satisifies $\Gamma^+ = \Gamma$.

**Semantic resolution.** A generalization of positive resolution, we have an interpretation $I$ and we alyways select at least one clause that is not valid in $I$.

**Watchlist.** It is a set of clauses we feed into the prover that can be used for guiding the proof search (lemmata, hints), e.g. clauses that led to proofs in previous similar problems.

**Clause splitting.** If we can split a clause into two (or more parts), which do not share variables, then we can do that and solve two (simpler) cases.
