#Stratified sample of a unit square with 100 cells
x <- stratified_square(110,10)
plot(x, asp = 1, pch = 19, cex = .5)
segments(x0 = seq(0,1,.1),y0 = 0, y1 = 1)
segments(y0 = seq(0,1,.1),x0 = 0, x1 = 1)
