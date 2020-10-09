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

On some platforms, one NOTE flagged the example runtime issue above (with a 5s threshold). On one platform (Fedora Linux, R-devel, clang, gfortran), several NOTEs flagged additional example runtime issues.

On one platform (Ubuntu Linux 16.04 LTS, R-release, GCC), one ERROR was due to **vdiffr** being suggested but not available, and two NOTEs flagged possibly invalid URLs, both of which have been verified.

### WinBuilder

There were no ERRORs. Each run produced the WARNING "checking CRAN incoming feasibility" of unknown cause. On some runs, one NOTE flagged several last names in the DESCRIPTION as possibly misspelled words. (These have been checked.)

## Downstream dependencies

There are no downstream dependencies on CRAN or on Bioconductor.
