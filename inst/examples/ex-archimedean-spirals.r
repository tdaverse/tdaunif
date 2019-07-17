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
