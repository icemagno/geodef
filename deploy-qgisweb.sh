#! /bin/sh

#docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/atlas-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
#docker rmi sisgeodef/atlas-db:1.0
#docker build --tag=sisgeodef/atlas-db:1.0 --rm=true .

docker run --name qgis-server --hostname=qgis-server \
-e QGIS_PROJECT_FILE='' \
-v /srv/qgis:/gis \
-p 63548:80 \
-d kartoza/qgis-server:LTR

docker network connect sisgeodef qgis-server
docker network connect apolo qgis-server