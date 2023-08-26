#' @title **tdaunif**: Uniform manifold samplers for topological data analysis
#'
#' @description Generate uniform random samples from embedded manifolds,
#'   optionally with noise.
#'
#' @details
#'
#' This package assembles functions that generate samples of points uniformly
#' from the surfaces of embedded manifolds. An _embedding_ is a one-to-one
#' continuous map \eqn{f:M\to X} from a manifold \eqn{M} to a Euclidean
#' coordinate space \eqn{X}, and each function relies on a _parameterization_ of
#' \eqn{M} given by a continuous bijective function \eqn{p:S\to f(M)} that may
#' identify some points of \eqn{s} (boundary or interior) to produce the
#' topology of \eqn{M}. (This means that the inverse of \eqn{p} may not be
#' continuous.)
#'
#' Sampling points \eqn{P} uniformly from \eqn{S} and mapping the sample to
#' \eqn{f(M)} may produce a non-uniform sample \eqn{p(P)} due to differences in
#' the local sampling rate per unit interior (length, area, volume, etc.),
#' quantified as the Jacobian (higher-order derivative) of \eqn{p}. **tdaunif**
#' uses two techniques to correct for this:
#' 

#' * The more numerical (brute-force) technique is to compute the Jacobian on
#' the parameter space and oversample locally at a rate proportional to the
#' Jacobian. This oversampling is done via rejection sampling as illustrated by
#' Diaconis, Holmes, and Shahshahani (2013).

#' * The more analytic technique is to invert the Jacobian symbolically in order
#' to define an interior-preserving parameterization \eqn{q:S\to f(M)}, as
#' illustrated for 2-manifolds by Arvo (2001). Sampling \eqn{P} uniformly on
#' \eqn{S} then produces a uniform sample \eqn{q(P)} on \eqn{f(M)}. The
#' interior-preserving map also enables stratified sampling on the manifold via
#' stratification of the parameter space.

#' 
#' Multivariate Gaussian noise in the coordinate space can be added to any
#' sample.
#' 

#' @template ref-arvo2001
#' @template ref-diaconis2013
#' 

#' @docType package
#' @author Jason Cory Brunson
#' @author Brandon Demkowicz
#' @author Sanmati Choudhary
#' @importFrom stats runif
#' @name tdaunif
#' @aliases tdaunif-package
NULL
