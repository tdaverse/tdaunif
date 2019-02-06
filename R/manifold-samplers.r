#' @title Custom uniform manifold samplers
#'
#' @description These functions create rejection samplers, and uniform manifold
#'   samplers based on them, using user-provided parameterization and Jacobian
#'   functions.
#'
#' @details (Details.)
#'   

#' @name manifold
#' @param parameterization A function that takes a matrix of parameter vectors
#'   and returns a matrix of coordinates.
#' @param jacobian A function that takes a matrix of parameter vectors and
#'   returns a vector of Jacobian determinants.
#' @param max_params Named vector of maximum values of the parameters, used for
#'   uniform sampling; minimum values must be zero.
#' @param max_jacobian An (ideally sharp) upper bound on the Jacobian
#'   determinant.
#' @example inst/examples/ex-manifold-samplers.r
NULL

#' @rdname manifold
#' @export
make_manifold_sampler <- function(
  parameterization, jacobian, max_params, max_jacobian
) {
  # rejection sampler
  rs <- make_manifold_rejection_sampler(jacobian, max_params, max_jacobian)
  # manifold sampler
  function(n, sd = 0) {
    param_vals <- rs(n)
    res <- parameterization(param_vals)
    add_noise(res, sd = sd)
  }
}

#' @rdname manifold
#' @export
make_manifold_rejection_sampler <- function(
  jacobian, max_params, max_jacobian
) {
  # rejection sampler
  function(n) {
    x <- matrix(NA, nrow = 0, ncol = length(max_params))
    while (nrow(x) < n) {
      param_vals <- sapply(max_params, runif, n = n, min = 0)
      j_vals <- jacobian(param_vals)
      density_threshold <- runif(n, 0, max_jacobian)
      x <- rbind(x, param_vals[j_vals > density_threshold, , drop = FALSE])
    }
    x[1:n, , drop = FALSE]
  }
}
