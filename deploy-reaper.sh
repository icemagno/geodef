#! /bin/sh

cd reaper/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/reaper:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/reaper:1.0

docker build --tag=sisgeodef/reaper:1.0 --rm=true .

docker run --name reaper --hostname=reaper \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36015:36015 \
	-d sisgeodef/reaper:1.0	

docker network connect sisgeodef reaper
docker network connect apolo reaper

