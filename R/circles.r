#' @title Sample (with noise) from circles
#'
#' @description These functions generate uniform and stratified samples from
#'   configurations of circles of radius 1 in 2- or 3-dimensional space,
#'   optionally with noise.
#'
#' @details
#'
#' The function `sample_circle()` uses the usual sinussoidal parameterization
#' from the unit interval to the unit circle.
#'
#' The function `sample_circles_interlocked()` effectively samples from a pair
#' of circles and transforms them in 3-dimensional space so that they are
#' interlocked (perpendicular to each other).
#'
#' Both functions are length-preserving and admit stratification. If `bins = 2`,
#' the stratification for the latter function will simply be between the two
#' interlocked circles.
#' 

#' @name circles
#' @param n Number of observations.
#' @param bins Number of intervals to stratify by. Default set to 1, which
#'   generates a uniform sample.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-circles.r
NULL

#' @rdname circles
#' @export
sample_circle <- function(n, bins = 1L, sd = 0) {
  theta <- sample_strat_segment(n, bins) * 2*pi
  res <- cbind(x = cos(theta), y = sin(theta))
  add_noise(res, sd = sd)
}

#' @rdname circles
#' @export
sample_circles_interlocked <- function(n, bins = 1L, sd = 0) {
  theta <- sample_strat_segment(n, bins) * 4*pi
  theta_1 <- theta[theta < 2*pi]
  theta_2 <- theta[theta >= 2*pi]
  res <- rbind(
    cbind(x = cos(theta_1), y = sin(theta_1), z = 0),
    cbind(x = cos(theta_2) + 1, y = 0, z = sin(theta_2))
  )
  add_noise(res, sd = sd)
}
