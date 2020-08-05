#! /bin/sh

cd nyx
svn update

mkdir /srv/nyx/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/nyx:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/nyx:1.0

docker build --tag=sisgeodef/nyx:1.0 --rm=true .

docker run --name nyx --hostname=nyx \
-v /etc/localtime:/etc/localtime:ro \
-v /srv/nyx/:/var/lib/geonetwork_data/ \
-p 36318:8080 \
-e POSTGRES_DB_HOST=nyx-db \
-e DATA_DIR=/var/lib/geonetwork_data \
-e POSTGRES_DB_PORT=5432 \
-e POSTGRES_DB_USERNAME=postgres \
-e POSTGRES_DB_PASSWORD=admin \
-d sisgeodef/nyx:1.0

docker network connect apolo nyx
docker network connect sisgeodef nyx

# cp ./geonetwork.war /srv/nyx/

# -v /srv/nyx/:/usr/local/tomcat/webapps/geonetwork/WEB-INF/data \

# PLUGINS
# /srv/nyx/geonetwork/WEB-INF/data/config/schema_plugins

# schemaplugin-uri-catalog.xml
# /srv/nyx/geonetwork/WEB-INF/data/config/