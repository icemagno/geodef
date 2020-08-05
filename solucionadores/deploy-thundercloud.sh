#! /bin/sh

cd thundercloud/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/thundercloud:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/thundercloud:1.0

docker build --tag=sisgeodef/thundercloud:1.0 --rm=true .

docker run --name thundercloud --hostname=thundercloud \
	-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
	-e CONFIG_PROFILES=default \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36003:36003 \
	-d sisgeodef/thundercloud:1.0	

docker network connect sisgeodef thundercloud
docker network connect apolo thundercloud

