#Uniformly sampled equilateral planar triangle in 2-space
equilateral_triangle <- cbind(c(0,0), c(0.5,sqrt(3)/2), c(1,0))
x <-  sample_planar_triangle(10000, equilateral_triangle)
plot(x, asp = 1, pch = 19, cex = .25)

#Stratified sample of equilateral planar triangle in 2-space with a resolution
#of 100 intervals per dimension
equilateral_triangle <- cbind(c(0,0), c(0.5,sqrt(3)/2), c(1,0))
x <-  sample_planar_triangle(10000, equilateral_triangle, 100)
plot(x, asp = 1, pch = 19, cex = .25)
