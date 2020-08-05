#! /bin/sh

svn update
mkdir /srv/prometheus/
cd prometheus

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/prometheus | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/prometheus

docker build --tag=sisgeodef/prometheus --rm=true .

cp ./prometheus.yml /srv/prometheus/

docker run --name prometheus --hostname=prometheus \
-v /srv/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
-v /etc/localtime:/etc/localtime:ro \
-p 36335:9090 \
-d sisgeodef/prometheus 

docker network connect sisgeodef prometheus
docker network connect apolo prometheus
