#' @title Sample (with noise) from circles
#'
#' @description These functions generate uniform samples from configurations of
#'   circles of radius 1 in 2- or 3-dimensional space, optionally with noise.
#'
#' @details (Details.)

#' @name circles
#' @param n Number of observations.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-circles.r
NULL

#' @rdname circles
#' @export
sample_circle <- function(n, sd = 0) {
  theta <- runif(n = n, min = 0, max = 2*pi)
  res <- cbind(x = cos(theta), y = sin(theta))
  add_noise(res, sd = sd)
}

#' @rdname circles
#' @export
sample_circles_interlocked <- function(n, sd = 0) {
  theta <- runif(n = n, min = 0, max = 4*pi)
  theta1 <- theta[theta < 2*pi]
  theta2 <- theta[theta >= 2*pi]
  res <- rbind(
    cbind(x = cos(theta1), y = sin(theta1), z = 0),
    cbind(x = cos(theta2) + 1, y = 0, z = sin(theta2))
  )
  add_noise(res, sd = sd)
}

#' @rdname circles
#' @export
sample_circle_sinusoidal <- function(n, sd = 0) {
  theta <- runif(n = n, min = 0, max = 2*pi)
  x <- cos(theta); y <- sin(theta)
  res <- cbind(x = x, y = y, z = x*y)
  add_noise(res, sd = sd)
}
