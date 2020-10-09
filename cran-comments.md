## Test environments

* local OS X install, R 4.0.0 (via `devtools::check()`)
* win-builder (devel, current, and previous; via `devtools::check_win_*()`)
* Rhub (via `rhub::check_for_cran()`)

**vdiffr** tests are skipped on CRAN and when not installed, using `testthat::skip_*()`.

## Test results

All tests produced NOTES about possibly misspelled words, all of which are names or standard initialisms and have been verified.

### R CMD check results

There were no ERRORs, WARNINGs, or NOTEs.

### Rhub

There were no ERRORs or WARNINGs. On one platform (Ubuntu Linux 16.04 LTS, R-release, GCC), one ERROR was due to vdiffr being suggested but not available.

### WinBuilder

There were no ERRORs. On the development platform (x86_64-w64-mingw32, 2020-10-09 r79316), one NOTE flagged that the LICENSE file is not mentioned in the DESCRIPTION (only "GPL-3" is mentioned, which for other packages has been enough) and flagged non-standard files (CODE_OF_CONDUCT.md, etc) that are already included in .Rbuildignore.

## Downstream dependencies

There are no downstream dependencies on CRAN or on Bioconductor.
