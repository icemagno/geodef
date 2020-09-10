#! /bin/sh

cd terriamap/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/terriamap:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/terriamap:1.0
docker build --tag=sisgeodef/terriamap:1.0 --rm=true .

docker run --name terriamap --network apolo --hostname=terriamap \
-v /etc/localtime:/etc/localtime:ro \
-p 36301:3001 \
-d sisgeodef/terriamap:1.0


docker network connect sisgeodef terriamap