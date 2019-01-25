#' @title Sample (with noise) from a Klein bottle
#'
#' @description This function generates uniform samples from a Klein bottle in
#'   4-dimensional space, optionally with noise.
#'
#' @details (Details.)

#' @name klein-bottle
#' @param n Number of observations.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @examples inst/examples/ex-klein-bottle.r
NULL

#' @rdname klein-bottle
#' @export
sample_klein <- function(n, r = .25, sd = 0) {
  phi <- stats::runif(n = n, min = 0, max = 2 * pi)
  theta <- drs_klein(n = n, r = r)
  res <- cbind(
    w = (1 + r * cos(theta)) * cos(phi),
    x = (1 + r * cos(theta)) * sin(phi),
    y = r * sin(theta) * cos(phi / 2),
    z = r * sin(theta) * sin(phi / 2)
  )
  if (sd != 0) res <- res + rmvunorm(n = n, d = 4, sd = sd)
  res
}

# density rejection sample for a Klein bottle (Mobius tube parameterization)
# https://projecteuclid.org/euclid.imsc/1379942050
drs_klein <- function(n, r) {
  x <- c()
  while (length(x) < n) {
    theta <- stats::runif(n, 0, 2 * pi)
    jacobian <- jint_klein(r)
    area_jacobian <- integrate(jacobian, 0, 2 * pi)$value
    dens_theta <- sapply(theta, jacobian) / area_jacobian
    max_dens <- jacobian(0) / area_jacobian
    dens_threshold <- stats::runif(n, 0, max_dens)
    x <- c(x, theta[dens_theta > dens_threshold])
  }
  x[1:n]
}

# integral of Klein bottle Jacobian over minor angle
jint_klein <- function(r) {
  function(x) r * sqrt((1 + r * cos(x)) ^ 2 + (.5 * r * sin(x)) ^ 2)
}
