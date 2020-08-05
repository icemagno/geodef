#! /bin/sh

# https://github.com/Overv/openstreetmap-tile-server

mkdir /srv/osmtiles/

cd openstreetmap
svn update

cp ./brazil.poly /srv/osmfile/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/openstreetmap:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/openstreetmap:1.0

docker build --tag=sisgeodef/openstreetmap:1.0 --rm=true .

docker volume create openstreetmap-data

chmod -R 0777 /srv/osmfile
chmod -R 0777 /srv/osmtiles

# DATABASE BUILD PHASE
# WARNING: DISABLE THIS WHEN JUST RUNNING !!!!

docker run --name openstreetmap-deleteme \
-v /srv/osmfile/brazil-latest.osm.pbf:/data.osm.pbf \
-v /srv/osmfile/brazil.poly:/data.poly \
-v openstreetmap-data:/var/lib/postgresql/10/main \
-v /srv/osmtiles:/var/lib/mod_tile \
--shm-size="500m" \
-e AUTOVACUUM=off \
-e "OSM2PGSQL_EXTRA_ARGS=-C 4096 --flat-nodes /nodes/flat_nodes.bin" \
sisgeodef/openstreetmap:1.0 \
import

# ----------------------------------------------



# SERVER RUN PHASE
# Use the user renderer and the database gis to connect.

docker run --name openstreetmap --hostname=openstreetmap  \
-v /etc/localtime:/etc/localtime:ro \
-v openstreetmap-data:/var/lib/postgresql/10/main \
-v /srv/osmtiles:/var/lib/mod_tile \
-e THREADS=8 \
-e ALLOW_CORS=1 \
-p 36880:80 \
-p 36881:5432 \
-d sisgeodef/openstreetmap:1.0 \
run

# -e UPDATES=enabled \

docker network connect sisgeodef openstreetmap
docker network connect apolo openstreetmap


