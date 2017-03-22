<div class="topic">
Chernoff's Bounds
</div>

Here are my original [hand-written notes](notes/chernoff/) and [more](notes/markov-chernoff.pdf) on this topic.

[TOC]

A *Bernoulli($p$)* random variable is a random variable that takes on a 1 with probability $p$ and a 0 with probability $1-p$.

If $X$ is Bernoulli($p$), then
\[
    \E[X] = p\cdot 1 + (1-p)0 = p \enspace .
\]
(These are named after [Jacob Bernoulli](https://en.wikipedia.org/wiki/Jacob_Bernoulli), a mathematician who lived in the 16-1700s.)

A *binomial($p,n$)* random variable is the sum of $n$ independent Bernoulli($p$) random variables.
\[
    B = X_1+X_2+\cdots + X_n
\]
If $B$ is a binomial$(p,n)$, then,
\[
   \E[B] = \E\left[\sum_{i=1}^n X_i\right] = \sum_{i=1}^n \E[X_i] = pn \enspace .
\]


# The Distribution of Binomial Random variables

A binomial random variable takes on values in $\{0,\ldots,n\}$, but the distribution is clearly not uniform.  In fact,
\[
    \Pr\{B=i\} = \binom{n}{i}p^i(1-p)^{n-i} \enspace ,
\]
but this is kind of awkward to work with.  (Try computing $\E[B]$ without using
linearity of expectation and you'll understand.)

Chernoff's Bounds give us estimates on the probability that a binomial$(n,p)$ is far from its expected value.  For any $0 < \epsilon < 1$,
\[
    \Pr\{B \ge (1+\epsilon)pn\} \le e^{-\epsilon^2pn/3} \enspace ,
\]
and
\[
    \Pr\{B \le (1-\epsilon)pn\} \le e^{-\epsilon^2pn/2} \enspace .
\]
Notice that these probability get exponentially small in $n$.

# Application: Estimating Sample Sizes

Suppose we have $n$ elements and we sample each element indpendently with probabilty $1/2$.  If $B$ is the number of samples, then $B$ is a binomial$(1/2,n)$ random variable, so  $\E[B] = n/2$.

It might be a problem if we have too many samples (maybe we don't have enough memory).  Chernoff covers this:
\[
    \Pr\{B \ge (1+\epsilon) n/2\} \le e^{-\epsilon^2 n/6}
\]

It might be a problem if we have too few samples (maybe some calculation will be
incorrect).  Chernoff covers this too:
\[
    \Pr\{B \le (1-\epsilon) n/2\} \le e^{-\epsilon^2 n/4}
\]

So the sample size is very close to $n/2$ with probability very close to 1.


# Application: Monte-Carlo Integral Evaluation

Suppose we have some weird function $f(x)$. We know $1/2\le f(x)\le 1$ for all $x\in[0,1]$.  We know how to evaluate $f(x)$, but it's so weird we don't know how to integrate it.

Evaluating the integral $\int_0^1 f(x)\, dx$ is the same as asking for the area under the curve defined by $f(x)$.  Here's an algorithm:

0. $C\gets 0$
1. Pick $(x,y)$ uniformly at random in the unit square $[0,1]^2$.
2. If $f(x) > y$ then add 1 to $C$
3. Repeat steps 1 and 2 $k=c\ln n$ times
4. Output $C/k$

Observe that $C$ is a binomial$(p,n)$ random variable where $p=\int_0^1 f(x)\, dx$ is exactly the value we are trying to compute. And, by assumption, $p>1/2$.  So, by Chernoff's bounds:
\[
    \Pr\{C \ge (1+\epsilon)pk\} \le e^{-\epsilon^2 pk/3} \le e^{-\epsilon^2 c\ln n/6} = n^{-\epsilon^2 c/6}
\]
and
\[
    \Pr\{C \le (1-\epsilon)pk\} \le e^{-\epsilon^2 pk/2} \le e^{-\epsilon^2 c\ln n/4} = n^{-\epsilon^2 c/4}  \enspace .
\]

# Application: Randomized Binary Search

&hellip;
