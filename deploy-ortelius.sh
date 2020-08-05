#! /bin/sh

cd ortelius/
svn update
mvn clean package

mkdir /srv/ortelius/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/ortelius:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/ortelius:1.0

docker build --tag=sisgeodef/ortelius:1.0 --rm=true .

docker run --name ortelius --hostname=ortelius \
	-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
	-e CONFIG_PROFILES=default \
	-v /srv/ortelius/:/home/ \
	-v /srv/calisto/sharedfolder/:/sharedfolder/ \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36303:36303 \
	-d sisgeodef/ortelius:1.0	

docker network connect sisgeodef ortelius
docker network connect apolo ortelius

cp ./pleione.sh /srv/ortelius/
chmod 0777 /srv/ortelius/pleione.sh

