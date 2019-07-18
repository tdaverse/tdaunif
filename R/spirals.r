#' @title Sample (with noise) from a spirals
#'
#' @description This function generates uniform samples from configurations of
#'   spirals in 2-dimensional space, optionally with noise.
#'
#' @details This function is adapted from [KODAMA::spirals()].
#'
#'   **Note:** This is a non-uniform sampler. Use [sample_arch_spiral()]
#'   instead, which will be modified soon to incorporate multiple arms.

#' @name spirals
#' @param n Number of observations.
#' @param spirals Number of spirals.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-spirals.r
NULL

#' @rdname spirals
#' @export
sample_spirals <- function(n, spirals = 3, sd = 0) {
  warning(
    "This is a non-uniform sampler. Use `sample_arch_spiral()` instead, ",
    "which will be modified soon to incorporate multiple arms."
  )
  
  # split sample size
  ns <- apply(stats::rmultinom(n = n, size = 1, prob = rep(1, spirals)), 1, sum)
  
  # each spiral
  spirals <- lapply(1:spirals, function(i) {
    t <- seq(1 / (4*pi), 1, length.out = ns[i]) ^ 0.5 * 2*pi
    cbind(
      x = cos(t + (2*pi * i) / spirals) * t,
      y = sin(t + (2*pi * i) / spirals) * t
    )
  })
  # bind spirals
  res <- do.call(rbind, spirals)[sample(n), ]
  # add noise
  add_noise(res, sd = sd)
}
