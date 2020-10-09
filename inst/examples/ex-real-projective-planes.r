set.seed(22764L)

# real projective plane embedding in 4-space
x <- sample_projective_plane(120)
pairs(x, asp = 1, pch = 19, cex = .5)
