# Random numbers

Pseudo-random behavior

* deterministic formula,
* local unpredicatability – "outout looks like random",
* statistical tests might reveal more or less "random behavior".

**Pseudorandom integer generator.** A *pseudorandom integer generator* is an algorithm which produces a sequence
$$\{x_n\} = x_0, x_1, x_2, \dots$$
of non-negative integers, which manifests pseudo-random behavior.

Random number in an interval $[a, b]$ must be independently drawn from a uniform distribution.

**Random floating point number generator.** Let $\{x_n\}$ be a sequence of random integers. Consider sequence
$$\{y_n\} = \left\{\frac{x_n - a}{b - a - 1}\right\}.$$
Each value of $\{y_n\}$ belongs to $\langle 0, 1 )$. "Random" real numbers are thus approximated by "random" fractions. Large length of $[a, b]$ guarantees sufficiently dense division of $\langle 0, 1 )$.

## Linear Congruential Generator

Linear Congruential generator produces a sequence $\{x_n\}$ defined by relations $0 \leq x_0 < M$ and $x_{n + 1} = (Ax_n + C) \modn[M], n \geq 0$ where $M$ is a modulus, $x_0$ is a seed, $A$ is a multiplier and $C$ is an increment.

**Hull-Dobell Theorem.** The length of the period is maximum, i.e. equal to $M$, iff all following conditions hold:

1. $C$ and $M$ are coprimes.
2. $A - 1$ is divisible by each prime factor of $M$.
3. If 4 divides $M$ then also 4 divides $A - 1$.

To increase the random-like behavior of the sequence additional operations may be applied. Typically, it is computing $x_n \modn[W]$ for some $W \leq \max \{x_n\}$, often $W$ is a power of 2 and $\mathrm{mod}$ is just bitwise right shift.

## Combined Linear Congruential Generator

Let  there be $r$ linear congruential generators defined by relations
\begin{align*}
0 \leq y_{k, 0} \leq M_k \\
y_{k, n+ 1} = (A_k y_{k,n} + C_k) \modn[M_k], \quad n > 0 \\
1 \leq k \leq r
\end{align*}
The combined linear congruential generator is a sequence $\{ x_n \}$ defined by
$$x_n = (y_{1,n} - y_{2,n} + y_{3,n} - y_{4, n} + \cdots (-1)^{r - 1} \cdot y_{r,n}) \modn[M_1 - 1], n \geq 0.$$

Maximum possible period length is
$$\frac{(M_1 - 1)(M_2 - 1)\cdots(M_r - 1)}{2^{r - 1}}$$

## Lehmer Generator

Lehmer generator produces a sequence $\{ x_n \}$ defined by relations
\begin{align*}
0 < x_0 < M, x_0 \text{ coprime to } M \\
x_{n + 1} = Ax_n \modn[M], n \geq 0
\end{align*}
where $M$ is a modulus, $x_0$ is a seed and $A$ is a multiplier.

The sequence period length is maximal and equal to $M - 1$ if $M$ is prime and $A$ is a primitive root of the multiplicative group of integers modulo $M$.

**Primitive root.** $G$ is a primitive root of the multiplicative group of integers modulo $M$ if
$$\{G, G^2, G^3, \dots, G^{M - 1}\} = \{1, 2, 3, \dots, M - 1\}$$

## Blum Blum Shub Generator

Blum Blum Shub generator produces a sequence $\{ x_n \}$ defined by relations
\begin{align*}
2 \leq x_0 < M, x_0 \text{ coprime to } M \\
x_{n + 1} = x_n^2 \modn[M]
\end{align*}
where $M$ is a modulus and $x_0$ is a seed.

Seed $x_0$ is a coprime to $M$ and the modulus $M$ is a product of two big primes $P$ and $Q$.

## Primes related notions

**Prime counting function $\pi(n)$.** Counts the number of prime numbers less than or equal to $n$.

$$\frac{n}{\ln n} < \pi(n) < 1.25506 \cdot \frac{n}{\ln n}, \text{ for } n > 16$$

**Euler's totient function $\varphi(n)$.** Counts the positive integers less than or equal to $n$ that are relatively prime (nesoudělná) to $n$.

**Mersenne prime $M_n$.** Mersenne prime $M_n$ is a prime in the form $2^n - 1$ for some $n > 1$.

## Randomized primality tests

**Fermat (little) theorem.** If $p$ is a prime and $0 < a < p$, then $a^{p - 1} \equiv 1 \modn[p]$.

**Miller-Rabin primality test.** If $p$ is a prime and $x^2 \equiv 1 \modn[p]$ then $x \equiv 1 \modn[p]$ or $x \equiv -1 \modn[p]$. Let $n > 2$ be a prime, $n - 1 = 2^r \cdot d$ where $d$ is odd, $1 <  a < n - 1$. Then either $a^d \equiv 1 \modn$ or $a^{2^s \cdot d} \equiv -1 \modn$ for some $0 \leq s \leq r - 1$.

Time complexity: $\mathcal{O}(k \log^3 n)$.
