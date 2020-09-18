# Uniformly sampled figure eight in 2-space
x <- sample_lemniscate_gerono(720)
plot(x, asp = 1, pch = 19, cex = .5)

# Naively sampled figure eight, for comparison
theta <- runif(n = 720, min = 0, max = 2*pi)
x_naive <- cbind(x = cos(theta), y <- cos(theta) * sin(theta))
plot(x_naive, asp = 1, pch = 19, cex = .5)

# Uniformly sampled figure eight in 2-space with Gaussian noise
x <- sample_lemniscate_gerono(720, 0.1)
plot(x, asp = 1, pch = 19, cex = .5)
