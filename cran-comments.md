## tdaunif v0.2.0

This is a new minor version.

## Test environments

* local OS X install, R v4.2.3
  * `devtools::check()`
  * `devtools::check(env_vars = c('_R_CHECK_DEPENDS_ONLY_' = "true"))`
* local OS X install, R v4.3.2
  * `devtools::check()`
  * `devtools::check(env_vars = c('_R_CHECK_DEPENDS_ONLY_' = "true"))`
* Win-Builder
  * `devtools::check_win_oldrelease()`
  * `devtools::check_win_release()`
  * `devtools::check_win_devel()`
* R-hub: Currently setting up R-hub checks as recommended in v2.

**vdiffr** tests are skipped on CRAN and when not installed, using `testthat::skip_*()`.

### local OS X installs

There were no ERRORs, WARNINGs, or NOTEs.

### R-hub

### Win-Builder

## Downstream dependencies

There are no downstream dependencies on CRAN or on Bioconductor.
