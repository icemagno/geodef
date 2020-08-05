#! /bin/sh

cd gaia/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/gaia:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/gaia:1.0
docker build --tag=sisgeodef/gaia:1.0 --rm=true .

docker run --name gaia --hostname=gaia \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-v /etc/localtime:/etc/localtime:ro \
-p 36207:36207 \
-d sisgeodef/gaia:1.0


docker network connect sisgeodef gaia
docker network connect apolo gaia