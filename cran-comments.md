## Resubmission

This is a resubmission following a response alerting me that i had not restored graphical settings after adjusting them in documentation using `par()`. This has been fixed in the README and in the vignette.

## Test environments

* local OS X install, R 4.0.0 (via `devtools::check()`)
* win-builder (devel, current, and previous; via `devtools::check_win_*()`)
* Rhub (via `rhub::check_for_cran()`)

**vdiffr** tests are skipped on CRAN and when not installed, using `testthat::skip_*()`.

## Test results

All remote tests produced NOTES about possibly misspelled words, all of which are names or standard initialisms and have been verified.

### R CMD check results

There were no ERRORs, WARNINGs, or NOTEs.

### Rhub

There were no ERRORs or WARNINGs.

On one platform (Ubuntu Linux 16.04 LTS, R-release, GCC), one ERROR was due to vdiffr being suggested but not available.

### WinBuilder

There were no ERRORs.

On the old release platform (x86_64-w64-mingw32, R version 3.6.3), one WARNING flagged a failure to convert README.md due to an image not being found. Weaving the file from its R Markdown source produces no new files, and each random step is set with a seed, so i don't know how this might be resolved.

## Downstream dependencies

There are no downstream dependencies on CRAN or on Bioconductor.
