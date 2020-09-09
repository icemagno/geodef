#! /bin/sh

cd graphhopper/
mkdir /srv/graphhopper/
svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/graphhopper:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/graphhopper:1.0

docker build --tag=sisgeodef/graphhopper:1.0 --rm=true .

cp config.yml /srv/graphhopper/
cp graphhopper-web-0.12.0.jar /srv/graphhopper/
cp /srv/osmfile/brazil-latest.osm.pbf /srv/graphhopper/

docker run --name graphhopper --hostname=graphhopper  \
-v /etc/localtime:/etc/localtime:ro \
-v /srv/graphhopper/:/data/ \
-d sisgeodef/graphhopper:1.0 -Dgraphhopper.datareader.file=/data/brazil-latest.osm.pbf -jar *.jar server /data/config.yml

docker network connect sisgeodef graphhopper
docker network connect apolo graphhopper