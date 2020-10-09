set.seed(97205L)

# ellipses in 2-space
x <- sample_ellipse(120, ar = 6)
plot(x, asp = 1, pch = 19, cex = .5)
x <- sample_ellipse(120, ar = 1/6)
plot(x, asp = 1, pch = 19, cex = .5)

# ellipses in 2-space
x <- sample_ellipse(120, ar = 6, sd = .1/6)
plot(x, asp = 1, pch = 19, cex = .5)
x <- sample_ellipse(120, ar = 1/6, sd = .1)
plot(x, asp = 1, pch = 19, cex = .5)

# cylinders in 3-space
x <- sample_cylinder_elliptical(120, ar = 1)
pairs(x, asp = 1, pch = 19, cex = .5)
x <- sample_cylinder_elliptical(120, ar = 3, width = 2*pi)
pairs(x, asp = 1, pch = 19, cex = .5)
