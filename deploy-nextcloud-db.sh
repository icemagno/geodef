#! /bin/sh

cd nextcloud-db
svn update

mkdir /srv/nextcloud-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/nextcloud-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/nextcloud-db:1.0

docker build --tag=sisgeodef/nextcloud-db:1.0 --rm=true .

docker run --name nextcloud-db --network apolo --hostname=nextcloud-db \
-e POSTGRES_PASSWORD=admin \
-e POSTGRES_USER=nextcloud \
-v /srv/nextcloud-db/:/var/lib/postgresql/data/ \
-v /etc/localtime:/etc/localtime:ro \
-p 36316:5432 \
-d sisgeodef/nextcloud-db:1.0

docker network connect sisgeodef nextcloud-db