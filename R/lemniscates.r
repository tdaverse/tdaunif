#' @title Sample (with noise) from lemniscates (figure eights)
#'
#' @description These functions generate uniform samples from lemniscates
#'   (figure eights) in 2-dimensional space, optionally with noise.
#'
#' @details These functions use a simple parameterization from the unit circle
#'   to the lemniscate of Gerono, as presented on
#'   [Wikipedia](https://en.wikipedia.org/wiki/Lemniscate_of_Gerono).
#'   `sample_figure_eight()` is an alias of `sample_lemniscate_gerono()`. The
#'   uniform sample is generated through a rejection sampling process as
#'   described by Diaconis, Holmes, and Shahshahani (2013).

#' @template ref-diaconis2013
#' 

#' @name lemniscates
#' @param n Number of observations.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-lemniscates.r
NULL

#' @rdname lemniscates
#' @export
sample_lemniscate_gerono <- function(n, sd = 0) {
  theta <- rs_gerono(n)
  #Parametrization of lemniscate with modified theta values inputted
  res <- cbind(
    x = (sin(theta)),
    y = (sin(theta) * cos(theta))
  )
  #Adds Gaussian noise to figure 8
  add_noise(res, sd = sd)
}
#Rejection sampler
rs_gerono <- function(n) {
  x <- c()
  while (length(x) < n) {
    theta <- runif(n, 0, 2*pi)
    jacobian <- jd_gerono()
    #Applies the jacobian scalar value to each value of theta
    jacobian_theta <- sapply(theta, jacobian)
    #Adds new theta values to list only if greater than the density threshold,
    #the jacobian value when theta = 0
    density_threshold <- runif(n, 0, jacobian(0))
    x <- c(x, theta[jacobian_theta > density_threshold])
  }
  x[1:n]
}

#Jacobian determinant of figure eight
jd_gerono <- function() {
  function(theta) sqrt((cos(theta)) ^ 2 + (cos(theta) ^ 2 - sin(theta) ^ 2) ^ 2)
}

#' @rdname lemniscates
#' @export
sample_figure_eight <- sample_lemniscate_gerono
