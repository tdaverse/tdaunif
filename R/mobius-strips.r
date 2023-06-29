#' @title Sample (with noise) from Möbius strips
#'
#' @description These functions generate uniform samples from Möbius strips in
#'   3-dimensional space, optionally with noise.
#'
#' @details
#'
#' The function `sample_mobius_rotoid()` uses the rotoid Möbius surface
#' parameterization documented at the [Encyclopédie des Formes Mathématiques
#' Remarquables](https://mathcurve.com/surfaces.gb/mobiussurface/mobiussurface.shtml).
#' Uniform samples are generated through a rejection sampling process as
#' described by Diaconis, Holmes, and Shahshahani (2013).
#' 

#' @template ref-diaconis2013
#' 

#' @name mobius-strips
#' @param n Number of observations.
#' @param ar Aspect ratio for rotoid Möbius surface (ratio of major to minor
#'   radii).
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-mobius-strips.r
NULL

#' @rdname mobius-strips
#' @export
sample_mobius_rotoid <- function(n, ar = 2, sd = 0) {
  r <- 1/ar
  t <- runif(n, -1, 1)
  theta <- rs_mobius_rotoid(n, r)
  res <- cbind(
    x = (1 + r * t * cos(theta)) * cos(2 * theta),
    y = (1 + r * t * cos(theta)) * sin(2 * theta),
    z = r * t * sin(theta)
  )
  add_noise(res, sd = sd)
}

# Rejection sampler for a Möbius strip (rotoid parameterization)
rs_mobius_rotoid <- function(n, r) {
  x <- c()
  while (length(x) < n) {
    theta <- runif(n, 0, 2*pi)
    jacobian <- jd_mobius_rotoid(r)
    jacobian_theta <- jacobian(theta)
    density_threshold <- runif(n, 0, jacobian(0))
    x <- c(x, theta[jacobian_theta > density_threshold])
  }
  x[1:n]
}

# Jacobian determinant of rotoid Möbius strip with respect to minor angle
jd_mobius_rotoid <- function(r) {
  function(theta) stop("We need to compute the Jacobian!")
}
