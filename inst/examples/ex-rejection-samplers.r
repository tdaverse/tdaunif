# parameterization and Jacobian for Klein bottle tube embedding
klein_parameterization <- function(theta, phi) {
  cbind(
    w = (1 + .5 * cos(theta)) * cos(phi),
    x = (1 + .5 * cos(theta)) * sin(phi),
    y = .5 * sin(theta) * cos(phi/2),
    z = .5 * sin(theta) * sin(phi/2)
  )
}
klein_jacobian <- function(theta, phi) {
  unname(.5 * sqrt((1 + .5 * cos(theta)) ^ 2 + (.5 * .5 * sin(theta)) ^ 2))
}
# custom sampler based on these functions
klein_sampler <- make_rejection_sampler(
  klein_parameterization,
  klein_jacobian,
  max_params = c(theta = 2*pi, phi = 2*pi),
  max_jacobian = klein_jacobian(cbind(theta = 0))
)
# compare custom sampler to `sample_klein_tube()`
pairs(klein_sampler(n = 360), asp = 1, pch = 19, cex = .5)
pairs(sample_klein_tube(n = 360, ar = 2), asp = 1, pch = 19, cex = .5)
