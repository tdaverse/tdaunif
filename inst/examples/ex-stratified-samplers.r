#Stratified sample of a unit square with 100 cells
x <- stratified_square(110,10)
plot(x, asp = 1, pch = 19, cex = .5, xlab = 'x', ylab = 'y')
segments(x0 = seq(0,1,.1),y0 = 0, y1 = 1)
segments(y0 = seq(0,1,.1),x0 = 0, x1 = 1)

#Stratified sample in 1-dimension with 10 intervals
x <- stratified_segment(13,10)
plot(x, asp = 1, pch = 19, cex = .5, xlab = 'x', ylab = '')
segments(x0 = seq(0,1,.1),y0 = -1, y1 = 1)
