#! /bin/sh

cd nautilo-db
svn update

mkdir /srv/nautilo-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/nautilo-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/nautilo-db:1.0
docker build --tag=sisgeodef/nautilo-db:1.0 --rm=true .

docker run --name nautilo-db --hostname=nautilo-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=nautilo \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/nautilo-db/:/var/lib/postgresql/ \
-v /etc/localtime:/etc/localtime:ro \
-p 36310:5432 \
-d sisgeodef/nautilo-db:1.0


docker network connect sisgeodef nautilo-db
docker network connect apolo nautilo-db


cp ./*.sql /srv/nautilo-db/

#echo "Aguardando o servidor..."
#sleep 10
# docker exec nautilo-db psql "host='localhost' dbname='nautilo' user='postgres' password='admin'"  -a -f /var/lib/postgresql/postcreate.sql
