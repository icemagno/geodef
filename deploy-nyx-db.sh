#! /bin/sh

cd nyx-db
svn update

mkdir /srv/nyx-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/nyx-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/nyx-db:1.0
docker build --tag=sisgeodef/nyx-db:1.0 --rm=true .

docker run --name nyx-db --hostname=nyx-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=nyx \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-v /etc/localtime:/etc/localtime:ro \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/nyx-db/:/var/lib/postgresql/ \
-d sisgeodef/nyx-db:1.0

docker network connect sisgeodef nyx-db
docker network connect apolo nyx-db

