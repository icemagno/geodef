#! /bin/sh

cd interope/
svn update
mvn clean package

mkdir /srv/interope/

docker ps -a | awk '{ print $1,$2 }' | grep apolo/interope:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi apolo/interope:1.0

docker build --tag=apolo/interope:1.0 --rm=true .

docker run --name interope --hostname=interope \
	-v /etc/localtime:/etc/localtime:ro \
	-v /srv/interope/:/usr/local/tomcat \
	-p 36904:8080 \
	-d apolo/interope:1.0	

