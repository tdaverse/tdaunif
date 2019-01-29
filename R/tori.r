#' @title Sample (with noise) from tori
#'
#' @description These functions generate uniform samples from configurations of
#'   tori of primary radius 1 in 3-dimensional space, optionally with noise.
#'
#' @details (Details.)

#' @name tori
#' @param n Number of observations.
#' @param ar Aspect ratio for tube torus (ratio of major and minor radii) or
#'   flat torus (ratio of scale factors).
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @examples inst/examples/ex-tori.r
NULL

#' @rdname tori
#' @export
sample_torus_tube <- function(n, ar = 2, sd = 0) {
  r <- 1/ar
  theta <- rs_torus_tube(n = n, r = r)
  phi <- stats::runif(n = n, min = 0, max = 2*pi)
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
sample_torus <- sample_torus_tube

# rejection sampler for a torus (conventional parameterization)
# https://projecteuclid.org/euclid.imsc/1379942050
rs_torus_tube <- function(n, r) {
  x <- c()
  while (length(x) < n) {
    theta <- stats::runif(n, 0, 2*pi)
    jacobian_theta <- (1 + r * cos(theta)) / (2*pi)
    density_threshold <- stats::runif(n, 0, 1/pi)
    x <- c(x, theta[jacobian_theta > density_threshold])
  }
  x[1:n]
}

#' @rdname tori
#' @export
sample_tori_interlocked <- function(n, ar = 2, sd = 0) {
  r <- 1/ar
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

#' @rdname tori
#' @export
sample_torus_flat <- function(n, ar = 1, sd = 0) {
  theta <- stats::runif(n = n, min = 0, max = 2*pi)
  phi <- stats::runif(n = n, min = 0, max = 2*pi)
  res <- cbind(
    w = cos(theta),
    x = sin(theta),
    y = ar * cos(phi),
    z = ar * sin(phi)
  )
  if (sd != 0) res <- res + rmvunorm(n = n, d = 4, sd = sd)
  res
}
