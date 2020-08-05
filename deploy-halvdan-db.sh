#! /bin/sh

cd halvdan-db
svn update

mkdir /srv/halvdan-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/halvdan-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/halvdan-db:1.0
docker build --tag=sisgeodef/halvdan-db:1.0 --rm=true .

docker run --name halvdan-db --hostname=halvdan-db \
-e POSTGRES_PASSWORD=admin \
-e POSTGRES_DB=halvdan \
-v /srv/halvdan-db/:/var/lib/postgresql/data/ \
-v /etc/localtime:/etc/localtime:ro \
-p 36852:5432 \
-d sisgeodef/halvdan-db:1.0

docker network connect sisgeodef halvdan-db
docker network connect apolo halvdan-db

cp ./*.sql /srv/halvdan-db/

#echo "Aguardando o servidor... (15 seg)"
#sleep 15

#docker exec halvdan-db psql "host='localhost' dbname='halvdan' user='postgres' password='admin'"  -a -f /var/lib/postgresql/postcreate.sql