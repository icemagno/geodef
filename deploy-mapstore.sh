#! /bin/sh

mkdir /srv/mapstore/
cd mapstore
svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/mapstore | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/mapstore
docker build --tag=sisgeodef/mapstore .


docker run -it --name mapstore --hostname=mapstore \
-e HTTP_PROXY="172.22.200.10:3128" \
-e HTTPS_PROXY="172.22.200.10:3128" \
-p 36780:8080 \
-d sisgeodef/mapstore

docker network connect apolo mapstore
docker network connect sisgeodef mapstore

# https://github.com/igac-geoportal/MapStore2
# http://sisgeodef.defesa.mil.br:36780/mapstore
# admin / admin