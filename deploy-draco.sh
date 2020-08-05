#! /bin/sh

cd draco/
svn update
mvn clean package


docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/draco:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/draco:1.0

docker build --tag=sisgeodef/draco:1.0 --rm=true .

docker run --name draco --hostname=draco \
	-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
	-e CONFIG_PROFILES=default \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36219:36219 \
	-d sisgeodef/draco:1.0	

docker network connect apolo draco
docker network connect sisgeodef draco



