#! /bin/sh

cd icaro/
svn update
mvn clean package

mkdir /srv/icaro/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/icaro:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/icaro:1.0
docker build --tag=sisgeodef/icaro:1.0 --rm=true .

docker run --name icaro --hostname=icaro \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-p 36311:36311 \
-v /srv/icaro/:/data/ \
-v /etc/localtime:/etc/localtime:ro \
-d sisgeodef/icaro:1.0	

cp ./ogr.sh /srv/icaro/
chmod 0777 /srv/icaro/ogr.sh

docker network connect sisgeodef icaro
docker network connect apolo icaro