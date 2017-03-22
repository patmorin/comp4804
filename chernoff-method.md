<div class="topic">
Chernoff's Bounding Method
</div>

Here are my original [hand-written notes](notes/chernoff/) and [more](notes/markov-chernoff.pdf) on this topic.

[TOC]

We have seen Chernoff's Bounds on a binomial$(p,n)$ random variable, $B$:
For any $0 < \epsilon < 1$,
\[
    \Pr\{B \ge (1+\epsilon)pn\} \le e^{-\epsilon^2pn/3} \enspace ,
\]
and
\[
    \Pr\{B \le (1-\epsilon)pn\} \le e^{-\epsilon^2pn/2} \enspace .
\]
How does one prove bounds like this?  

Remember Markov's Inequality:  For a non-negative random variable $X$,
\[
      \Pr\{X\ge t\E[X]\} \le 1/t \enspace .
\]
Markov's Inequality was easy to prove.  How does it compare?
Let's use Markov's Inequality in the format we've seen for Chernoff's bounds:
\[  \Pr\{B \ge (1+\epsilon)pn\} \le \frac{1}{1+\epsilon} \enspace . \]
Hmmm. For small values of $\epsilon$, that's nearly useless.  

So let's see how we can prove something like Chernoff's bounds.
The first thing we need is to understand what happens when we multiply two random variables

# Products of Independent Random variables


Linearity of expectation has been a powerful tools to study the sum of two (or more) random variables.  Is there an equivalent tool for studying the product of two random variables?

In general, the answer is no, unless the two variables in question are independent:

**Lemma:** If $X$ and $Y$ are two *independent* random variables, then
\[
    \E[X\times Y] = \E[X]\times\E[Y] \enspace .
\]

*Proof:*
\begin{alignstar}
   \E[X\times Y] & = \sum_{x}\sum_{y} x\times y \times\Pr\{X=x\cap Y=y\} \\
    & = \sum_{x}\sum_{y} x\times y \times\Pr\{X=x\}\times\Pr\{Y=y\}
           & \text{(because X and Y are independent)} \\
    & = \sum_{x}x\times \Pr\{X=x\}\times \sum_{y} y \times\Pr\{Y=y\} \\
    & = \left(\sum_{x}x\times \Pr\{X=x\}\right)\times \left(\sum_{y} y \times\Pr\{Y=y\}\right) \\
    & = \E[X]\times\E[Y] \enspace .
\end{alignstar}

Please *never forget* that this requires that $X$ and $Y$ are indepdent. It's not true in general.

# Amplifying Markov's Inequality


Chernoff's brilliant idea is to study a different random variable $Y$ that is defined in terms of $B$.  Let
\[
     Y = e^{\alpha B}
\]
and we'll pick a value of $\alpha$ later.  The idea now is that if $B$ is a little-bit bigger than its expected value, then $Y$ will be way bigger than its expected value, so Markov's Inequality, applied to $Y$ will give something more useful.

Remember that $B$ is the sum of $n$
independent Bernoulli$(p)$ random variables, $X_1,\ldots,X_n$, so
\[
     Y = e^{\alpha X_1+\alpha X_2 +\cdots+\alpha X_n}
       = e^{\alpha X_1}\times e^{\alpha X_2} \times\cdots\times e^{\alpha X_n}
      \enspace .
\]
Now, $X_1,\ldots,X_n$ are independent, so that means $e^{\alpha X_1},\ldots,e^{\alpha X_n}$ are independent.  We have the product of independent random variables, so we can figure out its expected value.
\[
    \E[Y] = \E[e^{\alpha X_1}]\times \E[e^{\alpha X_2}] \times\cdots\times \E[e^{\alpha X_n}] = (\E[e^{\alpha X_1}])^n
\]
Good, let's figure out $\E[e^{\alpha X_1}]$:
\[
    \E[e^{\alpha X_1}] = e^{0}(1-p) + e^{\alpha}p = 1+p(e^{\alpha}-1)
\]
Now we do something annoyingly common. We use the inequality $1+x \le e^x$:
\[
    \E[e^{\alpha X_1}] = 1+p(e^{\alpha}-1) \le e^{p(e^{\alpha}-1)}
\]
And we get
\[
    \E[Y] \le e^{np(e^{\alpha}-1)} \enspace .
\]

Finally, we're ready to go:
\begin{alignstar}
  \Pr\{B\ge (1+\epsilon)np\} & = \Pr\{Y\ge e^{\alpha(1+\epsilon)np}\} \\
   & \le \frac{\E[Y]}{e^{\alpha(1+\epsilon)np}} \\
   & \le \frac{e^{np(e^{\alpha}-1)}}{e^{\alpha(1+\epsilon)np}} \\
   & = \left(\frac{e^{e^{\alpha}-1}}{e^{\alpha(1+\epsilon)}}\right)^{np} \\
\end{alignstar}
Now we still get to pick $\alpha$.  If we take $\alpha=\ln(1+\epsilon)$, we get
\[
   \Pr\{B\ge (1+\epsilon)np\} \le
\left(\frac{e^{\epsilon}}{(1+\epsilon)^{(1+\epsilon)}}\right)^{np}
\]
This isn't exactly the version of Chernoff bounds we've seen (it's actually slightly stronger). With a little bit of bounding, and by assumping $0< \epsilon <1$ you can get the version we're used to.

That's how you get the tail bound, you use symmetry: You use the tail bound on a binomial$(1-p, n)$ random variable.


# Summary

What we just did is to use *Chernoff's bounding method* for bounding the sum of $n$ independent random variables $X_1,\ldots,X_n$:

0. Define $B=X_1+\cdots+X_n$
1. Determine (an upper bound on) $\mu_i=\E[e^{\alpha X_i}]$ for each $i\in\{1,\ldots,n\}$.
2. Now consider the random variable $Y=e^{\alpha B}$
3. Now use Markov:
\[
   \Pr\{B \ge k\} = \Pr\{Y \ge e^{\alpha k}\} \le \frac{\E[Y]}{e^{\alpha k}}
     = \frac{\mu_1\mu_2\cdots\mu_n}{e^{\alpha k}}
\]

There are lots of variations (even using different values of $\alpha$ for different $X_i$).  It's only limited by how messy the calculations get and by how difficult it is to bound $\mu_i$.
