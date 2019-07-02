# circle in 2-space
x <- sample_circle(120, sd = .1)
plot(x, asp = 1, pch = 19, cex = .5)

# interlocked circles in 3-space
x <- sample_circles_interlocked(120, sd = .1)
pairs(x, asp = 1, pch = 19, cex = .5)

# sinusoidal circle in 3-space
x <- sample_circle_sinusoidal(120, sd = .1)
pairs(x, asp = 1, pch = 19, cex = .5)
