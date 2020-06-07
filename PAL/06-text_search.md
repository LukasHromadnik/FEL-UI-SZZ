# Finite automaton

**Finite automaton** is a 5-tuple $(A, Q, \sigma, S_0, Q_f)$ where

* $A$ is an alphabet, finite set of symbols,
* $Q$ is a set of states,
* $\sigma$ is a transition function, $\sigma: Q \times A \rightarrow Q$,
* $S_0$ is a start state, $s_0 \in Q$,
* $Q_F$ is an unempty set of final states, $\emptyset \ne Q_F \subseteq Q$

Transforming NFA (Non-deterministic finite automaton) to DFA using a transition table.

  a     b     c
- ----- ----- -----
0 1     2
1       3, 4
2 4,5

$$\Downarrow$$

         a       b       c
-------- ------- ------- -----
0        1       2
1                34
2        45
$\vdots$
34       $\dots$ $\dots$ $\dots$
45       $\dots$ $\dots$ $\dots$

# Text Search

Naive approach:

1. Align the pattern with the beginning of the text.
2. While corresponding symbols of the pattern and the text match each other move forward by one symbol in the pattern.
3. When symbol mismatch occurs shift the pattern forward by one symbol, reset position in the pattern to the beginning of the pattern and go to 2.
4. When the end of the pattern is passed report success, shift the pattern forward by one symbol, reset position in the pattern to its beginning and go to 2.
5. When the end of the text is reached stop.

## Regular languages

Only regular languages can be processed by NFA / DFA. More complex languages cannot. For example, any language containing *well-formed parentheses* is context-free and not regular and cannot be recognized by NFA / DFA.

Whenever $L_1$ and $L_2$ are regular languages then $L_1 \cup L_2, L_1 \cdot L_2, L_1^*$ are regular languages too.

Regular expressions are defined recursively:

* symbol $\varepsilon$ is a regular expression,
* each symbol of alphabet $\Sigma$ is a regular expression.

Whenever $e_1$ and $e_2$ are regular expression then also strings $(e_1), e_1 + e_2, e_1e_2, (e_1)^*$ are regular expressions.

Languages represented by regular expressions (RE) are defined the same way.

**$\varepsilon$-closure.** Symbol $\varepsilon$-closure($p$) denotes the set of all states $q$ which can be reached from state $p$ using only $\varepsilon$-transitions. By definition let $\varepsilon$-closure($p$) = $\{p\}$ when there is no $\varepsilon$-transition out from $p$.

We can use $\varepsilon$-transitions to union two or more NFA. Just create a start state $S$ and add $\varepsilon$-transitions from $S$ to start states of all involded NFAs. Also we can concatenate multiple NFAs by adding $\varepsilon$-transitions from the final states to the start state of the next NFA.

### Intersection

Let $L_1, L_2$ be regular languages.

Create a Cartesian product $Q_1 \times Q_2$ where $Q_1, Q_2$ are sets of states of automatons $A_1, A_2$ that accept languages $L_1, L_2$. Each state of the automaton will be an ordered pair $(a_1, a_2)$ where $a_1 \in A_1$ and $a_2 \in A_2$.

State $(S_1, S_2)$ will be a start state. Final states will be just those pairs $(F, G)$ where $F$ is a final state of $A_1$ and $G$ is the final state of $A_2$.

Create transition from state $(p_1, p_2)$ to $(q_1, q_2)$ labeled by a symbol $x$ iff

* there is a transition $p_1 \rightarrow q_1$ labeled by $x$ in $A_1$ and
* there is a transition $p_2 \rightarrow q_2$ labeled by $x$ in $A_2$.

## Hamming distance

Hamming distance of two strings is equal to $k \geq 0$, whenever $k$ is the minimal number of rewrite operations which when applied on one of those strings produce the other string.

Rewrite operation rewrites one symbol of the alphabet by some other symbol of the alphabet. Symbols cannot be deleted or inserted.

Hamming distance is defined only for pairs of strings of equal length.

Informally: Align the strings and count the number of mismatches of corresponding symbols.

### DP approach to text search considering Hamming distance

Let pattern $P$ be $p[1], p[2], \dots, p[m]$, let text $T$ be $t[1], t[2], \dots, t[n]$.

Create a dynamic programming table $D[m + 1][n + 1]$ which elements $d[i][k]$ are defined as follows:

1. $d[0][k] = 0, \forall k \in 0, \dots, n$
2. 
$$d[i][k] = \begin{cases}
d[i - 1][k - 1] & \text{if } p[i] = t[k] \\
d[i - 1][k - 1] + 1 & \text{otherwise}
\end{cases}
$$

Fill the table row by row. Element $d[m][k]$ holds the Hamming distance of $P$ from the substring $t[k - m + 1], t[k - m + 2], \dots, t[k]$.

## Levenshtein distance

Levenshtein distance of two strings $A$ and $B$ is such minimal $k \geq 0$ that we can change $A$ to $B$ or $B$ to $A$ by applying exactly $k$ edit operations on one of $A$ or $B$. The edit operations are Remove, Insert and Rewrite any symbol of the alphabet anywhere in the string.

Levenshtein distance in defined for any two strings over a given alphabet.

### DP approach to text search considering Levenshtein distance

Let pattern $P$ be $p[1], p[2], \dots, p[m]$, let text $T$ be $t[1], t[2], \dots, t[n]$.

Create a dynamic programming table $D[m + 1][n + 1]$ whose elements $d[i][k]$ are defined as follows:

1. $d[i][0] = i, d[0][k] = 0, \forall i \in 0, \dots, m, \forall k \in 1, \dots, n$
2. 
$$d[i][k] = \min \begin{cases}
d[i - 1][k] + 1 & \\
d[i][k - 1] + 1 & \text{if } i > m \\
d[i - 1][k - 1] & \text{if } p[i] = t[k] \\
d[i - 1][k - 1] + 1 & \text{otherwise}
\end{cases}
$$

Fill the table row by row. The cell $d[m][k]$ contains the minimum Levenshtein distance of $P$ from substring $S_{x,k} = t[x], t[x + 1], \dots, t[k]$, where $x \in \{ k - m + 1 - d[m][k], \dots, k - m + 1 + d[m][k] \}$ and the particular value of $x$ is *not known*.
