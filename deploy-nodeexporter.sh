#! /bin/sh

docker ps -a | awk '{ print $1,$2 }' | grep node-exporter | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker run --name nodeexporter --hostname=nodeexporter \
--restart=always \
-v /etc/localtime:/etc/localtime:ro \
-d -p 36274:9100 prom/node-exporter

docker network connect sisgeodef nodeexporter
docker network connect apolo nodeexporter
