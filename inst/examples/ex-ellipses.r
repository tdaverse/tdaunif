# ellipse in 2-space
x <- sample_ellipse(120, ar = 6)
plot(x, asp = 1, pch = 19, cex = .5)

# ellipse in 2-space
x <- sample_ellipse(120, ar = 1/6)
plot(x, asp = 1, pch = 19, cex = .5)

# ellipse in 2-space
x <- sample_ellipse(120, ar = 6, sd = .1/6)
plot(x, asp = 1, pch = 19, cex = .5)

# ellipse in 2-space
x <- sample_ellipse(120, ar = 1/6, sd = .1)
plot(x, asp = 1, pch = 19, cex = .5)
