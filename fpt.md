<div class="topic">
Fixed-Parameter Tractable Algorithms
</div>

Let $G=(V,E)$ be a (simple undirected) graph with $n$ vertices and $m$ edges. We say that a set $C\subseteq V$ is a *vertex-cover* of $G$ if, for every edge $uw\in E$, at least one of $u$ or $w$ is in $C$. The *Vertex-Cover* problem is:

* Input: A (simple undirected) graph $G=(V,E)$ and an integer $k\ge 0$.
* Output: Determine if $G$ has a vertex cover of size at most $k$.

The Vertex-Cover problem is NP-complete, so we won't find a polynomial-time
algorithm that solves it exactly.  Instead, we'll settle for an algorithm that is fast when $k$ is small

**Exercise:** Find a algorithm for Vertex-Cover with running time $O(n^{k+1})$.

That's an easy exercise&mdash;just enumerate all $\binom{n}{k}$ subsets of vertices of size $k$ and test each one to see if it's a vertex cover.  Let's aim for something better: An algorithm whose running time is $O(n\times 2^k)$ (instead of the $O(n\times n^k))$ that the exercise asks for.

# A simple FPT algorithm for Vertex-Cover

We start with the following simple observation (which is actually just the definition of a vertex-cover):

**Observation 1:** For each edge $uw$ of $G$, any vertex-cover of $G$ contains at
least one of $u$ or $w$.

This observation is the basis of a recursive algorithm for Vertex-Cover that makes only two recursive calls per invocation:

1. VertexCoverFPT$(G, k)$
    1. if $G$ has no edges then return true
    2. if $k=0$ then return false
    3. let $uw$ be some edge of $G$
    4. if VertexCoverFPT$(G-u, k-1)$ then return true
    5. if VertexCoverFPT$(G-w, k-1)$ then return true
    6. return false

This algorithm is clearly correct when $k=0$.  To prove that it's correct for $k>0$ we can use induction and Observation 1: If $G$ has a vertex-cover $C$ of size $k$, then
this cover contains at least one of $u$ or $w$.  If $C$ contains $u$, then the first recursive call will return true.  If $C$ contains $w$ (but not $u$) then the second recursive call will return true.  Otherwise, if $G$ has no vertex cover of size $k$ then the algorithm returns false.

Using the right representation of the graph $G$, it's fairly easy to implement this algorithm so that each recursive invocation runs in $O(n)$ time.  To understand the total running-time (including all recursive invocations) we need only to notice that the recursion tree is a complete binary tree of height $k$, so it has $2^k$ leaves and $2^{k-1}$ internal nodes, each of which contributes $O(n)$ to the running time fo the algorithm, so the overall running-time is
\[
     (2^k + 2^k-1)\times O(n) = O(n\times 2^k) \enspace .
\]

**Theorem 1:** There is an algorithm for Vertex-Cover that has running-time $O(n\times 2^k)$.

Theorem 1 is nice. For example, if k=10$ and $n=1,000,000$, then the running-time of the algorithm is on the order of 1,000,000,000.  This would take maybe a few seconds on a modern computer.  Now let's see if we can do better still.

# Kernelization

The idea behind kernelization is that we can preprocess $G$ using a fast (polynomial-time) algorithm to make it smaller, before we call VertexCoverFPT.  It's based on a couple of simple observations:

**Observation 2:**  If $G$ has a vertex $u$ of degree greater than $k$ and $C$ is a vertex-cover of $G$ with $|C|\le k$, then $u\in C$.

*Proof:* If $C$ doesn't include $u$ then it has to include all its neighbours, but $u$ has more than $k$ neighbours. &#8717;

So, let $C_0$ be the subset of vertices in $G$ that have degree greater than $k$.  Then $G$ has a vertex-cover of size at most $k$ if and only if $G'=G-C_0$ has a vertex-cover of size at most $k'=k-|C_0|$.  Now, the graph $G'$ is interesting, because it has no vertex of degree greater than $k$.

**Lemma:** If $G'$ has more than $kk'$ edges then $G'$ has no vertex cover of size $k'$.

*Proof:* Each vertex of $G'$ can cover at most $k$ edges so we certainly can't cover more than $kk'$ edges using only $k'$ vertices. &#8717;

Finally, let $G''$ be the graph that we get when we remove isolated vertices from $G'$, and we run VertexCoverFPT$(G'',k-|C_0|)$.  To summarize:

1. Let $C_0$ be the vertices of $G$ of degree greater than $k$
2. If $|C_0|>k$ then return false
3. Let $G'=G-C_0$ and let $k'=k-|C_0|$
4. If $G'$ has more than $kk'$ edges then return false
5. Let $G''$ be obtained by removing isolated vertices from $G$
6. return VertexCoverFPT$(G'',k-|C_0|)$

Except for the Step 6, each of these steps can be implemented in $O(n+m)$ time.  Now, the graph $G''$ has no isolated vertices and at most $kk'\le k^2$ edges, so it has at most $2k^2$ vertices.  Therefore, Step 6 runs in time $O(k^2\times 2^k)$ time.

**Theorem 2:** There is an algorithm for Vertex-Cover that has running-time $O(n+m+k^22^k)$.

This algorithm is exponential, but only in $k$.  It can handle big graphs, it's only limited by the value of $k$.  It could, for example, easily handle a graph with 400 million edges and $k=20$.
