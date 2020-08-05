#! /bin/sh

cd base-gdal/
svn update

docker rmi sisgeodef/base-gdal:1.0
docker build --tag=sisgeodef/base-gdal:1.0 --rm=true .
