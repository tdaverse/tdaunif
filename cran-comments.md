## Resubmission

This resubmission was prompted by an email from the maintainers about the `_PKGNAME` documentation issue. It is a patch that also addresses some other problems as documented in 'NEWS.md'.

## Test environments

* local OS X install, R 4.1.1 (via `devtools::check()`)
* win-builder (devel, current, and previous; via `devtools::check_win_*()`)
* Rhub (via `rhub::check_for_cran()`)

**vdiffr** tests are skipped on CRAN and when not installed, using `testthat::skip_*()`.

## Test results

All remote tests NOTEd one or both of two URLs, <https://projecteuclid.org/euclid.imsc/1379942050> and <https://dl.acm.org/doi/10.1145/218380.218500>.
The first redirects to <https://projecteuclid.org/ebooks/institute-of-mathematical-statistics-collections/Advances-in-Modern-Statistical-Theory-and-Applications--A-Festschrift/chapter/Sampling-from-a-Manifold/10.1214/12-IMSCOLL1006>, and the second is redirected from the standard <https://doi.org/10.1145/218380.218500> provided at the site.
Replacing either with the alternative did not resolve the NOTE.

### R CMD check results

There were no ERRORs, WARNINGs, or NOTEs.

### Rhub

There were no ERRORs or WARNINGs.

One platform (Fedora Linux, R-devel, clang, gfortran) obtained the following NOTEs:

```
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found
Skipping checking math rendering: package 'V8' unavailable
```

Another (Windows Server 2022, R-devel, 64 bit) obtained the following NOTEs:

```
* checking HTML version of manual ... NOTE
* checking for non-standard things in the check directory ... NOTE
Found the following files/directories:
Skipping checking math rendering: package 'V8' unavailable
  ''NULL''
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```

Per [this discussion](https://github.com/r-hub/rhub/issues/503), the last NOTE is due to a bug and can be ignored.
I have no insight into the other three.

### WinBuilder

There were no ERRORs or WARNINGs.

## Downstream dependencies

There are no downstream dependencies on CRAN or on Bioconductor.
