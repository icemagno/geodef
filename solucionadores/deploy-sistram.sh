#! /bin/sh

cd sistram/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/sistram:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/sistram:1.0

docker build --tag=sisgeodef/sistram:1.0 --rm=true .

docker run --name sistram --hostname=sistram \
	-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
	-e CONFIG_PROFILES=default \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36001:36001 \
	-d sisgeodef/sistram:1.0	

docker network connect sisgeodef sistram
docker network connect apolo sistram

