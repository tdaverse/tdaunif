# multivariate uncorrelated Gaussian noise
rmvunorm <- function(n, d, sd = 1) {
  replicate(d, stats::rnorm(n = n, sd = sd))
}
