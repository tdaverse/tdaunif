#' @title Sample (with noise) from circles
#'
#' @description These functions generate uniform samples from configurations of
#'   circles of radius 1 in 2- or 3-dimensional space, optionally with noise.
#'
#' @details (Details.)

#' @name circles
#' @param n Number of observations.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @examples inst/examples/ex-circles.r
NULL

#' @rdname circles
#' @export
sample_circle_flat <- function(n, sd = 0) {
  theta <- stats::runif(n = n, min = 0, max = 2*pi)
  res <- cbind(x = cos(theta), y = sin(theta))
  if (sd != 0) res <- res + rmvunorm(n = n, d = 2, sd = sd)
  res
}

#' @rdname circles
#' @export
sample_circle <- sample_circle_flat

#' @rdname circles
#' @export
sample_circles_interlocked <- function(n, sd = 0) {
  theta <- stats::runif(n = n, min = 0, max = 4 * pi)
  theta1 <- theta[theta < 2*pi]
  theta2 <- theta[theta >= 2*pi]
  res <- rbind(
    cbind(x = cos(theta1), y = sin(theta1), z = 0),
    cbind(x = cos(theta2) + 1, y = 0, z = sin(theta2))
  )
  if (sd != 0) {
    res <- res + rmvunorm(n = length(theta1, theta2), d = 3, sd = sd)
  }
  res
}

#' @rdname circles
#' @export
sample_circle_sinusoidal <- function(n, sd = 0) {
  theta <- stats::runif(n = n, min = 0, max = 2*pi)
  x <- cos(theta); y <- sin(theta)
  res <- cbind(x = x, y = y, z = x*y)
  if (sd != 0) res <- res + rmvunorm(n = n, d = 3, sd = sd)
  res
}
