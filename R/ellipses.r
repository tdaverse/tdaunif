#' @title Sample (with noise) from ellipses
#'
#' @description These functions generate uniform samples from configurations of
#'   ellipses of major or minor radius 1 in 2- or 3-dimensional space,
#'   optionally with noise.
#'
#' @details
#'
#' The function `sample_ellipse()` uses the usual sinusoidal parameterization
#' from the unit interval to an ellipse with radii 1 and `1/ar`. The uniform
#' sample is generated through a rejection sampling process as described by
#' Diaconis, Holmes, and Shahshahani (2013).
#' 

#' @name ellipses
#' @param n Number of observations.
#' @param ar Aspect ratio for an ellipse (ratio of major and minor radii).
#' @param width Width of the cylinder (with respect to the fixed radius of the
#'   ellipse).
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-ellipses.r
NULL

#' @rdname ellipses
#' @export
sample_ellipse <- function(n, ar = 1, sd = 0) {
  r <- 1/ar
  theta <- rs_ellipse(n, r)
  res <- cbind(x = cos(theta), y = r * sin(theta))
  add_noise(res, sd = sd)
}

# rejection sampler for an ellipse
rs_ellipse <- function(n, r) {
  x <- c()
  while (length(x) < n) {
    theta <- runif(n, 0, 2*pi)
    jacobian <- jd_ellipse(r)
    jacobian_theta <- jacobian(theta)
    density_threshold <- runif(n, 0, max(jacobian(0), jacobian(pi/2)))
    x <- c(x, theta[jacobian_theta > density_threshold])
  }
  x[1:n]
}

# Jacobian determinant of ellipse with respect to minor radius
jd_ellipse <- function(r) {
  function(theta) sqrt((sin(theta)^2 + (r * cos(theta))^2))
}

#' @rdname ellipses
#' @export
sample_cylinder_elliptical <- function(n, ar = 1, width = 1, sd = 0) {
  #Samples uniformly from an ellipse on which the cylinder is based
  res <- sample_ellipse(n = n, ar = ar, sd = 0)
  #Augments the ellipse sample with a third coordinate uniformly sampled over
  #the fixed range `width`
  res <- cbind(res, z = runif(n, 0, width))
  #Adds Gaussian noise to the spiral
  add_noise(res, sd = sd)
}
