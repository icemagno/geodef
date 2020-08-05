#! /bin/sh

cd vesseltracker/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/vesseltracker:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/vesseltracker:1.0

docker build --tag=sisgeodef/vesseltracker:1.0 --rm=true .

docker run --name vesseltracker --hostname=vesseltracker \
	-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
	-e CONFIG_PROFILES=default \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36006:36006 \
	-d sisgeodef/vesseltracker:1.0	

docker network connect sisgeodef vesseltracker
docker network connect apolo vesseltracker

