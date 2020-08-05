#! /bin/sh

cd lucene/
svn update
mvn clean package

mkdir /srv/lucene/files
mkdir /srv/lucene/simple-jndi
mkdir /simple-jndi


docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/lucene:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/lucene:1.0
docker build --tag=sisgeodef/lucene:1.0 --rm=true .

docker run --name lucene --hostname=lucene \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-p 36501:36501 \
-v /srv/lucene/files/:/srv/lucene/files/ \
-v /srv/lucene/simple-jndi/:/simple-jndi/ \
-v /etc/localtime:/etc/localtime:ro \
-d sisgeodef/lucene:1.0	

docker network connect sisgeodef lucene
docker network connect apolo lucene

cp ./files/* /srv/lucene/files/
cp ./simple-jndi/* /srv/lucene/simple-jndi/
cp -r. /simple-jndi/ /

