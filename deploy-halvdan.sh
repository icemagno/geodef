#! /bin/sh

cd halvdan/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/halvdan:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/halvdan:1.0

docker build --tag=sisgeodef/halvdan:1.0 --rm=true .

docker run --name halvdan --hostname=halvdan \
	--restart=always \
	-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
	-e CONFIG_PROFILES=default \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36853:36853 \
	-d sisgeodef/halvdan:1.0	

docker network connect sisgeodef halvdan
docker network connect apolo halvdan

