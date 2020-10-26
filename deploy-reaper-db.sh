#! /bin/sh

cd reaper-db
svn update

mkdir /srv/reaper-db/

docker rmi sisgeodef/reaper-db:1.0
docker build --tag=sisgeodef/reaper-db:1.0 --rm=true .

docker run --name reaper-db --hostname=reaper-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=reaper \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-v /etc/localtime:/etc/localtime:ro \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/reaper-db/:/var/lib/postgresql/ \
-d sisgeodef/reaper-db:1.0

docker network connect apolo reaper-db
docker network connect sisgeodef reaper-db

sleep 10

docker exec reaper-db psql "host='localhost' dbname='reaper' user='postgres' password='admin'"  -a -f /data/table.sql
