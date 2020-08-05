#! /bin/sh

mkdir /srv/grass
cd grass

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/grass | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/grass
docker build --tag=sisgeodef/grass .

docker run -it --name grass --hostname=grass \
-v /srv/grass/:/data/ \
-v /srv/srtm/:/srtm/ \
-d  sisgeodef/grass /bin/bash

docker network connect apolo grass
docker network connect sisgeodef grass