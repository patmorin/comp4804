# Fingerprinting

Here we look at a family of algorithmic techniques collectively called *fingerprinting*.

## Freivald's Algorithm

* We have three $n\times n$ matrices, $A$, $B$, and $C$, and we want to check if
\[
   A \times B = C \enspace.
\]
* The obvious thing to do is to compute $A\times B$ ourselves and check if the
  result is correct
* The obvious matrix-multiplication algorithm takes $\Theta(n^3)$ time.
* Even the fastest (very complicated) algorithms take $\Theta(n^\omega)$ time where $\omega\approx 2.3728639$
* We want to do this in optimal $\Theta(n^2)$ time

The first thing to remember is that, for fixed $a,b\in\R$, $a\neq 0$, the equation $ax=b$ has exactly one solution for $x$ (namely $x=b/a$).
<div class="centered" markdown="1">
![a non-trivial linear equation in one variable has one solution](axb.svg)
</div>

Recall that the *dot product* of two vectors $v=(v_1,\ldots,v_n)$ and $w=(w_1,\ldots,w_n)$
is
\[
    v\cdot w = \sum_{i=1}^n v_i\times w_i \enspace .
\]

**Fingerprint Lemma:** Let $v=(v_1,\ldots,v_n)$ and $w=(w_1,\ldots,w_n)$ be two real-valued vectors with $v\neq w$,
and let $r=(r_1,\ldots,r_n)$ be a vector whose values are integers chosen uniformly and independently at random from ${1,\ldots,k}$.  Then
\[
    \Pr\{r\cdot v = r\cdot w\} \le 1/k \enspace .
\]

*Proof:* Since $v\neq w$, there is at least one index $k$ such that $v_i\neq w_i$. Now,
rewrite $r\cdot v = r\cdot w$ as
\[
    r_i(v_i-w_i) = \sum_{j\neq i} r_j(w_j - v_j) \enspace .
\]
With everything on the right-hand-side fixed, there is only one value of $r_i$
that satisfies this equation.  namely
\[
   r_i' = \frac{\sum_{j\neq i} r_j(w_j - v_j)}{v_i-w_i}
\]
But $r_i$ is chosen randomly from among $k$ different values, so the probability that $r_i=r_i'$ is at most $1/k$. &#8718;

We can think of $r\cdot v$ and $r\cdot w$ as the *fingerprints* of $v$ and $w$; they are small quantities (a single number) that is almost surely different if $v$ and $w$ are different.

Remember that we can multiply an $n$-vector $r$ by and $n\times n$ matrix $A$
in $O(n^2)$ time.  You can read the code right off the formula for vector-matrix matrix-multiplication:  If $x = rA$, then
\[
    x_i = \sum_{j=1}^n r_j A_{i,j}
\]

    :::pseudocode
    for i = 1 to n
      x[i] = 0
      for j = 1 to n
        x[i] = x[i] + r[j]*A[i][j]

The result of this multiplication is another $n$-vector.  That means we can compute
$r\times A\times b)$ in $O(n^2)$ time.  We can also compute $r\times C$ in $O(n^2)$ time.
Clearly, if $A\times B = C$, then $r\times A \times B = r\times C$.

**Lemma:** If $A\times B\neq C$, and a $r$ is chosen as above, then
\[
    \Pr\{rAB = rC\} \le 1/k
\]

*Proof:*  Let $X=AB$.  Then, since $X\neq C$, there must be some indices $i$ and $j$
such that $X_{i,j} \neq C_{i,j}$.  In particular, column $j$ of $X$ is not equal to column $j$ of $C$. But $(rX)_i$
is just the dot product of $r$ and column $j$ of $X$ and $(rC)_i$ is the dot product of column $j$ of $C$ with $r$.  Therefore, by the fingerprint lemma $\Pr\{(rAB)_i = (rC)_i\} \le 1/k$.  &#8718;

To summarize, we have an algorithm (*Freivald's Algorithm*) that runs in $\Theta(n^2)$ time and, given three $n\times n$ matrices $A$, $B$, and $C$ will:

* always return `true` if $A\times B=C$;
* return `false` with probability at least $1-1/k$ if $A\times B\neq C$
