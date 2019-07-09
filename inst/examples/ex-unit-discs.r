# Uniformly sampled unit disc in 2-space
x <- sample_unit_disc(1800, sd = 0)
plot(x, asp = 1, pch = 19, cex = .5)

# Uniformly sampled unit disc in 2-space with Gaussian noise
x <- sample_unit_disc(1800, sd = .1)
plot(x, asp = 1, pch = 19, cex = .5)
