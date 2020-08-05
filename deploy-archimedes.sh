#! /bin/sh

cd archimedes/
svn update
mvn clean package

mkdir /srv/archimedes/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/archimedes:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/archimedes:1.0
docker build --tag=sisgeodef/archimedes:1.0 --rm=true .

cp ./configs/* /srv/archimedes/

docker run --name archimedes --hostname=archimedes \
-v /srv/archimedes/:/archimedes \
-e LOCAL_REPO_PATH=/arquimedes \
-v /etc/localtime:/etc/localtime:ro \
-e GITLAB_CONFIG_REPO=http://gitlab/apolo/config-server.git \
-p 36206:36206 \
-d sisgeodef/archimedes:1.0

docker network connect sisgeodef archimedes
docker network connect apolo archimedes

# CONFIG NO GITHUB
# -e GITLAB_CONFIG_REPO=http://gitlab/apolo/config-server.git \

# CONFIG NO FILESYSTEM
# -e GITLAB_CONFIG_REPO=file://archimedes/ \