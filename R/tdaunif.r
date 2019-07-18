#' @title `tdaunif`: Uniform manifold samplers for topological data analysis
#'
#' @description Generate uniform random samples from embedded manifolds,
#'   optionally with noise.
#'
#' @details This package assembles functions that generate samples of points
#'   from the surfaces of a manifold embedded via parameterization in an ambient
#'   Euclidean space according to a uniform probability distribution over the
#'   manifold surface. This can be contrasted with sampling uniformly from the
#'   parameter space and mapping the sampled points to the ambient space.
#'   Additionally, Gaussian noise in the ambient space can be added to any
#'   sample.
#'
#'   Several samplers use rejection sampling as illustrated by Diaconis, Holmes,
#'   and Shahshahani (2013).
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
NULL
