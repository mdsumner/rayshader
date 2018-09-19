m <- matrix(c(1:5, 5, 6:1), 3, 4)
l <- list(x = seq(1, nrow(m)), y = seq(1, ncol(m)), z = m)

r <- raster::raster(l)

library(raster)
library(rayshader)
## in master these don't fall correctly in the centre
plot_map(ambient_shade(t(as.matrix(r))))
points(coordinates(r))

## this does not change
rgl::clear3d()
plot_3d(ambient_shade(t(as.matrix(r))), t(as.matrix(r)), zscale = 10)
rgl::points3d(cbind(xFromCell(r, 1:ncell(r)), (values(flip(r, "y")) + 1)/10, yFromCell(r, 1:ncell(r)) - nrow(r)-1), col = "red")
rgl::rglwidget()












##raster::plotRGB(raster::brick(array_from_mat, xmn = 1, xmx = dim(array_from_mat)[2],ymn = 1, ymx = dim(array_from_mat)[1], ...)