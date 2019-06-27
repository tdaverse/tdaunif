#' @title Sample from planar triangles
#'
#' @description These functions generate uniform samples from configurations of
#'   planar triangles in 2-dimensional space.
#'
#' @details (Details.)

#' @name planar-triangles
#' @param n Number of observations.
#' @param triangle The (x,y) coordinates of the vertices of a triangle,
#'   formatted in a 2x3 matrix
#' @example inst/examples/ex-planar-triangles.r
NULL

#' @rdname planar-triangles
#' @export
planar_triangle_sampler <- function(n,triangle){
  #Checks to make sure 'triangle' input is a 2x3 matrix and if not, alerts the
  #user
  if(nrow(triangle) != 2 | ncol(triangle) != 3)
    stop("The triangle's vertices must be inputed as a 2x3 matrix")
  #Samples n values between 0 and 1 for unit square coordinates
  s <- runif(n,0,1)
  t <- runif(n,0,1)
  #Stores 3 coefficients of area-preserving parametrization of triangle in a 3xn
  #matrix with different unit square coordinates (s,t)
  coeffs <-  rbind(1-sqrt(s), sqrt(s)*(1-t), sqrt(s)*t)
  #Multiplies the matrix of the triangle's vertices by the matrix of
  #coefficients, and transposes the product to create an array of uniformly
  #sampled x and y coordinates
  res <- t(triangle %*% coeffs)
  colnames(res) <- c('x','y')
  res
}
