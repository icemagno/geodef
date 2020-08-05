#! /bin/sh

cd phobos/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/phobos:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/phobos:1.0

docker build --tag=sisgeodef/phobos:1.0 --rm=true .

docker run --name phobos --hostname=phobos \
	-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
	-e CONFIG_PROFILES=default \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36005:36005 \
	-d sisgeodef/phobos:1.0	

docker network connect sisgeodef phobos
docker network connect apolo phobos

