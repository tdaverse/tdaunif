set.seed(5898L)

# Möbius strip embedding in 3-space
x <- sample_mobius_rotoid(180, ar = 1.5, sd = 0.02)
pairs(x, asp = 1, pch = 19, cex = .5)

# color-code points by coordinates
x_ran <- apply(x, 2L, range)
x_col <- rgb((x[, 1L] - x_ran[1L, 1L]) / (x_ran[2L, 1L] - x_ran[1L, 1L]),
             (x[, 2L] - x_ran[1L, 2L]) / (x_ran[2L, 2L] - x_ran[1L, 2L]),
             (x[, 3L] - x_ran[1L, 3L]) / (x_ran[2L, 3L] - x_ran[1L, 3L]))
pairs(x, asp = 1, pch = 19, cex = .75, col = x_col)

# shape-code by octant
x_pch <- apply(x > 0, 1L, \(l) sum(2L ^ seq(0L, 2L) * l))
pairs(x, asp = 1, cex = 1, pch = x_pch)
