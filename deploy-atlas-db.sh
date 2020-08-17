#! /bin/sh

cd atlas-db
svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/atlas-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/atlas-db:1.0
docker build --tag=sisgeodef/atlas-db:1.0 --rm=true .

docker run --name atlas-db --hostname=atlas-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=guardiao \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-v /etc/localtime:/etc/localtime:ro \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/atlas-db/:/var/lib/postgresql/ \
-d sisgeodef/atlas-db:1.0

sleep 10

docker exec -it atlas-db pg_restore -U postgres -d guardiao /opt/atlas-db/guardiao.backup

docker network connect sisgeodef atlas-db
docker network connect apolo atlas-db