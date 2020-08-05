#! /bin/sh

svn update

docker ps -a | awk '{ print $1,$2 }' | grep cadvisor | awk '{print $1 }' | xargs -I {} docker rm -f {}
#docker rmi cadvisor

docker run --name=cadvisor --hostname=cadvisor \
-v /:/rootfs:ro \
-v /var/run:/var/run:rw \
-v /sys:/sys:ro \
-v /var/lib/docker/:/var/lib/docker:ro \
-v /etc/localtime:/etc/localtime:ro \
-p 36260:8080 \
-d google/cadvisor:latest
  
docker network connect apolo cadvisor  
docker network connect sisgeodef cadvisor  