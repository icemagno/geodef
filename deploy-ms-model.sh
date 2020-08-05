#! /bin/sh

cd modelo-microsservico/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep magnoabreu/ms-model:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi magnoabreu/ms-model:1.0
docker build --tag=magnoabreu/ms-model:1.0 --rm=true .

docker run --name ms-model --network apolo --hostname=ms-model \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-v /etc/localtime:/etc/localtime:ro \
-p 8070:8080 \
-d magnoabreu/ms-model:1.0	


docker network connect sisgeodef ms-model