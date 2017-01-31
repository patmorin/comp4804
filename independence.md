<div class="topic">
Conditional Probability and Dependence
</div>

Here are my original [hand-written notes](notes/indep/) on this topic.

[TOC]

# Conditional Probability

The following definition tells us the *conditional probability* of an event $A$ given some event $B$:
\begin{equation}
    \Pr\{A\mid B\} = \frac{\Pr\{A\cap B\}}{\Pr\{B\}} \label{conditional-i}
\end{equation}
Conditional probability answers questions like: "If I tell you that $B$ happened, then what is the probability that $A$ also happened?"

## Example: Rolling a six-sided die

Roll 1 six-sided die, $D$:

* To compute $\Pr\{D=3\mid \text{$D$ is odd}\}$, we have $A=\{3\}$, $B=\{1,3,5\}$, and $A\cap B =\{3\}$.
\[\Pr\{D=3\mid \text{$D$ is odd}\}
   = \frac{\Pr\{\text{$D=3$ and $D$ is odd}\}}{\Pr\{\text{$D$ is odd}\}}
   = \frac{1/6}{1/2} = 1/3
   \]

* To compute $\Pr\{\text{$D$ is prime}\mid\text{$D$ is odd}\}$ we have $A=\{2,3,5\}$, $B=\{1,3,5\}$ and $A\cap B=\{3,5\}$
\[\Pr\{\text{$D$ is prime}\mid\text{$D$ is odd}\} = \frac{2/6}{3/6} = 2/3 \]

* To compute $\Pr\{\text{$D$ is prime}\mid D\neq 3\}$ we have $A=\{2,3,5\}$, $B=\{1,2,4,5,6\}$ and $A\cap B=\{2,5\}$
\[\Pr\{\text{$D$ is prime}\mid D\neq 3\} = \frac{2/6}{5/6} = 2/5 \]

## Alternative Formulation of Conditional Probability
An equivalent formulation of \eqref{conditional-i} is obtained by multiplying both sides by $\Pr\{B\}$:
\begin{equation}
    \Pr\{A\cap B\} = \Pr\{B\}\times\Pr\{A\mid B\}  \label{conditional-ii}
\end{equation}
Equation&nbsp;\eqref{conditional-ii} is very useful because it gives us a formula for computing $\Pr\{A\cap B\}$ and it's also valid when $\Pr\{B\}=0$.

# Independence

Two events $A$ and $B$ are *independent* if and only if
\begin{equation}
   \Pr\{A\mid B\} = \Pr\{A\} \enspace . \label{independence-i}
\end{equation}
If $A$ and $B$ are not independent, then they are *dependent*.  Using \eqref{conditional-ii}, we get the following equivalent definition of independence: $A$ and $B$ are indpendent if and only if
\begin{equation}
   \Pr\{A\cap B\} = \Pr\{A\}\times\Pr\{B\} \enspace . \label{independence-ii}
\end{equation}
Note that this means that (in)dependence is *symmetric*: $A$ and $B$ are independent if and only if $B$ and $A$ are independent.

## Example: Tossing two coins

Toss a gold coin and a silver coin: $\Pr\{TT\} = \Pr\{TH\} = \Pr\{HT\} = \Pr\{HH\} = 1/4$.

Are the events $A=\text{"the gold coin is heads"}$ and $B=\text{"the silver coin is heads"}$ independent?
We have $A=\{HT,HH\}$, $B=\{TH,HH\}$, and $A\cap B=\{HH\}$ so
\[
  \Pr\{A\} = 2/4=1/2 \enspace ,
\]
and
\[
  \Pr\{\text{gold coin is heads}\mid \text{silver coin is heads}\}
    = \frac{1/4}{2/4} = 1/2 \enspace .
\]
So $\Pr\{A\} = \Pr\{A\mid B\}$ and these two events are independent.

## Example: Throwing two dice

Roll two dice, $D_1$ and $D_2$.

Let $A$ denote the event $D_1+D_2=7$ and let $B$ denote the event $D_1=4$.

From Lecture 1,
\[
   \Pr\{A\} = 6/36 = 1/6  \enspace .
\]
By definition
\[
  \Pr\{B\} = 1/6 \enspace .
\]
And
\[
   \Pr\{A\cap B\} = \Pr\{\text{$D_1=4$ and $D_2=3$}\} = 1/36 \enspace .
\]
So
\[
   $\Pr\{A\mid B\} = \frac{\Pr\{A\cap B\}}{\Pr\{B\}} = \frac{1/36}{1/6} = 1/6 = \Pr\{A\}
\]
So these two events are independent.

Rolling a 4 with the first die does not affect the probability that the sum of the two dice is 7.

## Another kind of symmetry

If $A$ and $B$ are independent, then so are $A$ and $\overline{B}=U\setminus B$:
\begin{alignstar}
   \Pr\{A\mid \overline{B}\}
    & = \frac{\Pr\{A\cap\overline{B}\}}{\Pr\{\overline{B}\}} \\
    & = \frac{\Pr\{A\}-\Pr\{A \cap B\}}{1-\Pr\{B\}} \\
    & = \frac{\Pr\{A\}-\Pr\{A\}\times\Pr\{B\}}{1-\Pr\{B\}} \text{ (using \eqref{independence-ii})}\\
    & = \frac{\Pr\{A\}(1-\Pr\{B\})}{1-\Pr\{B\}} \\
    & = \Pr\{A\}
    \end{alignstar}

So, in essence, we don't learn anything about $A$ when learn whether or not $B$ happened.

# Independent Sets of events

We know what it means for two events $A$ and $B$ to be independent, but we also need a definition for more than just two events.  

We say that a set of events $\{A_1,\ldots,A_n\}$ are *independent* if, for every $\{B_1,\ldots,B_r\}\subseteq\{A_1,\ldots,A_n\}$,
\[
   \Pr\{B_1\cap B_2\cap\cdots\cap B_r\} = \Pr\{B_1\}\times\Pr\{B_2\}\times\cdots\times\Pr\{B_r\} \enspace .
\]
This condition is time-consuming to check, so hopefully it's obvious in whatever application you're working on.

## Example: Sequential circuits

A *series circuit* fails when any one of its components fail.  If each of the $k$ components fails independently with probability $p$, then what is the probability that the circuit works?
\begin{alignstar}
  \Pr\{\text{circuit works}\}
     &= \Pr\{\text{$C_1$ doesn't fail and &hellip; and $C_k$ doesn't fail}\} \\
     &= (1-\Pr\{\text{$C_1$ fails}\}) \times \cdots\times (1-\Pr\{\text{$C_k$ fails}\}) \\
     &= (1-p)^k
\end{alignstar}

## Example: Parallel circuits

A *parallel circuit* fails when all of its components fail.  If each of the $k$ components fails independently with probability $p$, then what is the probability that the circuit works?
\begin{alignstar}
  \Pr\{\text{circuit fails}\}
     &= \Pr\{\text{$C_1$ fails and &hellip; and $C_k$ fails}\} \\
     &= p^k
\end{alignstar}
So the probability that the circuit works is $1-p^k$.

# Markov's Inequality

**Markov's Inequality:** Let $X$ be a random variable that only takes on non-negative values.  Then, for any $t>1$,
\[
    \Pr\{X \ge t\E[X]\} \le \frac{1}{t}
\]

The proof of Markov's Inequality is basically: "If it were not true, then $\E[X]$ would be bigger than $\E[X]$". The following proof formalizes this:

*Proof:* Let
\[
    Y = \begin{cases}0 & \text{if $X\le t\E[X]$}\\
                     t\E[X] & \text{otherwise}
    \end{cases}
\]
Notice that $Y\le X$ so $\E[Y] \le \E[X]$.  But we can compute $\E[Y]$ easily,
giving
\[
   \E[X] \ge \E[Y] = t\E[X]\times\Pr\{X\ge t\E[X]\} \enspace ,
\]
and dividing both sides by $t\E[X]$ gives,
\[
   1/t \ge \Pr\{X\ge t\E[X]\} \enspace ,
\]
as required. &#8718;

# An Example application

Suppose we have a randomized algorithm $\mathcal{A}$ whose expected running-time on inputs of size $n$ is at most $f(n)$.  Since running-times are non-negative, Markov's Inequality tells us that
\[
    \Pr\{\text{$\mathcal{B}$ runs for longer than $t f(n)$}\} \le 1/t \enspace .
\]
But we can do better!  Create a new algorithm $\mathcal{B}$ defined as follows:

* Run $\mathcal{A}$ for at most $2f(n)$ units of time
* If $\mathcal{A}$ doesn't finish, kill it and restart it

We assume that $\mathcal{A}$ makes new random choices each time it is restarted so that, for example, the probability that the first run of $\mathcal{A}$ runs longer than $2f(n)$ is independent of the probability that the second run of $\mathcal{A}$ runs for longer than $2f(n)$. Then, by Markov's Inequality and the independence of the runs of $\mathcal{A}$, we have for any even integer $t$,
\[
    \Pr\{\text{$\mathcal{B}$ runs for longer than $t f(n)$}\}
      \le (1/2)^{t/2} \enspace .
\]

Imagine a nuclear reactor control system that will cause a meltdown if the underlying algorithm runs longer than $500f(n)$. Then the best we can say about $\mathcal{A}$ is
\[
   \Pr\{\text{meltdown using $\mathcal{A}$}\} \le \frac{1}{500} \enspace .
\]
But for $\mathcal{B}$ we have
\[
   \Pr\{\text{meltdown using $\mathcal{B}$}\} \le 2^{-250} = \frac{1}{180925139433306555349329664076074856020734351040063381311652475012364265062}
\]
Which would you rather rely on?
