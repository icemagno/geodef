#! /bin/sh

cd gebco/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/gebco:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/gebco:1.0

docker build --tag=sisgeodef/gebco:1.0 --rm=true .

docker run --name gebco --hostname=gebco \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36011:36011 \
	-d sisgeodef/gebco:1.0	

docker network connect sisgeodef gebco
docker network connect apolo gebco

