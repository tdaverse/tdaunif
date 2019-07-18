#Uniformly sampled equilateral planar triangle in 2-space
equilateral_triangle <- cbind(c(0,0), c(0.5,sqrt(3)/2), c(1,0))
x <-  sample_planar_triangle(10000, equilateral_triangle)
plot(x, asp = 1, pch = 19, cex = .25)

#Stratified sample of equilateral planar triangle in 2-space with 100 bins
equilateral_triangle <- cbind(c(0,0), c(0.5,sqrt(3)/2), c(1,0))
x <-  sample_planar_triangle(10000, equilateral_triangle, bins = 100)
plot(x, asp = 1, pch = 19, cex = .25)

#Uniformly sampled equilateral planar triangle in 2-space with Gaussian noise
equilateral_triangle <- cbind(c(0,0), c(0.5,sqrt(3)/2), c(1,0))
x <-  sample_planar_triangle(10000, equilateral_triangle, sd = .1)
plot(x, asp = 1, pch = 19, cex = .25)
