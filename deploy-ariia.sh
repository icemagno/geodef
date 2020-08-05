#! /bin/sh

cd ariia/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/ariia:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/ariia:1.0
docker build --tag=sisgeodef/ariia:1.0 --rm=true .

docker run --name ariia --network apolo --hostname=ariia \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-v /etc/localtime:/etc/localtime:ro \
-p 36340:36340 \
-d sisgeodef/ariia:1.0	


docker network connect sisgeodef ariia