#' @title Custom uniform manifold samplers
#'
#' @description These functions create rejection samplers, and uniform manifold
#'   samplers based on them, using user-provided parameterization and Jacobian
#'   functions.
#'
#' @details The rejection sampling technique of Diaconis, Holmes, and
#'   Shahshahani (2013) uses a parameterized embedding from a parameter space to
#'   a coordinate space and relies on a formula for its jacobian determinant.
#'   The `parameterization` must be a function that takes vector arguments of
#'   equal length and returns a coordinate matrix of the same number of rows.
#'   The `jacobian` must be a function that takes the same arguments and returns
#'   a scalar value. The parameters must range from 0 to their respective values
#'   in `max_params`. `max_jacobian` must be provided, though it may be larger
#'   than the theoretical maximum of the jacobian determinant.
#'   

#' @template ref-diaconis2013
#' 

#' @name manifold
#' @param parameterization A function that takes parameter vector arguments and
#'   returns a matrix of coordinates.
#' @param jacobian A function that takes parameter vector arguments and returns
#'   a vector of Jacobian determinants.
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
    res <- do.call(parameterization, as.data.frame(param_vals))
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
      j_vals <- do.call(jacobian, as.data.frame(param_vals))
      density_threshold <- runif(n, 0, max_jacobian)
      x <- rbind(x, param_vals[j_vals > density_threshold, , drop = FALSE])
    }
    x[1:n, , drop = FALSE]
  }
}
