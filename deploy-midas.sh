#! /bin/sh

cd midas245/
mkdir /srv/midas/
svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/midas:2.4.5 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/midas:2.4.5
docker build --tag=sisgeodef/midas:2.4.5 --rm=true .

docker run --name midas --hostname=midas \
-p 36203:36203 \
-v /srv/midas/:/usr/local/apache2/htdocs \
-v /etc/localtime:/etc/localtime:ro \
-d sisgeodef/midas:2.4.5

#cp -a ./resources/* /srv/midas/

docker network connect sisgeodef midas
docker network connect apolo midas
