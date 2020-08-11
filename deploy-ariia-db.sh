#! /bin/sh

cd ariia-db
svn update

mkdir /srv/ariia-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/ariia-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/ariia-db:1.0
docker build --tag=sisgeodef/ariia-db:1.0 --rm=true .

docker run --name ariia-db --network apolo --hostname=ariia-db \
-e POSTGRES_PASSWORD=admin \
-e POSTGRES_DB=ariia \
-v /srv/ariia-db/:/var/lib/postgresql/data/ \
-v /etc/localtime:/etc/localtime:ro \
-d sisgeodef/ariia-db:1.0

docker network connect sisgeodef ariia-db