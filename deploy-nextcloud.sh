#! /bin/sh

svn update

mkdir /srv/nextcloud/

docker ps -a | awk '{ print $1,$2 }' | grep nextcloud | awk '{print $1 }' | xargs -I {} docker rm -f {}

docker run --name nextcloud --hostname=nextcloud \
-p 36315:80 \
-e POSTGRES_DB=nextclouddb \
-e POSTGRES_USER=nextcloud \
-e POSTGRES_PASSWORD=admin \
-e POSTGRES_HOST=nextcloud-db \
-e NEXTCLOUD_ADMIN_USER=sisgeodef \
-v /etc/localtime:/etc/localtime:ro \
-e NEXTCLOUD_ADMIN_PASSWORD=sisgeodef \
-v /srv/nextcloud/:/var/www/html \
-d nextcloud

docker network connect sisgeodef nextcloud
docker network connect apolo nextcloud

