#! /bin/sh

svn update
cd iscy/
mkdir /srv/iscy/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/iscy | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/iscy
docker build --tag=sisgeodef/iscy --rm=true .

docker run --name iscy --hostname=iscy \
-v /srv/iscy/:/usr/local/apache2/htdocs \
-v /etc/localtime:/etc/localtime:ro \
-d sisgeodef/iscy

docker network connect sisgeodef iscy
docker network connect apolo iscy

cp -r ../edgv-defesa/documentacao/catalogo/* /srv/iscy/