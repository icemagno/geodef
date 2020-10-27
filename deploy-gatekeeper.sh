#! /bin/sh

cd gatekeeper/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/gatekeeper:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/gatekeeper:1.0
docker build --tag=sisgeodef/gatekeeper:1.0 --rm=true .

docker run --name gatekeeper --hostname=gatekeeper \
--restart=always \
-v /etc/localtime:/etc/localtime:ro \
-p 80:80 \
-d sisgeodef/gatekeeper:1.0

docker network connect sisgeodef gatekeeper
docker network connect apolo gatekeeper

#--network-alias=sisgeodef.defesa.mil.br \