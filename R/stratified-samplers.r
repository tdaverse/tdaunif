#' @title Stratified sample of unit square
#'
#' @description This functions generates stratified samples of the unit square
#'   in 2-dimensional space.
#'
#' @details (Details.)

#' @name stratified-samplers
#' @param n Number of observations.
#' @param k Number of intervals per dimension for the stratification.
#' @example inst/examples/ex-stratified-samplers.r
NULL

#' @rdname stratified-samplers
#' @export
stratified_square <- function(n,k){
  s <- runif(n, 0, (1/k))
  t <- runif(n, 0, (1/k))
  
  r <- n %% k^2
  
  cells <- seq(0:k^2-1)
  mq <-  rep(0:(k^2-1),n %/% (k^2))
  mr <- sample(0:(k^2-1),r,replace = FALSE)
  m <- c(mq,mr)
  
  rowSample <- m %/% k
  colSample <- m %% k
  shiftVals <- (1/k) * cbind(rowSample,colSample)
  samples <- cbind(s,t)
  coords <- samples + shiftVals
}
