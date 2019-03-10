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
#' @example inst/examples/ex-tori.r
NULL

#' @rdname tori
#' @export
sample_torus_tube <- function(n, ar = 2, sd = 0) {
  r <- 1/ar
  theta <- rs_torus_tube(n = n, r = r)
  phi <- runif(n = n, min = 0, max = 2*pi)
  res <- cbind(
    x = (1 + r * cos(theta)) * cos(phi),
    y = (1 + r * cos(theta)) * sin(phi),
    z = r * sin(theta)
  )
  add_noise(res, sd = sd)
}

#' @rdname tori
#' @export
sample_torus <- sample_torus_tube

# rejection sampler for a torus (conventional parameterization)
# https://projecteuclid.org/euclid.imsc/1379942050
rs_torus_tube <- function(n, r) {
  x <- c()
  while (length(x) < n) {
    theta <- runif(n, 0, 2*pi)
    jacobian_theta <- (1 + r * cos(theta)) / (2*pi)
    density_threshold <- runif(n, 0, 1/pi)
    x <- c(x, theta[jacobian_theta > density_threshold])
  }
  x[1:n]
}

#' @rdname tori
#' @export
sample_tori_interlocked <- function(n, ar = 2, sd = 0) {
  r <- 1/ar
  # split sample size
  ns <- as.vector(table(stats::rbinom(n = n, size = 1, prob = .5)))
  # first torus, without noise
  res1 <- sample_torus(n = ns[1], ar = ar, sd = 0)
  res1 <- cbind(res1, z = 0)
  # second torus, without noise, offset to (1,0,0) and rotated pi/2 about x
  res2 <- sample_torus(n = ns[2], ar = ar, sd = 0)
  res2 <- cbind(x = res2[, 1] + 1, y = 0, z = res2[, 2])
  # combine tori
  res <- rbind(res1, res2)[sample(n), , drop = FALSE]
  # add noise
  add_noise(res, sd = sd)
}

#' @rdname tori
#' @export
sample_torus_flat <- function(n, ar = 1, sd = 0) {
  theta <- runif(n = n, min = 0, max = 2*pi)
  phi <- runif(n = n, min = 0, max = 2*pi)
  res <- cbind(
    x = cos(theta),
    y = sin(theta),
    z = ar * cos(phi),
    w = ar * sin(phi)
  )
  add_noise(res, sd = sd)
}
