#! /bin/sh

cd olimpo/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/olimpo:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/olimpo:1.0

docker build --tag=sisgeodef/olimpo:1.0 --rm=true .

docker run --name olimpo --hostname=olimpo \
	-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
	-e CONFIG_PROFILES=default \
	-v /srv/olimpo/:/data \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36503:36503 \
	-d sisgeodef/olimpo:1.0	

docker network connect sisgeodef olimpo
docker network connect apolo olimpo

