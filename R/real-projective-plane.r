#' @title Sample (with noise) from real projective planes
#'
#' @description These functions generate uniform samples from real projective
#'   planes in 4-dimensional space, optionally with noise.
#'
#' @details The real projective plane only embeds into a Euclidean space of
#'   dimension at least 4. This embedding is adapted from
#'   [Wikipedia](https://en.wikipedia.org/wiki/Real_projective_plane#Embedding_into_4-dimensional_space).
#'   The uniform sample is generated through a rejection sampling process as
#'   described by Diaconis, Holmes, and Shahshahani (2013).

#' @template ref-diaconis2013
#' 

#' @name real-projective-planes
#' @param n Number of observations.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-real-projective-planes.r
NULL

#' @rdname real-projective-planes
#' @export
sample_projective_plane <- function(n, sd = 0) {
  theta <- runif(n, 0, 2*pi)
  phi <- runif(n, 0, pi)
  sincosphi <- sin(phi) * cos(phi)
  sinsqphi <- sin(phi) ^ 2
  res <- cbind(
    x = cos(theta) * sincosphi,
    y = sin(theta) * sincosphi,
    z = (cos(theta)^2 - sin(theta)^2) * sinsqphi,
    w = 2 * sin(theta) * cos(theta) * sinsqphi
  )
  add_noise(res, sd = sd)
}

# Rejection sampler for a real projective plane
rs_projective_plane <- function(n, r) {
  x <- c()
  while (length(x) < n) {
    theta <- runif(n, 0, 2*pi)
    phi <- runif(n, 0, pi)
    jacobian <- jd_projective_plane(r)
    jacobian_phi <- jacobian(phi)
    density_threshold <- runif(n, 0, jacobian(0))
    x <- c(x, phi[jacobian_phi > density_threshold])
  }
  x[1:n]
}

# Jacobian determinant of real projective plane with respect to minor angle
# (no aspect ratio)
jd_projective_plane <- function(r) {
  function(phi) sqrt( sin(phi)^2 * (3 * sin(phi)^2 + 1) )
}
