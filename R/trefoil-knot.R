#' @title Sample from trefoil knot
#'
#' @description These functions generate uniform samples from trefoil knot in
#'   3-dimensional space.
#'
#' @details (Details.)

#' @name trefoil-knot
#' @param n Number of observations.
#' @param a Aspect ratio
#' @param min_wrap The wrap of the spiral from which sampling begins
#' @param max_wrap The wrap of the spiral where sampling ends
NULL

#' @rdname trefoil-knot
#' @export
sample_trefoil_knot <- function(n, a = 1, min_wrap = 0, max_wrap = 1){
theta <- rs_knot(n,a, min_wrap, max_wrap)
  #Applies modified theta values to parametric equation of trefoil knot
  res <- cbind(
    x = (sin(theta) + 2*sin(2*theta)),
    y = (cos(theta) - 2*cos(2*theta)),
    z = (-(sin(theta))^3)
  )
}


#Rejection sampler
rs_knot <- function(n,a, min_wrap, max_wrap){
  #Sets the minimum and maximum values of theta according to number of spirals the user desired
  min_theta <- min_wrap * 2*pi
  max_theta <- max_wrap * 2*pi
  x <- c()
  #Keep looping until desired number of observations is achieved
  while(length(x) < n){
    theta <- runif(n, min_theta, max_theta)
    jacobian <- jd_knot(a)
    #applies the Jacobian scalar value to each value of theta
    jacobian_theta <- sapply(theta, jacobian)
    #Density threshold is the greatest jacobian value in the spiral, and the area of least warping
    density_threshold <- runif(n, 0, jacobian(0))
    #Takes theta values that exceed the density threshold, and throws out the rest
    x <- c(x, theta[jacobian_theta > density_threshold])
  }
  x[1:n]
}

#Jacobian determinant of trefoil
jd_knot <- function(a){
  #function(theta)sqrt((a*cos(theta)-a*theta*sin(theta))^2 + (a*sin(theta)+a*theta*cos(theta))^2)
  function(theta)sqrt(((cos(theta) + 4*cos(2*theta))^2)+((-sin(theta) + 4*sin(2*theta))^2) + (9*(cos(3*theta))^2)) 
}

plot(sample_trefoil_knot(180))