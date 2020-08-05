#! /bin/sh

cd rabbitmq
svn update

mkdir /srv/rabbitmq/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/rabbitmq:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/rabbitmq:1.0

docker build --tag=sisgeodef/rabbitmq:1.0 --rm=true .

docker run --name rabbitmq --network apolo --hostname=rabbitmq \
-e RABBITMQ_ERLANG_COOKIE='biscoitodecoelho' \
-e RABBITMQ_DEFAULT_USER=sisgeodef \
-e RABBITMQ_DEFAULT_PASS=sisgeodef \
-v /srv/rabbitmq/:/var/lib/rabbitmq \
-v /etc/localtime:/etc/localtime:ro \
-p 36317:15672 \
-d sisgeodef/rabbitmq:1.0

docker network connect sisgeodef rabbitmq
