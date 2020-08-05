#! /bin/sh

cd delphos/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/delphos:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/delphos:1.0
docker build --tag=sisgeodef/delphos:1.0 --rm=true .

docker run --name delphos --hostname=delphos \
-e CONFIG_PROFILES=defult \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-v /etc/localtime:/etc/localtime:ro \
-p 36204:36204 \
-d sisgeodef/delphos:1.0

docker network connect sisgeodef delphos
docker network connect apolo delphos

