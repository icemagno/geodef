#! /bin/sh
svn update

mkdir /srv/pgadmin/
cd pgadmin

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/pgadmin | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/pgadmin
docker build --tag=sisgeodef/pgadmin --rm=true .


docker run --name pgadmin --hostname=pgadmin \
-e PGADMIN_DEFAULT_EMAIL=sisgeodef@sisgeodef \
-e PGADMIN_DEFAULT_PASSWORD=sisgeodef \
-v /etc/localtime:/etc/localtime:ro \
-p 36321:80 \
-v /srv/pgadmin/:/var/lib/pgadmin \
-d sisgeodef/pgadmin	

docker network connect apolo pgadmin
docker network connect sisgeodef pgadmin