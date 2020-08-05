#! /bin/sh

# /usr/bin/raster2pgsql

cd volcano-db
svn update

mkdir /srv/volcano-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/volcano-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/volcano-db:1.0
docker build --tag=sisgeodef/volcano-db:1.0 --rm=true .

docker run --name volcano-db --hostname=volcano-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=admin \
-e POSTGRES_DB=volcano \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-v /srv/volcano-db/:/var/lib/postgresql/data/ \
-v /etc/localtime:/etc/localtime:ro \
-p 36350:5432 \
-d sisgeodef/volcano-db:1.0

echo "Aguardando a imagem... (5 segundos)"
sleep 5

#docker exec volcano-db update-postgis.sh

docker network connect sisgeodef volcano-db
docker network connect apolo volcano-db