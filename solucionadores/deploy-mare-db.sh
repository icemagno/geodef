#! /bin/sh

cd mare-db
svn update

mkdir /srv/mare-db/

docker rmi sisgeodef/mare-db:1.0
docker build --tag=sisgeodef/mare-db:1.0 --rm=true .

docker run --name mare-db --hostname=mare-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=mare \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-v /etc/localtime:/etc/localtime:ro \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/mare-db/:/var/lib/postgresql/ \
-d sisgeodef/mare-db:1.0

docker network connect apolo mare-db
docker network connect sisgeodef mare-db

sleep 10

docker exec mare-db psql "host='localhost' dbname='mare' user='postgres' password='admin'"  -a -f /data/mare_backup.sql
