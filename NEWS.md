# tdaunif 0.2.0

This minor version provides two new samplers:

* Annuli in the plane, as a parameterized extension of the disk.
* The rotoid embedding of the Möbius strip in 3-space, which involves computing a Jacobian in two parameters.

# tdaunif 0.1.1

This patch fixes miscalculated coordinates for interlocked tori (`sample_tori_interlocked()`) that caused an error and adds an example to ensure that the sampler runs without error.

It also addresses an issue related to `_PKGNAME` documentation, which has been addressed using `@aliases` as described [here](https://github.com/r-lib/roxygen2/issues/1491).

The key--value pair `LazyData: true` was removed from 'DESCRIPTION', which should resolve the NOTE at the CRAN check results.

Finally, several spelling errors were corrected.

# tdaunif 0.1.0

This first minor version contains several common samplers, stratified samplers for cubes in any dimension, and a function factory for custom rejection samplers.
