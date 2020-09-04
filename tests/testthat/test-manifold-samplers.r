context("custom manifold samplers")

test_that("custom klein bottle sampler produces a recognizable sample", {
  klein_param <- function(theta, phi) {
    cbind(
      x = (1 + cos(theta)) * cos(phi),
      y = (1 + cos(theta)) * sin(phi),
      z = sin(theta) * cos(phi/2),
      w = sin(theta) * sin(phi/2)
    )
  }
  klein_jacobian <- function(theta, phi) {
    sqrt((1 + cos(theta)) ^ 2 + (.5 * sin(theta)) ^ 2)
  }
  klein_sampler <- make_manifold_sampler(
    klein_param, klein_jacobian,
    max_params = c(theta = 2*pi, phi = 2*pi),
    max_jacobian = 4 + .25
  )
  set.seed(0)
  klein_sample <- klein_sampler(120, sd = .01)
  
  skip_on_cran()
  skip_if_not_installed("vdiffr")
  vdiffr::expect_doppelganger(
    "custom Klein bottle sample pairs plot",
    pairs(klein_sample)
  )
})
