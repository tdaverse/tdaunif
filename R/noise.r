#' @title Add noise to a sample
#'
#' @description This function adds Gaussian noise to coordinate data contained
#'   in a matrix. It is called by samplers to introduce noise when `sd` is
#'   passed a positive value.
#'   

#' @name noise
#' @param x A matrix of row coordinates.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
NULL

#' @rdname noise
#' @export
add_noise <- function(x, sd = 0) {
  if (sd != 0) {
    x <- x + rmvunorm(n = nrow(x), d = ncol(x), sd)
  }
  x
}
