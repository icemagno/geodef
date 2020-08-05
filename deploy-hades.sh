#! /bin/sh

cd guardiao-manager/
svn update
mvn clean package

mkdir -p /srv/hades/fotos
cp nophoto.png /srv/hades/fotos/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/hades:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/hades:1.0
docker build --tag=sisgeodef/hades:1.0 --rm=true .

docker run --name hades --hostname=hades \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-v /etc/localtime:/etc/localtime:ro \
-p 36201:36201 \
-v /srv/hades/fotos:/fotos/ \
-d sisgeodef/hades:1.0

docker network connect sisgeodef hades
docker network connect apolo hades