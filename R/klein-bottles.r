#' @title Sample (with noise) from Klein bottles
#'
#' @description These functions generate uniform samples from Klein bottles in
#'   4-dimensional space, optionally with noise.
#'
#' @details (Details.)

#' @name klein-bottles
#' @param n Number of observations.
#' @param ar Aspect ratio for Möbius tube Klein bottle (ratio of major and minor
#'   radii) or flat torus-based Klein bottle (ratio of scale factors).
#' @param bump Bump constant for the flat torus-based Klein bottle.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @examples inst/examples/ex-klein-bottle.r
NULL

#' @rdname klein-bottles
#' @export
sample_klein_tube <- function(n, ar = 2, sd = 0) {
  r <- 1/ar
  theta <- rs_klein_tube(n, r)
  phi <- stats::runif(n, 0, 2*pi)
  res <- cbind(
    w = (1 + r * cos(theta)) * cos(phi),
    x = (1 + r * cos(theta)) * sin(phi),
    y = r * sin(theta) * cos(phi/2),
    z = r * sin(theta) * sin(phi/2)
  )
  if (sd != 0) res <- res + rmvunorm(n = n, d = 4, sd = sd)
  res
}

#' @rdname klein-bottles
#' @export
sample_klein <- sample_klein_tube

# rejection sampler for a Klein bottle (Mobius tube parameterization)
# https://projecteuclid.org/euclid.imsc/1379942050
rs_klein_tube <- function(n, r) {
  x <- c()
  while (length(x) < n) {
    theta <- stats::runif(n, 0, 2*pi)
    jacobian <- jd_klein_tube(r)
    jacobian_theta <- jacobian(theta)
    density_threshold <- stats::runif(n, 0, jacobian(0))
    x <- c(x, theta[jacobian_theta > density_threshold])
  }
  x[1:n]
}

# Jacobian determinant of Klein bottle with respect to minor angle
jd_klein_tube <- function(r) {
  function(theta) r * sqrt((1 + r * cos(theta)) ^ 2 + (.5 * r * sin(theta)) ^ 2)
}

#' @rdname klein-bottles
#' @export
sample_klein_flat <- function(n, ar = 1, bump = .1, sd = 0) {
  theta <- stats::runif(n, 0, 2*pi)
  phi <- rs_klein_flat(n, ar, bump)
  res <- cbind(
    w = cos(theta/2) * cos(phi) - sin(theta/2) * sin(2*phi),
    x = sin(theta/2) * cos(phi) - cos(theta/2) * sin(2*phi),
    y = ar * cos(theta) * (1 + bump * sin(phi)),
    y = ar * sin(theta) * (1 + bump * sin(phi))
  )
  if (sd != 0) res <- res + rmvunorm(n = n, d = 4, sd = sd)
  res
}

# rejection sampler for a Klein bottle (flat torus-based parameterization)
# https://projecteuclid.org/euclid.imsc/1379942050
rs_klein_flat <- function(n, p, e) {
  x <- c()
  while (length(x) < n) {
    phi <- stats::runif(n, 0, 2*pi)
    jacobian <- jd_klein_flat(p, e)
    jacobian_phi <- jacobian(phi)
    density_threshold <- stats::runif(n, 0, jacobian(0))
    x <- c(x, phi[jacobian_phi > density_threshold])
  }
  x[1:n]
}

# Jacobian determinant of Klein bottle with respect to aspect ratio and bump
jd_klein_flat <- function(p, e) {
  function(phi) {
    sinphi <- sin(phi)
    cosphi <- cos(phi)
    sqsinphi <- sinphi^2
    sqcosphi <- cosphi^2
    sin2phi <- sin(2*phi)
    cos2phi <- cos(2*phi)
    sqsin2phi <- sin2phi^2
    sqcos2phi <- cos2phi^2
    .25 * sqsinphi * sqsin2phi +
      .25 * sqsinphi * sqcosphi +
      sqsin2phi * sqcos2phi +
      sqcosphi * sqcos2phi +
      p^2 * (1 + e*sinphi)^2 * (sqsinphi + 4*sqcos2phi) +
      p^2 * (e^2)*sqcosphi * (.25*sqcosphi + .25*sqsin2phi) +
      p^4 * (1 + e*sinphi)^2 * (e^2)*sqcosphi -
      4 * sqcosphi * sqcos2phi -
      2 * sinphi * cosphi * sin2phi * cos2phi -
      .25 * sqsinphi * sqsin2phi
  }
}
