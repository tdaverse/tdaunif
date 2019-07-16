#' @title Testing Trefoil Knot Rejection Sampling
#'
#' @description These functions calculate the cumulative distances between points in the trefoil knot.
#'
#' @details (Details.)

#' @name trefoil_test
#' @param n Number of observations.
#' @param a Aspect ratio

NULL

#' @rdname trefoil_test

#' @export
#' 

#Jacobian determinant of trefoil
jd_knot <- function(a){
  #function(theta)sqrt((a*cos(theta)-a*theta*sin(theta))^2 + (a*sin(theta)+a*theta*cos(theta))^2)
  function(theta)sqrt(((cos(theta) + 4*cos(2*theta))^2)+((-sin(theta) + 4*sin(2*theta))^2) + (9*(cos(3*theta))^2)) 
}

sample_trefoil_knot <- function(n, a = 1,min_theta =0, max_theta = 2*pi){
  theta <- rs_knot(n,a, min_theta, max_theta)
  #Applies modified theta values to parametric equation of trefoil knot
  res <- cbind(
    x = (sin(theta) + 2*sin(2*theta)),
    y = (cos(theta) - 2*cos(2*theta)),
    z = (-(sin(theta))^3)
  )
}

#Rejection sampler and Calculating Cumulative Distances
n<-5000
a<-1
min_theta<-0
max_theta<- 2*pi

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
  x <- x[1:n]
#Sorts the values of x and turns x into a matrix
  x <- sort(x)
  x <- as.matrix(x)
  
  #Combines coordinates x,y,z by columns to form a matrix
  X1 <- cbind(
    x1 = (sin(x) + 2*sin(2*x)),
    y1 = (cos(x) - 2*cos(2*x)),
    z1 = (-(sin(x))^3)
  )
#Removes the top row of the matrix and places it in the last row 
  X2 <- rbind(
    X1[-1, ,drop=FALSE],
    X1[1, ,drop=FALSE]
  )
#Calculates the distances between adjacent points
  d <- (sqrt(apply((X2-X1)^2, 1,sum)))
  d <- as.matrix(d)
#Calculates the cumulative distances 
  cd <- cumsum(d)
  plot(x,cd,type="l")
  segments(x0=x[1],x1=x[n],y0=0 ,y1 = sum(d))




