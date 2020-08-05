#! /bin/sh

mkdir /srv/thredds/
cd thredds
svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/thredds | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/thredds
docker build --tag=sisgeodef/thredds .

cp ./*.xml /srv/thredds/

docker run --name thredds --hostname=thredds \
-p 36485:8080 \
-v /srv/thredds:/usr/local/tomcat/content/thredds \
-d sisgeodef/thredds

docker network connect apolo thredds
docker network connect sisgeodef thredds
