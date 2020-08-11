#! /bin/sh

cd poseidon-db
svn update

mkdir /srv/poseidon-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/poseidon-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/poseidon-db:1.0
docker build --tag=sisgeodef/poseidon-db:1.0 --rm=true .

docker run --name poseidon-db --hostname=poseidon-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=poseidon \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-v /etc/localtime:/etc/localtime:ro \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/poseidon-db/:/var/lib/postgresql/ \
-d sisgeodef/poseidon-db:1.0

docker network connect sisgeodef poseidon-db
docker network connect apolo poseidon-db

sleep 10

# docker exec poseidon-db psql "host='localhost' dbname='poseidon' user='postgres' password='admin'"  -a -f /data/mare_backup.sql
