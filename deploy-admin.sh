#! /bin/sh

cd admin/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/admin:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/admin:1.0
docker build --tag=sisgeodef/admin:1.0 --rm=true .

docker run --name admin --hostname=admin \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-v /etc/localtime:/etc/localtime:ro \
-p 36208:36208 \
-d sisgeodef/admin:1.0	

docker network connect sisgeodef admin
docker network connect apolo admin

