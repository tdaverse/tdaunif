set.seed(5898L)

# Möbius strip embedding in 3-space
x <- sample_mobius_rotoid(180, ar = 1.5, sd = 0.02)
pairs(x, asp = 1, pch = 19, cex = .5)
