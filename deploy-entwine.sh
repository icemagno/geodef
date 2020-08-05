#! /bin/sh

mkdir /srv/entwine/

cd entwine
svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/entwine:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/entwine:1.0

docker build --tag=sisgeodef/entwine:1.0 --rm=true .

docker run --name entwine --hostname=entwine  \
-v /etc/localtime:/etc/localtime:ro \
-v /srv/entwine/:/home/ \
-p 36300:3000 \
-it sisgeodef/entwine:1.0

docker network connect sisgeodef entwine
docker network connect apolo entwine
