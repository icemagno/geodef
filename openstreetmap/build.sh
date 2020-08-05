#! /bin/sh

mkdir /srv/osmtiles/

chmod -R 0777 /srv/osmfile
chmod -R 0777 /srv/osmtiles

docker volume create openstreetmap-data

docker run --name openstreetmap-deleteme \
-v /srv/osmfile/brazil-latest.osm.pbf:/data.osm.pbf \
-v /srv/osmfile/brazil.poly:/data.poly \
-e ftp_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/" \
-e http_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/" \
-e https_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/" \
-v openstreetmap-data:/var/lib/postgresql/12/main \
-v /srv/osmtiles:/var/lib/mod_tile \
--shm-size="500m" \
-e AUTOVACUUM=off \
-e "OSM2PGSQL_EXTRA_ARGS=-C 4096 --flat-nodes /nodes/flat_nodes.bin" \
overv/openstreetmap-tile-server \
import


