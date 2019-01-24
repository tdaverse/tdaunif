#' @title Sample (with noise) from tori
#'
#' @description These functions generate uniform samples from configurations of
#'   tori of primary radius 1 in 3-dimensional space, optionally with noise.
#'
#' @details (Details.)

#' @name tori
#' @param n Number of observations.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @param r Radius (relative to unit primary radius).
#' @examples inst/examples/ex-tori.r
NULL

#' @rdname tori
#' @export
sample_torus <- function(n, r = .25, sd = 0) {
  phi <- stats::runif(n = n, min = 0, max = 2 * pi)
  theta <- torus_density_rejection_sample(n = n, r = r)
  res <- cbind(
    x = (1 + r * cos(theta)) * cos(phi),
    y = (1 + r * cos(theta)) * sin(phi),
    z = r * sin(theta)
  )
  if (sd != 0) res <- res + rmvunorm(n = n, d = 3, sd = sd)
  res
}

#' @rdname tori
#' @export
sample_tori_interlocked <- function(n, r = .25, sd = 0) {
  # split sample size
  ns <- as.vector(table(rbinom(n = n, size = 1, prob = .5)))
  # first torus, without noise
  res1 <- sample_torus(n = ns[1], r = r, sd = 0)
  res1 <- cbind(res1, z = 0)
  # second torus, without noise, offset to (1,0,0) and rotated pi/2 about x
  res2 <- sample_torus(n = ns[2], r = r, sd = 0)
  res2 <- cbind(x = res2[, 1] + 1, y = 0, z = res2[, 2])
  # combine tori
  res <- rbind(res1, res2)[sample(n), , drop = FALSE]
  # add noise
  if (sd != 0) res <- res + rmvunorm(n = n, d = 3, sd = sd)
}

# Diagonis, Holmes, & Shahshahani (2013)
# https://projecteuclid.org/euclid.imsc/1379942050
torus_density_rejection_sample <- function(n, r) {
  x <- c()
  while (length(x) < n) {
    theta <- stats::runif(n, 0, 2 * pi)
    dens_threshold <- stats::runif(n, 0, 1 / pi)
    dens_theta <- (1 + r * cos(theta)) / (2 * pi)
    x <- c(x, theta[dens_theta > dens_threshold])
  }
  x[1:n]
}
