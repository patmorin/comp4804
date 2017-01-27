<div class="topic">
Randomized Min-Cut Algorithms
</div>

Here are my original [hand-written notes](notes/min-cut.pdf) on this topic.

[TOC]

# The Min-Cut Problem

Throughout, $G=(V,E)$ is an undirected graph that is not necessarily simple. It may have multiple edge between vertices, but it has no self-loops.  The graph $G$ has $n$ vertices and $m$ edges.

A *cut* of $G$ is a set of edges whose removal disconnects $G$.  A *min-cut* is a cut of minimum cardinality; we denote the size of a min-cut of $G$ as $c(G)$. The *MinCut Problem* asks us to find a *min-cut* of $G$ (or at least to determine its size).

The following lemma gives an easy upper-bound on the size of a min-cut.

**Lemma 1:** $c(G) \le 2m/n$.

*Proof:* The total degree of all vertices in $G$ is $2m$. By the pigeonhole principle, some vertex $v\in V$ has degree $d(v)\le 2m/n$. The edges incident to $v$ form a cut of size $d(v)\le 2m/n$. &#8718;

**Corollary 1:** Let $C$ be some min-cut of $G$ and select some edge $e$ uniformly at random from among all edges of $G$.  Then $\Pr\{e\in C\}\le 2/n$.

*Proof:* By Lemma 1, $|C|\le 2m/n$, so
\[ \Pr\{e\in C\} = \frac{|C|}{m} \le \frac{2m/n}{m} = 2/n \enspace . \]
&#8718;


# Edge Contraction



We define an edge contraction &hellip;
