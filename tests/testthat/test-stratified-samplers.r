context("stratified samplers")

test_that("samples are uniformly stratified when intervals divide size", {
  p <- 3L
  
  # 1D function
  sam <- sample_strat_segment(p^2, p)
  tab <- table(floor((sam %% 1/p) * p^2))
  expect_equal(as.vector(tab), rep(p, p))
  # 2D function
  sam <- sample_strat_square(p^3, p)
  tab <- table(as.data.frame(apply(sam, 2L,
                                   function(x) floor((x %% 1/p) * p^2))))
  expect_equal(as.vector(tab), rep(p, p^2))
  # 3D function
  sam <- sample_strat_cube(p^4, p)
  tab <- table(as.data.frame(apply(sam, 2L,
                                   function(x) floor((x %% 1/p) * p^2))))
  expect_equal(as.vector(tab), rep(p, p^3))
  
  # arbitrary-dimension function
  # 1D
  sam <- sample_stratify(p^2, p, 1)
  tab <- table(floor((sam %% 1/p) * p^2))
  expect_equal(as.vector(tab), rep(p, p))
  # 2D
  sam <- sample_stratify(p^3, p, 2)
  tab <- table(as.data.frame(apply(sam, 2L,
                                   function(x) floor((x %% 1/p) * p^2))))
  expect_equal(as.vector(tab), rep(p, p^2))
  # 3D
  sam <- sample_stratify(p^4, p, 3)
  tab <- table(as.data.frame(apply(sam, 2L,
                                   function(x) floor((x %% 1/p) * p^2))))
  expect_equal(as.vector(tab), rep(p, p^3))
  # 4D
  sam <- sample_stratify(p^5, p, 4)
  tab <- table(as.data.frame(apply(sam, 2L,
                                   function(x) floor((x %% 1/p) * p^2))))
  expect_equal(as.vector(tab), rep(p, p^4))
})

test_that("samples are uniform when intervals and size are incommensurate", {
  # 1D function
  sam <- sample_strat_segment(29, 7)
  tab <- table(floor((sam %% 1/7) * 7^2))
  expect_true(all(as.vector(tab) %in% c(floor(29/7), ceiling(29/7))))
  # 2D function
  sam <- sample_strat_square(29, 5)
  tab <- table(as.data.frame(apply(sam, 2L,
                                   function(x) floor((x %% 1/5) * 5^2))))
  expect_true(all(as.vector(tab) %in% c(floor(29/(5^2)), ceiling(29/(5^2)))))
  # 3D function
  sam <- sample_strat_cube(29, 3)
  tab <- table(as.data.frame(apply(sam, 2L,
                                   function(x) floor((x %% 1/3) * 3^2))))
  expect_true(all(as.vector(tab) %in% c(floor(29/(3^3)), ceiling(29/(3^3)))))
})
