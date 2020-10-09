## Test environments

* local OS X install, R 4.0.0 (via `devtools::check()`)
* Rhub (via `rhub::check_for_cran()`)
* win-builder (devel, current, and previous; via `devtools::check_win_*()`)

**vdiffr** tests are skipped on CRAN and when not installed, using `testthat::skip_*()`.

## Test results

All tests produced NOTES about possibly misspelled words, all of which are confirmed names or initialisms.

### R CMD check results

There were no ERRORs, WARNINGs, or NOTEs.

### Rhub

There were no ERRORs or WARNINGs.

### WinBuilder

## Downstream dependencies

There are no downstream dependencies on CRAN or on Bioconductor.
