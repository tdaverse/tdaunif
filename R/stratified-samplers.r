#' @title Stratified sample of any unit dimensional space
#'
#' @description These functions generate stratified samples of any dimension
#'   including the unit line segment in 1-dimensional space, the unit square in
#'   2-space, the unit cube in 3-space.
#'
#' @details (Details.)

#' @name stratified-samplers
#' @param n Number of observations.
#' @param bins Number of intervals per dimension for the stratification.
#' @param dim Dimensional space of sample.
#' @example inst/examples/ex-stratified-samplers.r
NULL

#' @rdname stratified-samplers
#' @export
sample_strat_segment <- function(n, bins) {
  #Throw warning if bins > n
  if (bins > n) warning("Number of subregions is greater than sample size.")
  #Samples s from the parameter space uniformly from 0 to 1/bins
  s <- runif(n, 0, (1/bins))
  #Finds the number of remainder sample points
  r <- n %% bins
  #Provides index values to intervals of the line segment
  mq <-  rep(0L:(bins - 1L), n %/% bins)
  mr <- sample(0L:(bins - 1L), r, replace = FALSE)
  m <- c(mq, mr)
  #Calculate the shift values
  shifts <- (1/bins) * m
  #Applies shifts to sampled s values to obtain the stratified sample
  cbind(s) + shifts
}

#' @rdname stratified-samplers
#' @export
sample_strat_square <- function(n, bins) {
  #Throw warning if bins^2 > n
  if (bins^2L > n) warning("Number of subregions is greater than sample size.")
  #Samples s and t from the parameter space uniformly from 0 to 1/bins
  s <- runif(n, 0, (1/bins))
  t <- runif(n, 0, (1/bins))
  #Finds the number of remainder sample points
  r <- n %% bins^2L
  #Provides index values to cells in the 2-dimensional matrix
  mq <- rep(0L:(bins^2L - 1L), n %/% (bins^2L))
  mr <- sample(0L:(bins^2L - 1L), r, replace = FALSE)
  m <- c(mq, mr)
  #Finds the row and column of each cell in the matrix
  row_index <- m %/% bins
  col_index <- m %% bins
  #Uses row and column values to determine degree of shifting
  shifts <- (1/bins) * cbind(row_index, col_index)
  samples <- cbind(s, t)
  #Applies shifts to sampled s and t values to obtain the stratified sample
  samples + shifts
}

#' @rdname stratified-samplers
#' @export
sample_strat_cube <- function(n, bins) {
  #Throw warning if bins^3 > n
  if (bins^3L > n) warning("Number of subregions is greater than sample size.")
  #Samples s,t, and u from the parameter space uniformly from 0 to 1/bins
  s <- runif(n, 0, (1/bins))
  t <- runif(n, 0, (1/bins))
  u <- runif(n, 0, (1/bins))
  #Finds the number of remainder sample points
  r <- n %% bins^3L
  #Provides index values to cells in the 3-dimensional grid system
  mq <- rep(0L:(bins^3L - 1L), n %/% (bins^3L))
  mr <- sample(0L:(bins^3L - 1L), r, replace = FALSE)
  m <- c(mq, mr)
  #Finds the row, column, and depth of each cell in the matrix
  row_index <- (m %% bins^2L) %/% bins
  col_index <- (m %% bins^2L) %% bins
  depth_index <- m %/% bins^2L
  #Uses row, column, and depth values to determine degree of shifting
  shifts <- (1/bins) * cbind(row_index, col_index, depth_index)
  samples <- cbind(s, t, u)
  #Applies shifts to sampled s/t/u values to obtain the stratified sample
  samples + shifts
}

#' @rdname stratified-samplers
#' @export
sample_stratify <- function(n, bins, dim) {
  #Throw warning if bins^dim > n
  if (bins^dim > n) warning("Number of subregions is greater than sample size.")
  #Samples from the parameter space uniformly from 0 to 1/bins in each dimension
  unifSamples <- replicate(dim, runif(n, 0, 1/bins))
  colnames(unifSamples) <- paste0("s", seq(dim))
  
  #Finds the number of remainder sample points
  r <- n %% bins^dim
  #Provides index values to cells in the 3-dimensional grid system
  mq <-  rep(0L:(bins^dim - 1L), n %/% (bins^dim))
  mr <- sample(0L:(bins^dim - 1L), r, replace = FALSE)
  m <- c(mq, mr)
  #Finds the row, column, and depth of each cell in the matrix
  shifts <- matrix(base_expansion(m, bins, dim), n, dim + 1L)
  shifts <- shifts[, c((dim + 1L):2L), drop = FALSE]
  #Uses row, column, and depth values to determine degree of shifting
  shiftVals <- (1/bins) * shifts
  #Applies shifts to sampled s/t/u values to obtain the stratified sample
  unifSamples + shiftVals
}

base_expansion <- function(n, bins, dim){
  i <- dim
  base <- c()
  while(i >= 0L) {
    base <- c(base, n %/% bins^i)
    n <- n %% bins^i
    i <-  i - 1L
  }
  base
}
