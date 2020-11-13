#! /bin/sh

mkdir -p /srv/midas/atlas/
mkdir -p /srv/midas/atlas/logos/
mkdir -p /srv/calisto/scripts/


cp calisto/scripts/* /srv/calisto/scripts/
cp -R midas245/resources/atlas/* /srv/midas/atlas/


cd atlas/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/atlas:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/atlas:1.0
docker build --tag=sisgeodef/atlas:1.0 --rm=true .

docker run --name atlas --hostname=atlas \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-v /etc/localtime:/etc/localtime:ro \
-v /srv/calisto/:/srv/calisto/ \
-e CONFIG_PROFILES=default \
-p 36215:36215 \
-d sisgeodef/atlas:1.0

docker network connect sisgeodef atlas
docker network connect apolo atlas
