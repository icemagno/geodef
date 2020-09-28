#! /bin/sh

cd gebco-db
svn update

mkdir /srv/gebco-db/

docker rmi sisgeodef/gebco-db:1.0
docker build --tag=sisgeodef/gebco-db:1.0 --rm=true .

docker run --name gebco-db --hostname=gebco-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=gebco \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-v /etc/localtime:/etc/localtime:ro \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/gebco-db/:/var/lib/postgresql/ \
-d sisgeodef/gebco-db:1.0

docker network connect apolo gebco-db
docker network connect sisgeodef gebco-db

sleep 10

docker exec gebco-db psql "host='localhost' dbname='gebco' user='postgres' password='admin'"  -a -f /data/table.sql
