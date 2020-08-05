#! /bin/sh

svn update
mkdir /srv/rbase/

docker ps -a | awk '{ print $1,$2 }' | grep r-base | awk '{print $1 }' | xargs -I {} docker rm -f {}
#docker rmi r-base

docker run --name rbase --network apolo --hostname=rbase \
	-ti \
	-e ftp_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/" \
	-e http_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/" \
	-e https_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/" \
	-v /etc/localtime:/etc/localtime:ro \
	-w /home/docker \
	-v /srv/rbase/:/home/docker \
	-d r-base

docker network connect sisgeodef rbase

# Criar um Dockerfile!
# apt-get update & apt-get install -y libproj-dev xorg libx11-dev libglu1-mesa-dev libfreetype6-dev libgdal-dev --fix-missing



# docker attach rbase
# install.packages(c("proj4"))
# install.packages(c("reproj"))
# install.packages(c("remotes", "quadmesh", "rgl"))
# install.packages(c("raster"))
# install.packages(c("rgdal"))

options(rgl.useNULL=TRUE)

library(rgdal)
library(raster)
library(ceramic)

#dem <- raster("/home/docker/S14W042.hgt")
#im <- brick(system.file("/home/docker/S14W042.map.png", package="raster") ) 
#im <- brick("/home/docker/S14W042_hill_contour.png")
#qm <- quadmesh::quadmesh(dem, texture = im)  ## DEMORA PRA PORRA

rgl::shade3d(qm, lit = FALSE);  # <<<<---- FALTA RODAR ISSO !

# http://sisgeodef.defesa.mil.br:36212/geoserver/volcano/wms?service=WMS&srs=EPSG:4326&width=900&height=900&version=1.1.1&request=GetMap&layers=volcano:curvas-hillshade&format=image/png&bbox=-42,-14,-40,-12 

https://github.com/hypertidy/ceramic/blob/master/README.Rmd


> (im <- cc_location(roi, base_url=u))
class      : RasterBrick
dimensions : 774, 684, 529416, 3  (nrow, ncol, ncell, nlayers)
resolution : 9783.94, 9783.94  (x, y)
extent     : 11124339, 17816554, -6056259, 1516511  (xmin, xmax, ymin, ymax)
crs        : +proj=merc +a=6378137 +b=6378137
source     : memory
names      : layer.1, layer.2, layer.3
min values :       0,       0,       0
max values :     253,     255,     236


Sys.setenv(MAPBOX_API_KEY="fdfsdfsdfsdfsdf")
roi <- raster::extent(100, 160, -50, 10)  ## <<-----  esquerda, direita, sul, norte
u <- "https://services.arcgisonline.com/arcgis/rest/services/World_Imagery/MapServer/tile/{zoom}/{y}/{x}"
im <- cc_location( roi, base_url = u, zoom = 7)
qm <- quadmesh::quadmesh(dem, texture = im)


png(filename="/home/docker/name.png")
ou
pdf()

plotRGB(im)
dev.off()

rgl::shade3d(qm, lit = FALSE)