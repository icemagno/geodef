#! /bin/sh

docker ps -a | awk '{ print $1,$2 }' | grep magnoabreu/grass | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi magnoabreu/grass
docker build --tag=magnoabreu/grass .


