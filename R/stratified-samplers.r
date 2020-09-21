#' @title Stratified sample of any unit dimensional space
#'
#' @description These functions generate stratified samples of any dimension
#'   including the unit line segment in 1-dimensional space, the unit square in
#'   2-space, the unit cube in 3-space.
#'
#' @details (Details.)

#' @name stratified-samplers
#' @param n Number of observations.
#' @param k Number of intervals per dimension for the stratification.
#' @param d Dimensional space of sample.
#' @example inst/examples/ex-stratified-samplers.r
NULL

#' @rdname stratified-samplers
#' @export
sample_strat_segment <- function(n, k) {
  #Throw warning if k > n
  if (k > n) warning("Number of subregions is greater than sample size.")
  #Samples s from the parameter space uniformly from 0 to 1/k
  s <- runif(n, 0, (1/k))
  #Finds the number of remainder sample points
  r <- n %% k
  #Provides index values to intervals of the line segment
  mq <-  rep(0L:(k - 1L), n %/% k)
  mr <- sample(0L:(k - 1L), r, replace = FALSE)
  m <- c(mq, mr)
  #Calculate the shift values
  shifts <- (1/k) * m
  #Applies shifts to sampled s values to obtain the stratified sample
  cbind(s) + shifts
}

#' @rdname stratified-samplers
#' @export
sample_strat_square <- function(n, k) {
  #Throw warning if k^2 > n
  if (k^2L > n) warning("Number of subregions is greater than sample size.")
  #Samples s and t from the parameter space uniformly from 0 to 1/k
  s <- runif(n, 0, (1/k))
  t <- runif(n, 0, (1/k))
  #Finds the number of remainder sample points
  r <- n %% k^2L
  #Provides index values to cells in the 2-dimensional matrix
  mq <- rep(0L:(k^2L - 1L), n %/% (k^2L))
  mr <- sample(0L:(k^2L - 1L), r, replace = FALSE)
  m <- c(mq, mr)
  #Finds the row and column of each cell in the matrix
  row_index <- m %/% k
  col_index <- m %% k
  #Uses row and column values to determine degree of shifting
  shifts <- (1/k) * cbind(row_index, col_index)
  samples <- cbind(s, t)
  #Applies shifts to sampled s and t values to obtain the stratified sample
  samples + shifts
}

#' @rdname stratified-samplers
#' @export
sample_strat_cube <- function(n, k) {
  #Throw warning if k^3 > n
  if (k^3L > n) warning("Number of subregions is greater than sample size.")
  #Samples s,t, and u from the parameter space uniformly from 0 to 1/k
  s <- runif(n, 0, (1/k))
  t <- runif(n, 0, (1/k))
  u <- runif(n, 0, (1/k))
  #Finds the number of remainder sample points
  r <- n %% k^3L
  #Provides index values to cells in the 3-dimensional grid system
  mq <- rep(0L:(k^3L - 1L), n %/% (k^3L))
  mr <- sample(0L:(k^3L - 1L), r, replace = FALSE)
  m <- c(mq, mr)
  #Finds the row, column, and depth of each cell in the matrix
  row_index <- (m %% k^2L) %/% k
  col_index <- (m %% k^2L) %% k
  depth_index <- m %/% k^2L
  #Uses row, column, and depth values to determine degree of shifting
  shifts <- (1/k) * cbind(row_index, col_index, depth_index)
  samples <- cbind(s, t, u)
  #Applies shifts to sampled s/t/u values to obtain the stratified sample
  samples + shifts
}

#' @rdname stratified-samplers
#' @export
sample_stratify <- function(n, k, d) {
  #Throw warning if k^d > n
  if (k^d > n) warning("Number of subregions is greater than sample size.")
  #Samples from the parameter space uniformly from 0 to 1/k in each dimension
  unifSamples <- replicate(d, runif(n, 0, 1/k))
  colnames(unifSamples) <- paste0("s", seq(d))
  
  #Finds the number of remainder sample points
  r <- n %% k^d
  #Provides index values to cells in the 3-dimensional grid system
  mq <-  rep(0L:(k^d - 1L), n %/% (k^d))
  mr <- sample(0L:(k^d - 1L), r, replace = FALSE)
  m <- c(mq, mr)
  #Finds the row, column, and depth of each cell in the matrix
  shifts <- matrix(base_expansion(m, k, d), n, d + 1L)
  shifts <- shifts[, c((d + 1L):2L), drop = FALSE]
  #Uses row, column, and depth values to determine degree of shifting
  shiftVals <- (1/k) * shifts
  #Applies shifts to sampled s/t/u values to obtain the stratified sample
  unifSamples + shiftVals
}

base_expansion <- function(n, k, d){
  i <- d
  base <- c()
  while(i >= 0L) {
    base <- c(base, n %/% k^i)
    n <- n %% k^i
    i <-  i - 1L
  }
  base
}
