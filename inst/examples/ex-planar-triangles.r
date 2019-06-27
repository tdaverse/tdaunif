#Uniformly sampled equilateral planar triangle in 2-space
equilateral_triangle <- cbind(c(0,0), c(0.5,sqrt(3)/2), c(1,0))
x <-  sample_planar_triangle(1800, equilateral_triangle)
plot(x, asp = 1, pch = 19, cex = .5)
