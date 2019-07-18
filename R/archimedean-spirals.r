#' @title Sample (with noise) from archimedean spirals
#'
#' @description These functions generate uniform samples from archimedean
#'   spirals in 2-dimensional space, optionally with noise.
#'
#' @details The archimedean spiral starts at the origin and wraps around itself
#'   such that distances between all the spiral branches are equivalent. The
#'   specific parametrization was taken from Koeller (2002). The uniform sample
#'   is generated through a rejection sampling process as described by Diaconis
#'   (2013).

#' @template ref-diaconis2013
#' @template ref-koeller2002
#' 

#' @name arch-spirals
#' @param n Number of observations.
#' @param min_wrap The wrap of the spiral from which sampling begins
#' @param max_wrap The wrap of the spiral where sampling ends
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-archimedean-spirals.r
NULL

#' @rdname arch-spirals
#' @export
sample_arch_spiral <- function(n, min_wrap = 0, max_wrap = 1, sd = 0){
  theta <- rs_spiral(n, min_wrap, max_wrap)
  #Applies modified theta values to parametric equation of spiral
  res <- cbind(
    x = (theta * cos(theta)),
    y = (theta * sin(theta))
  )
  #Adds Gaussian noise to the spiral
  add_noise(res, sd = sd)
}

#Rejection sampler
rs_spiral <- function(n, min_wrap, max_wrap){
  #Sets the minimum and maximum values of theta according to number of spirals
  #the user desired
  min_theta <- min_wrap * 2*pi
  max_theta <- max_wrap * 2*pi
  x <- c()
  #Keep looping until desired number of observations is achieved
  while(length(x) < n){
    theta <- runif(n, min_theta, max_theta)
    #Density threshold is the greatest jacobian value in the spiral, and the
    #area of least warping
    density_threshold <- runif(n, 0, max_theta)
    #Takes theta values that exceed the density threshold, and throws out the
    #rest
    x <- c(x, theta[theta > density_threshold])
  }
  x[1:n]
}
