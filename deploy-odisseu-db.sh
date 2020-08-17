#! /bin/sh

cd odisseu-db
svn update

mkdir /srv/odisseu-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/odisseu-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/odisseu-db:1.0
docker build --tag=sisgeodef/odisseu-db:1.0 --rm=true .

docker run --name odisseu-db --hostname=odisseu-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=odisseu \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-v /etc/localtime:/etc/localtime:ro \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/odisseu-db/:/var/lib/postgresql/ \
-d sisgeodef/odisseu-db:1.0

docker network connect apolo odisseu-db
docker network connect sisgeodef odisseu-db

cp ./*.sql /srv/odisseu-db/

echo "Aguardando o servidor..."

sleep 10

# docker exec odisseu-db psql "host='localhost' dbname='odisseu' user='postgres' password='admin'"  -a -f /var/lib/postgresql/postcreate.sql
