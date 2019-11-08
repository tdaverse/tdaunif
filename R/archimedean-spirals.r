#' @title Sample (with noise) from archimedean spirals and swiss rolls
#'
#' @description These functions generate uniform samples from archimedean
#'   spirals in 2-dimensional space or from swiss rolls in 3-dimensional space,
#'   optionally with noise.
#'
#' @details
#'
#' The archimedean spiral starts at the origin and wraps around itself such that
#' distances between all the spiral branches are equivalent. The specific
#' parametrization was taken from Koeller (2002). The uniform sample is
#' generated through a rejection sampling process as described by Diaconis
#' (2013).
#'
#' The swiss roll sampler is patterned after one in
#' [drtoolbox](https://lvdmaaten.github.io/drtoolbox/) and extended from the
#' archimedian spiral sampler.
#' 

#' @template ref-koeller2002
#' @template ref-diaconis2013
#' 

#' @name arch-spirals
#' @param n Number of observations.
#' @param ar Aspect ratio of spiral (ratio of width/height)
#' @param arms Number of spiral arms.
#' @param min_wrap The wrap of the spiral from which sampling begins.
#' @param max_wrap The wrap of the spiral at which sampling ends.
#' @param width Width of the swiss roll (with respect to the radius of the
#'   spiral at one wrap).
#' @param sd Standard deviation of (independent multivariate) Gaussian noise.
#' @example inst/examples/ex-archimedean-spirals.r
NULL

#' @rdname arch-spirals
#' @export
sample_arch_spiral <- function(
  n, ar = 1, arms = 1L, min_wrap = 0, max_wrap = 1, sd = 0
) {
  theta <- rs_spiral(n, min_wrap, max_wrap)
  #Applies modified theta values to parametric equation of spiral
  res <- cbind(
    x = ar * (theta * cos(theta)),
    y = (theta * sin(theta))
  )
  #Partitions the sample into arms and rotates each accordingly
  arms <- as.integer(arms)
  if (arms > 1L) {
    arm <- sample(arms, nrow(res), replace = TRUE) - 1L
    rot <- seq(arms - 1L) * 2*pi / arms
    res <- do.call(rbind, c(
      list(res[arm == 0L, , drop = FALSE]),
      lapply(seq(arms - 1L), function(i) {
        res[arm == i, , drop = FALSE] %*%
          matrix(
            c(cos(rot[i]), sin(rot[i]), -sin(rot[i]), cos(rot[i])),
            nrow = 2
          )
      })
    ))
  }
  #Adds Gaussian noise to the spiral
  add_noise(res, sd = sd)
}

#' @rdname arch-spirals
#' @export
sample_swiss_roll <- function(
  n, arms = 1L, min_wrap = 0, max_wrap = 1, width = 2*pi, sd = 0
) {
  #Samples uniformly from the archimedian spiral on which the swiss roll is a
  #cylinder
  res <- sample_arch_spiral(
    n = n, arms = arms, min_wrap = min_wrap, max_wrap = max_wrap,
    sd = 0
  )
  #Augments the archimedian spiral sample with a third coordinate uniformly
  #sampled over the fixed range `width`
  res <- cbind(res, z = runif(n, 0, width))
  #Adds Gaussian noise to the spiral
  add_noise(res, sd = sd)
}

#Rejection sampler
rs_spiral <- function(n, min_wrap, max_wrap){
  #Sets the minimum and maximum values of theta according to number of spirals
  #the user desired
  min_theta <- min_wrap * 2*pi
  max_theta <- max_wrap * 2*pi
  x <- c()
  #Keep looping until desired number of observations is achieved
  while(length(x) < n){
    theta <- runif(n, min_theta, max_theta)
    jacobian <- jd_spiral()
    #Applies the jacobian scalar value to each value of theta
    jacobian_theta <- sapply(theta, jacobian)
    #Density threshold is the greatest jacobian value in the spiral, and the
    #area of least warping
    density_threshold <- runif(n, 0, max_theta)
    #Takes theta values that exceed the density threshold, and throws out the
    #rest
    x <- c(x, theta[jacobian_theta > density_threshold])
  }
  x[1:n]
}

#Jacobian determinant of archimedean spiral
jd_spiral <- function() {
  function(theta) sqrt(1 + theta^2)
}
