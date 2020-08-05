#! /bin/sh


svn update

cd grafana

mkdir /srv/grafana/
chmod -R a+rwX /srv/grafana/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/grafana | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/grafana

docker build --tag=sisgeodef/grafana --rm=true .

docker run --name grafana --network apolo --hostname=grafana \
-e GF_SECURITY_ADMIN_PASSWORD=sisgeodef \
-v /srv/grafana/:/home/ \
-v /etc/localtime:/etc/localtime:ro \
-p 36336:3000 \
-d sisgeodef/grafana

docker network connect sisgeodef grafana

