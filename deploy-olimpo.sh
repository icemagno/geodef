#! /bin/sh

cd olimpo
svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/olimpo:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/olimpo:1.0

docker build --tag=sisgeodef/olimpo:1.0 --rm=true .

docker run --name olimpo --hostname=olimpo  \
-v /etc/localtime:/etc/localtime:ro \
-v /srv/olimpo/:/data/ \
-e SERVE_STATIC=0 \
-e LOG_LEVEL=debug \
-d sisgeodef/olimpo:1.0

docker network connect apolo olimpo
docker network connect sisgeodef olimpo

