#! /bin/sh

cd ortelius-db
svn update

mkdir /srv/ortelius-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/ortelius-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/ortelius-db:1.0

docker build --tag=sisgeodef/ortelius-db:1.0 --rm=true .

docker run --name ortelius-db --hostname=ortelius-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=admin \
-e POSTGRES_DB=ortelius \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-v /etc/localtime:/etc/localtime:ro \
-v /srv/ortelius-db/:/var/lib/postgresql/data/ \
-p 36304:5432 \
-d sisgeodef/ortelius-db:1.0

echo "Aguardando a imagem... (5 segundos)"
sleep 5

docker exec ortelius-db update-postgis.sh

docker network connect sisgeodef ortelius-db
docker network connect apolo ortelius-db