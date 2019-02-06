#' @title Sample (with noise) from a sphere
#'
#' @description These functions generate uniform samples from a sphere of radius
#'   1 and dimension 2 in 3-space, or in arbitrary dimension in
#'   1-higher-dimensional space, optionally with noise.
#'
#' @details The function `sample_sphere` is adapted from [TDA::sphereUnif()].

#' @name sphere
#' @param n Number of observations.
#' @param d Dimension of the sphere.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-sphere.r
NULL

#' @rdname sphere
#' @export
sample_2sphere <- function(n, sd = 0) {
  # generate a uniform sample from [0,1]^2
  z <- replicate(2, runif(n = n))
  # map this to the upper hemisphere with area preservation
  res <- apm_hemisphere(z)
  # reverse a .5-probability sample of z-coordinates
  res[, 3] <- res[, 3] * ((-1) ^ stats::rbinom(n = n, size = 1, prob = .5))
  # add noise
  add_noise(res, sd = sd)
}

# area-preserving map from [0,1]^2 to the upper hemisphere
apm_hemisphere <- function(x) {
  cbind(
    sqrt(x[, 1] * (2 - x[, 1])) * cos(2 * pi * x[, 2]),
    sqrt(x[, 1] * (2 - x[, 1])) * sin(2 * pi * x[, 2]),
    1 - x[, 1]
  )
}

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
  res <- add_noise(res, sd = sd)
  # column names
  colnames(res) <- if (ncol(res) <= 4) {
    letters[1:ncol(res) + 26 - ncol(res)]
  } else {
    paste0("x", 1:ncol(res))
  }
  res
}
