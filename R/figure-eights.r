#' @title Sample from figure eight
#'
#' @description These functions generate uniform samples from figure eights in
#'   2-dimensional space.
#'
#' @details (Details.)

#' @name figure-eights
#' @param n Number of observations.
#' @param a Aspect ratio of figure eight.
#' @example inst/examples/ex-figure-eights.r
NULL

#' @rdname figure-eights
#' @export
sample_figure_eight <- function(n,a){
  theta <- rs_eight(n,a)
  #Parametrization of figure eight with modified theta values inputted
  res <- cbind(
    x = (a * sin(theta)),
    y = (a * sin(theta)*cos(theta))
  )
}
#Rejection sampler
rs_eight <- function(n,a){
  x <- c()
  while(length(x) < n){
    theta <- runif(n, 0, 2*pi)
    jacobian <- jd_eight(a)
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
jd_eight <- function(a){
  function(theta)sqrt((a*cos(theta))^2 + (a*cos(theta)^2-a*sin(theta)^2)^2)
}