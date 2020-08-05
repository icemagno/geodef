#! /bin/sh

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/volcano:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}

docker run --name zipkin --hostname=zipkin \
-v /etc/localtime:/etc/localtime:ro \
-p 36390:9411 \
-d openzipkin/zipkin	

docker network connect sisgeodef zipkin
docker network connect apolo zipkin
