#! /bin/sh

cd icaro-db
svn update

mkdir /srv/icaro-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/icaro-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/icaro-db:1.0
docker build --tag=sisgeodef/icaro-db:1.0 --rm=true .

docker run --name icaro-db --hostname=icaro-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=icaro \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/icaro-db/:/var/lib/postgresql/ \
-v /etc/localtime:/etc/localtime:ro \
-d sisgeodef/icaro-db:1.0

docker network connect apolo icaro-db
docker network connect sisgeodef icaro-db

cp ./*.sql /srv/icaro-db/

#echo "Aguardando o servidor..."
#sleep 10

#docker exec icaro-db psql "host='localhost' dbname='icaro' user='postgres' password='admin'"  -a -f /var/lib/postgresql/postcreate.sql