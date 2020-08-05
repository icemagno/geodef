#! /bin/sh

cd nautilo/
svn update
mvn clean package

mkdir /srv/nautilo/gdal/
mkdir /srv/nautilo/files/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/nautilo:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/nautilo:1.0
docker build --tag=sisgeodef/nautilo:1.0 --rm=true .

docker run --name nautilo --network apolo --hostname=nautilo \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-p 36309:36309 \
-v /srv/nautilo/gdal/:/data/ \
-v /srv/nautilo/files/:/download-files/ \
-v /etc/localtime:/etc/localtime:ro \
-d sisgeodef/nautilo:1.0	


cp ./files/* /srv/nautilo/files/
cp ./ogr.sh /srv/nautilo/gdal/
cp ./*.gml /srv/nautilo/gdal/
chmod 0777 /srv/nautilo/gdal/ogr.sh

docker network connect sisgeodef nautilo
