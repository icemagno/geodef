#! /bin/sh

docker run --name openstreetmap --hostname=openstreetmap  \
-v /etc/localtime:/etc/localtime:ro \
-v openstreetmap-data:/var/lib/postgresql/12/main \
-v /srv/osmtiles:/var/lib/mod_tile \
-v /srv/osmfile/brazil.poly:/data.poly \
-e THREADS=8 \
-e ALLOW_CORS=1 \
-e UPDATES=enabled \
-p 80:80 \
-p 5432:5432 \
-d overv/openstreetmap-tile-server \
run

