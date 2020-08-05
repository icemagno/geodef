#! /bin/sh

cd daedalus/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/daedalus:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/daedalus:1.0

docker build --tag=sisgeodef/daedalus:1.0 --rm=true .

docker run --name daedalus --hostname=daedalus \
	-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
	-e CONFIG_PROFILES=default \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36002:36002 \
	-d sisgeodef/daedalus:1.0	

docker network connect sisgeodef daedalus
docker network connect apolo daedalus

