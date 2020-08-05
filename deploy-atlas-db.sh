#! /bin/sh

cd atlas-db
svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/atlas-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/atlas-db:1.0
docker build --tag=sisgeodef/atlas-db:1.0 --rm=true .

docker run --name atlas-db --hostname=atlas-db \
-e POSTGRES_PASSWORD=admin \
-e POSTGRES_DB=guardiao \
-v /srv/atlas-db/:/var/lib/postgresql/data/ \
-v /etc/localtime:/etc/localtime:ro \
-p 36210:5432 \
-d sisgeodef/atlas-db:1.0

sleep 5

#docker exec -it atlas-db pg_restore -U postgres -d atlas /opt/atlas-db/guardiao.backup

docker network connect sisgeodef atlas-db
docker network connect apolo atlas-db