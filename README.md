
[![Travis build
status](https://travis-ci.org/corybrunson/tdaunif.svg?branch=master)](https://travis-ci.org/corybrunson/tdaunif)

# **tdaunif**: Uniform manifold samplers for topological data analysis

This R package consists mainly of sampling functions for topological
manifolds embedded in Euclidean space.

## motivation

### consolidation

Statistical topology, or topological data analysis (TDA), includes a
variety of methods for detecting topological structure from point cloud
data sets, most famously persistent homology. (See [Weinberger
(2011)](https://www.ams.org/notices/201101/rtx110100036p.pdf) for a
brief introduction.) These methods are validated by applying them to
point clouds sampled from spaces with known topology. Functions that
generate such samples are therefore valuable to developers of TDA
software.

Unfortunately, such samplers are not currently easy to find, at least
for R users. Handfuls can be found in several different packages, but no
single package or code repository has assembled a large collection for
convenient use. That is the goal of this package.

### uniformity

The simplest validations use points sampled uniformly from the surfaces
of manifolds embedded in Euclidean space. Uniformity here is with
respect to the surface area of the embedded manifold, but such uniform
sampling is not trivial to do when the manifold can only be expressed
via parameterization from a simpler parameter space, as when [a square
is rolled and bent into a
torus](https://en.wikipedia.org/wiki/Torus#Flat_torus). Uniform sampling
on the parameter space may then produce uneven sampling on the manifold,
regions of greater compression being oversampled relative to regions of
greater expansion. One especially important motivation for this package
is therefore to include uniform samplers for popular embeddings of
topological manifolds, including functions that allow users to build
their own with minimal effort (see `help(manifold, package =
"tdaunif")`).

## usage

### installation

**tdaunif** is not yet on CRAN, but you can install it from GitHub using
[the **remotes** package](https://github.com/r-lib/remotes):

``` r
remotes::install_github("corybrunson/tdaunif")
```

### illustration

[An intuitive embedding of the Klein bottle
into 4-space](https://en.wikipedia.org/wiki/Klein_bottle#3D_pinched_torus_/_4D_M%C3%B6bius_tube)
is adapted from the popular “donut” embedding of the torus in 3-space.
In **tdaunif** this is called the “tube” parameterization. We can sample
uniformly from this embedding (without noise) and examine the coordinate
projections as follows:

``` r
set.seed(0)
x <- sample_klein_tube(n = 360, ar = 3, sd = 0)
pairs(x, asp = 1, pch = 19, cex = .5)
```

![](man/figures/README-klein%20bottle-1.png)<!-- -->

Compare these neat projections to those of the same sample with noise
added in the ambient Euclidean space:

``` r
x <- add_noise(x, sd = .2)
pairs(x, asp = 1, pch = 19, cex = .5)
```

![](man/figures/README-klein%20bottle%20with%20noise-1.png)<!-- -->

For a thorough discussion of this sampler, see [my blog
post](https://corybrunson.github.io/2019/02/01/uniform-sample-embedded-klein-bottle/)
describing the method presented in [Diaconis, Holmes, and Shahshahani
(2013)](https://projecteuclid.org/euclid.imsc/1379942050).