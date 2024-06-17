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
* R-hub
  * `rhub::rhub_check(platforms = c("linux", "clang19", "gcc14", "intel", "ubuntu-clang"))`

{vdiffr} tests are skipped on CRAN and when not installed, using `testthat::skip_*()`.

### local OS X installs

There were no ERRORs, WARNINGs, or NOTEs.

### Win-Builder

There were no ERRORs or WARNINGs. Some checks yielded the following NOTE:

```
Found the following (possibly) invalid URLs:
  URL: https://projecteuclid.org/euclid.imsc/1379942050
    From: inst/doc/tdaunif.html
          README.md
    Status: 500
    Message: Internal Server Error
```

The URL <https://projecteuclid.org/euclid.imsc/1379942050> redirects to <https://projecteuclid.org/ebooks/institute-of-mathematical-statistics-collections/Advances-in-Modern-Statistical-Theory-and-Applications--A-Festschrift/chapter/Sampling-from-a-Manifold/10.1214/12-IMSCOLL1006>, but replacing the URL in the documentation did not resolve the NOTE.

### R-hub

There were no ERRORs, WARNINGs, or NOTEs.

## Downstream dependencies

There are no downstream dependencies on CRAN or on Bioconductor.
