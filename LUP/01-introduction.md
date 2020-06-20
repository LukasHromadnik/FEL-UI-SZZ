# Introduction

We are in propositional logic. A **literal** $l$ is a propositinoal variable $p$, also called an *atom*, or a negation of propositional variable $\neg p$. In this context we write $\bar{p}$ instead of $\neg p$.

A **clause** is any disjunction of fintely many literals. An important special case is the empty clause, we write $\square$.

A formula $\varphi$ is in **conjunctive normal form** (CNF) if $\varphi$ is a conjunction of clauses.

A formula $\varphi$ is **satisfiable**, $\varphi \in$ \verb|SAT|, if there is a valuation $v$ s.t. $v \vDash \varphi$ that is $v(\varphi) = 1$.

We know that for any formula $\varphi$ we can obtain a formula $\varphi'$ in CNF, which is not much longer than $\varphi$, and $\varphi$ and $\varphi'$ are **equisatisfiable** – either both are satisfiable, or both are unsatisfiable.

Recal two special cases. The empty clause $\square$ (empty disjunction) is unsatisfiable. The empty conjunction is satisfiable.
