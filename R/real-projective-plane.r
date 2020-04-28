sample_projective_plane <- function(n) {
  rho <- runif(n, 0, 1)
  theta <- runif(n, 0, 2*pi)
  phi <- runif(n, 0, pi)
  res <- cbind(
    x = (rho*sin(phi)*cos(theta))*(rho*sin(phi)*sin(theta)),
    y = (rho*sin(phi)*cos(theta))*(rho*cos(phi)),
    z = (rho*sin(phi)*sin(theta))^2 - (rho*cos(phi))^2,
    w = 2 * (rho*sin(phi)*sin(theta)) * (rho*cos(phi))
  )
}

#Test code
x <- sample_projective_plane(120)
pairs(x, asp = 1, pch = 19, cex = .5)
