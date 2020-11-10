#! /bin/sh

cd odisseu/
svn update
mvn clean package

mkdir /srv/odisseu/files/
mkdir /srv/odisseu/gdal/


docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/odisseu:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/odisseu:1.0
docker build --tag=sisgeodef/odisseu:1.0 --rm=true .

docker run --name odisseu --network apolo --hostname=odisseu \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-e http_proxy=http://172.22.200.10:3128 \
-e https_proxy=http://172.22.200.10:3128 \
-e JAVA_OPTS="-Dhttp.proxyHost=172.22.200.10 -Dhttp.proxyPort=3128 -Dhttps.proxyHost=172.22.200.10 -Dhttps.proxyPort=3128" \
-p 36301:36301 \
-v /srv/odisseu/files/:/download-files/ \
-v /srv/odisseu/gdal/:/data/ \
-v /etc/localtime:/etc/localtime:ro \
-d sisgeodef/odisseu:1.0	

cp ./parametros.xml /srv/odisseu/files/
cp ./files/* /srv/odisseu/files/
cp ./ogr.sh /srv/odisseu/files/
chmod 0777 /srv/odisseu/files/ogr.sh


docker network connect sisgeodef odisseu
