#! /bin/sh

cd calisto/
mkdir /srv/calisto/
mkdir /srv/calisto/photos/
mkdir /srv/calisto/images/

svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/calisto | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/calisto
docker build --tag=sisgeodef/calisto --rm=true .

docker run --name calisto --hostname=calisto \
-p 36280:36280 \
-v /srv/calisto/:/usr/local/apache2/htdocs \
-v /srv/srtm/:/usr/local/apache2/htdocs/srtm/:ro \
-v /etc/localtime:/etc/localtime:ro \
-d sisgeodef/calisto

cp defesa-novo.png /srv/calisto/images/

docker network connect sisgeodef calisto
docker network connect apolo calisto