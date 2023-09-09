#' @title Sample (with noise) from a sphere
#'
#' @description These functions generate uniform samples from a sphere of radius
#'   1 and dimension 2 in 3-space, or in arbitrary dimension in
#'   1-higher-dimensional space, optionally with noise.
#'
#' @details
#'
#' The function `sample_sphere()` is adapted from `sphereUnif()` in the **TDA**
#' package. It uses [stats::rnorm()] to sample from a multivariate Gaussian and
#' normalizes the resulting coordinates.
#'
#' The function `sample_2hemisphere()` uses an area-preserving parameterization
#' of the upper hemisphere, and `sample_2sphere()` uses two of these samples,
#' one reflected over the horizontal plane, to produce a sample from a sphere.
#' The parameterization was derived through the method for sampling 2-manifolds
#' as described by Arvo (2001).
#' 

#' @template ref-arvo2001
#'

#' @name sphere
#' @param n Number of observations.
#' @param dim Dimension of the sphere.
#' @param bins Number of intervals per dimension to stratify by. Default set to
#'   1, which generates a uniform sample.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-sphere.r
NULL

#' @rdname sphere
#' @export
sample_2hemisphere <- function(n, bins = 1L, sd = 0) {
  # generate a uniform sample from [0,1]^2
  unit_square <- sample_strat_square(n, bins)
  # map this to the upper hemisphere with area preservation
  res <- apm_hemisphere(unit_square)
  # add noise
  add_noise(res, sd = sd)
}

#' @rdname sphere
#' @export
sample_2sphere <- function(n, bins = 1L, sd = 0) {
  if (bins > 1L) {
    # equal allocation of sample to hemispheres (amounts to first bin)
    ns <- sample(c(floor(n / 2), ceiling(n / 2)))
    # generate uniform samples from upper and lower hemispheres
    hemi_lower <- sample_2hemisphere(floor(n / 2), bins = bins - 1L, sd = 0)
    hemi_upper <- sample_2hemisphere(ceiling(n / 2), bins = bins - 1L, sd = 0)
    # combine hemispheres
    res <- rbind(hemi_lower, hemi_upper)
  } else {
    # sample uniformly from the upper hemisphere
    res <- sample_2hemisphere(n)
    # reverse a .5-probability sample of z-coordinates
    res[, 3] <- res[, 3] * ((-1) ^ stats::rbinom(n = n, size = 1, prob = .5))
  }
  # add noise
  add_noise(res, sd = sd)
}

# area-preserving map from [0,1]^2 to the upper hemisphere
apm_hemisphere <- function(x) {
  cbind(
    x = sqrt(x[, 1] * (2 - x[, 1])) * cos(2 * pi * x[, 2]),
    y = sqrt(x[, 1] * (2 - x[, 1])) * sin(2 * pi * x[, 2]),
    z = 1 - x[, 1]
  )
}

#' @rdname sphere
#' @export
sample_sphere <- function(n, dim = 1, sd = 0) {
  # sample from a simple multivariate Gaussian
  res <- array(stats::rnorm(n * (dim + 1)), dim = c(n, dim + 1))
  # ensure that all points have positive norm
  van <- which(apply(res, 1, norm, "2") == 0)
  for (i in van) {
    while (norm(res[i, ], "2") == 0) {
      res[i, ] <- stats::rnorm(dim + 1)
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
