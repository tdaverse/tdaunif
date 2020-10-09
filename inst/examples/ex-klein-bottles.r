set.seed(834L)

# Klein bottle tube embedding in 4-space
x <- sample_klein_tube(120, sd = .05)
pairs(x, asp = 1, pch = 19, cex = .5)

# Klein bottle flat torus-based embedding in 4-space
x <- sample_klein_flat(120, sd = .05)
pairs(x, asp = 1, pch = 19, cex = .5)
