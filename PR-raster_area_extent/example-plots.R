m <- matrix(c(1:5, 5, 6:1), 3, 4)
l <- list(x = seq(1, nrow(m)), y = seq(1, ncol(m)), z = m)

r <- raster::raster(l)
qm <- quadmesh::quadmesh(flip(shift(r, y = -nrow(r) - 1), "y"))

z <- qm$vb[2, ]
qm$vb[2, ] <- qm$vb[3, ]/10
qm$vb[3, ] <- z

library(raster)
library(rayshader)
## in master these don't fall correctly in the centre
plot_map(ambient_shade(t(as.matrix(r))))
points(coordinates(r))

## this does not change
rgl::clear3d()
plot_3d(ambient_shade(t(as.matrix(r))), t(as.matrix(r)), zscale = 10)
rgl::points3d(cbind(xFromCell(r, 1:ncell(r)), (values(flip(r, "y")) + 1)/10, yFromCell(r, 1:ncell(r)) - nrow(r)-1), col = "red")
#rgl::shade3d(qm, col = "red")
rgl::wire3d(qm, col = "black")
rgl::rglwidget()

