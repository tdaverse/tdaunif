
# 1-sphere in 2-space
x <- sample_sphere(120, dim = 1, sd = .1)
pairs(x, asp = 1, pch = 19, cex = .5)

# 2-sphere in 3-space
x <- sample_sphere(120, dim = 2, sd = .1)
pairs(x, asp = 1, pch = 19, cex = .5)

# 3-sphere in 4-space
x <- sample_sphere(120, dim = 3, sd = .1)
pairs(x, asp = 1, pch = 19, cex = .5)

# 4-sphere in 5-space
x <- sample_sphere(120, dim = 4, sd = .1)
pairs(x, asp = 1, pch = 19, cex = .5)
