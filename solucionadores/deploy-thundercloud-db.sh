#! /bin/sh

cd thundercloud-db
svn update

mkdir /srv/thundercloud-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/thundercloud-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/thundercloud-db:1.0
docker build --tag=sisgeodef/thundercloud-db:1.0 --rm=true .

docker run --name thundercloud-db --hostname=thundercloud-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=thundercloud \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-v /etc/localtime:/etc/localtime:ro \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/thundercloud-db/:/var/lib/postgresql/ \
-d sisgeodef/thundercloud-db:1.0

docker network connect sisgeodef thundercloud-db
docker network connect apolo thundercloud-db

