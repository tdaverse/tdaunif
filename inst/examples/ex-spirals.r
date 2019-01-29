
# 1 spiral in 2-space
x <- sample_spirals(120, s = 1, sd = .2)
plot(x, asp = 1, pch = 19, cex = .5)

# 3 spirals in 2-space
x <- sample_spirals(120, s = 3, sd = .2)
plot(x, asp = 1, pch = 19, cex = .5)
