#Uniformly sampled archimedean spiral in 2-space, with 1 wrap
x <- sample_arch_spiral(360, min_wrap = 0, max_wrap = 1)
plot(x, asp = 1, pch = 19, cex = .5)

#Uniformly sampled archimedean spiral in 2-space, with 5 wraps
x <- sample_arch_spiral(360, min_wrap = 0, max_wrap = 5)
plot(x, asp = 1, pch = 19, cex = .5)

#Uniformly sampled archimedean spiral in 2-space, with 5 wraps and starting from
#2 wraps
x <- sample_arch_spiral(360, min_wrap = 2, max_wrap = 5)
plot(x, asp = 1, pch = 19, cex = .5)

#Uniformly sampled archimedian spiral, from 1 to 2 wraps, with 3 arms
x <- sample_arch_spiral(360, arms = 3, min_wrap = 1, max_wrap = 2)
plot(x, asp = 1, pch = 19, cex = .5)

#Uniformly sampled archimedean spiral in 2-space, with 1 wrap and noise with a
#standard deviation of 0.1
x <- sample_arch_spiral(360, min_wrap = 0, max_wrap = 1, sd = 0.1)
plot(x, asp = 1, pch = 19, cex = .5)

#Uniformly sampled swiss roll in 3-space, from 0 to 1 wraps and width 2*pi
x <- sample_swiss_roll(720, width = 2*pi)
pairs(x, asp = 1, pch = 19, cex = .5)
pca <- prcomp(x)
plot(x %*% pca$rotation, asp = 1, pch = 19, cex = .5)
