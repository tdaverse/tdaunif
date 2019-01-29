#' @title Sample (with noise) from a Swiss roll
#'
#' @description This function generates uniform samples from a Swiss roll in
#'   3-dimensional space, optionally with noise.
#'
#' @details This function is adapted from
#'   [drtoolbox](https://lvdmaaten.github.io/drtoolbox/).

#' @name swiss-roll
#' @param n Number of observations.
#' @param w Width of the roll.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @examples inst/examples/ex-swiss-roll.r
NULL

#' @rdname swiss-roll
#' @export
sample_swiss <- function(n, w = 1, sd = 0) {
  t <- runif(n, 1, 9/2*pi)
  z <- runif(n, 0, w)
  res <- cbind(x = t*cos(t), y = t*sin(t), z = z)
  if (sd != 0) res <- res + rmvunorm(n = n, d = 3, sd = sd)
  res
}
