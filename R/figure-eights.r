#' @title Sample (with noise) from figure eight
#'
#' @description These functions generate uniform samples from figure eights in
#'   2-dimensional space, optionally with noise.
#'
#' @details (Details.)

#' @name figure-eights
#' @param n Number of observations.
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-figure-eights.r
NULL

#' @rdname figure-eights
#' @export
sample_figure_eight <- function(n, sd = 0){
  theta <- rs_eight(n)
  #Parametrization of figure eight with modified theta values inputted
  res <- cbind(
    x = (sin(theta)),
    y = (sin(theta)*cos(theta))
  )
  #Adds Gaussian noise to figure 8
  add_noise(res, sd = sd)
}
#Rejection sampler
rs_eight <- function(n){
  x <- c()
  while(length(x) < n){
    theta <- runif(n, 0, 2*pi)
    jacobian <- jd_eight()
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
jd_eight <- function(){
  function(theta)sqrt((cos(theta))^2 + (cos(theta)^2-sin(theta)^2)^2)
}
