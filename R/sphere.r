#' @title Sample (with noise) from a sphere
#'
#' @description This function generates uniform samples from a sphere of radius
#'   1 and arbitrary dimension in 1-higher-dimensional space, optionally with
#'   noise.
#'
#' @details This function is adapted from [TDA::sphereUnif()].

#' @name sphere
#' @param n Number of observations.
#' @param d Dimension of the sphere.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @examples inst/examples/ex-sphere.r
NULL

#' @rdname sphere
#' @export
sample_sphere <- function(n, d = 1, sd = 0) {
  # sample from a simple multivariate Gaussian
  res <- array(stats::rnorm(n * (d + 1)), dim = c(n, d + 1))
  # ensure that all points have positive norm
  van <- which(apply(res, 1, norm, "2") == 0)
  for (i in van) {
    while (norm(res[i, ], "2") == 0) {
      res[i, ] <- stats::rnorm(d + 1)
    }
  }
  # scale all points to have norm 1
  res <- sweep(res, 1, apply(res, 1, norm, "2"), FUN = "/")
  # add noise
  if (sd != 0) res <- res + rmvunorm(n = n, d = d + 1, sd = sd)
  res
}
