#! /bin/sh

cd indra-db
svn update

mkdir /srv/indra-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/indra-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/indra-db:1.0
docker build --tag=sisgeodef/indra-db:1.0 --rm=true .

docker run --name indra-db --network apolo --hostname=indra-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=indra \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/indra-db/:/var/lib/postgresql/ \
-v /etc/localtime:/etc/localtime:ro \
-d sisgeodef/indra-db:1.0

docker network connect sisgeodef indra-db

cp ./*.sql /srv/indra-db/

echo "Aguardando o servidor..."

sleep 10

docker exec indra-db psql "host='localhost' dbname='indra' user='postgres' password='admin'"  -a -f /var/lib/postgresql/postcreate.sql
