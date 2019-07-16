#' @title Stratified sample of unit line segment, square, or cube
#'
#' @description These functions generate stratified samples of the unit line
#'   segment in 1-dimensional space, the unit square in 2-space, and the unit
#'   cube in 3-space.
#'
#' @details (Details.)

#' @name stratified-samplers
#' @param n Number of observations.
#' @param k Number of intervals per dimension for the stratification.
#' @example inst/examples/ex-stratified-samplers.r
NULL

#' @rdname stratified-samplers
#' @export
stratified_segment <- function(n,k){
  #Samples s from the parameter space uniformly from 0 to 1/k
  s <- runif(n, 0, (1/k))
  #Finds the number of remainder sample points
  r <- n%%k
  #Provides index values to intervals of the line segment
  mq <-  rep(0:(k-1),n%/%k)
  mr <- sample(0:(k-1),r,replace = FALSE)
  m <- c(mq,mr)
  #Calculate the shift values
  shiftVals <- (1/k) * m
  #Applies shifts to originally sampled s values to obtain the stratified sample
  cbind((s + shiftVals)) 
}

#' @rdname stratified-samplers
#' @export
stratified_square <- function(n,k){
  #Samples s and t from the parameter space uniformly from 0 to 1/k
  s <- runif(n, 0, (1/k))
  t <- runif(n, 0, (1/k))
  #Finds the number of remainder sample points
  r <- n %% k^2
  #Provides index values to cells in the 2-dimensional matrix
  mq <-  rep(0:(k^2-1),n %/% (k^2))
  mr <- sample(0:(k^2-1),r,replace = FALSE)
  m <- c(mq,mr)
  #Finds the row and column of each cell in the matrix
  rowSample <- m %/% k
  colSample <- m %% k
  #Uses row and column values to determine degree of shifting
  shiftVals <- (1/k) * cbind(rowSample,colSample)
  samples <- cbind(s,t)
  #Applies shifts to originally sampled s and t values to obtain the stratified
  #sample
  samples + shiftVals
}

#' @rdname stratified-samplers
#' @export
stratified_cube <- function(n,k){
  #Samples s,t, and u from the parameter space uniformly from 0 to 1/k
  s <- runif(n, 0, (1/k))
  t <- runif(n, 0, (1/k))
  u <- runif(n, 0, (1/k))
  #Finds the number of remainder sample points
  r <- n %% k^3
  #Provides index values to cells in the 3-dimensional grid system
  mq <-  rep(0:(k^3-1),n %/% (k^3))
  mr <- sample(0:(k^3-1),r,replace = FALSE)
  m <- c(mq,mr)
  #Finds the row, column, and depth of each cell in the matrix
  rowSample <- (m%%k^2) %/% k
  colSample <- (m%%k^2) %% k
  depthSample <- m %/% k^2
  #Uses row, column, and depth values to determine degree of shifting
  shiftVals <- (1/k) * cbind(rowSample,colSample, depthSample)
  samples <- cbind(s,t,u)
  #Applies shifts to originally sampled s/t/u values to obtain the stratified
  #sample
  samples + shiftVals
}
