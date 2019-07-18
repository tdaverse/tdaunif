# Uniformly sampled trefoil knot in 3-space
x <- sample_trefoil(180)
pairs(x, asp = 1, pch = 19, cex = .5, col = "#00000077")

# Uniformly sampled trefoil knot in 3-space, with Gaussian noise
x <- sample_trefoil(180, sd = .1)
pairs(x, asp = 1, pch = 19, cex = .5, col = "#00000077")
