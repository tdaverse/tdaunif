#' @title Sample (with noise) from unit disc
#'
#' @description These functions generate uniform samples from unit disc in
#'   2-dimensional space, optionally with noise.
#'
#' @details (Details.)

#' @template ref-arvo2001
#' 

#' @name unit-discs
#' @param n Number of observations.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-unit-discs.r
NULL

#' @rdname unit-discs
#' @export
sample_unit_disc <- function(n, sd){
  #Orthogonal unit vectors (1,0) and (0,1)
  unitVectors <-  cbind(c(1,0),c(0,1))
  #Samples n values between 0 and 1 for unit square coordinates
  s <- runif(n,0,1)
  t <- runif(n,0,1)
  #Stores 2 coefficients of area-preserving parametrization of unit disc in a
  #2xn matrix with different unit square coordinates (s,t)
  coeffs <-  rbind(sqrt(s)*(cos(2*pi*t)), sqrt(s)*(sin(2*pi*t)))
  #Multiplies the matrix of the unit vectors by the matrix of coefficients, and
  #transposes the product to create an array of uniformly sampled x and y
  #coordinates
  res <- t(unitVectors %*% coeffs)
  colnames(res) <- c('x','y')
  add_noise(res, sd=sd)
}
