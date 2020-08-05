#! /bin/sh

cd mare/
mkdir /srv/mares/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/mare:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/mare:1.0

docker build --tag=sisgeodef/mare:1.0 --rm=true .

docker run --name mare --hostname=mare \
	-v /etc/localtime:/etc/localtime:ro \
	-v /srv/mare/previsoes:/opt/previsoes \
	-v /srv/mare/constantes:/opt/constantes \
	-v /etc/localtime:/etc/localtime:ro \
	-e LIBRARY_PATH=/usr/lib/x86_64-linux-gnu \
	-p 36008:36008 \
	-d sisgeodef/mare:1.0	

docker network connect apolo mare
docker network connect sisgeodef mare
