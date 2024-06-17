#' @title Sample (with noise) from Möbius strips
#'
#' @description These functions generate uniform samples from Möbius strips in
#'   3-dimensional space, optionally with noise.
#'
#' @details
#'
#' The function `sample_mobius_rotoid()` uses the rotoid Möbius surface
#' parameterization obtained from the now-defunct Encyclopédie des Formes
#' Mathématiques Remarquables. Uniform samples are generated through a rejection
#' sampling process as described by Diaconis, Holmes, and Shahshahani (2013).
#' The Jacobian determinant was symbolically computed and simplified using
#' _Mathematica_ v13.3.1.0.
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
  t_theta <- rs_mobius_rotoid(n, r)
  res <- cbind(
    x = (1 + r * t_theta[, 1L] * cos(t_theta[, 2L])) * cos(2 * t_theta[, 2L]),
    y = (1 + r * t_theta[, 1L] * cos(t_theta[, 2L])) * sin(2 * t_theta[, 2L]),
    z = r * t_theta[, 1L] * sin(t_theta[, 2L])
  )
  add_noise(res, sd = sd)
}

# Rejection sampler for a Möbius strip (rotoid parameterization)
rs_mobius_rotoid <- function(n, r) {
  x <- matrix(NA_real_, nrow = 0L, ncol = 2L)
  while (nrow(x) < n) {
    t <- runif(n, -1, 1)
    theta <- runif(n, 0, 2*pi)
    jacobian <- jd_mobius_rotoid(r)
    jacobian_t_theta <- jacobian(t, theta)
    density_threshold <- runif(n, 0, jacobian(0, 0))
    x <- rbind(x, cbind(
      t[jacobian_t_theta > density_threshold],
      theta[jacobian_t_theta > density_threshold]
    ))
  }
  x[1:n, , drop = FALSE]
}

# Jacobian determinant of rotoid Möbius strip with respect to minor angle
jd_mobius_rotoid <- function(r) {
  function(t, theta) {
    sintheta <- sin(theta)
    costheta <- cos(theta)
    radicand <- 
      4 * r ^ 2 +
      3 * r ^ 4 * t ^ 2 +
      8 * r ^ 3 * t * costheta +
      2 * r ^ 4 * t ^ 2 * ( costheta ^ 2 - sintheta ^ 2 )
    sqrt(radicand)
  }
}
