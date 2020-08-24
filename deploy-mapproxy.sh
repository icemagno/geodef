#! /bin/sh

mkdir /srv/mapproxy/
cd mapproxy
svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/mapproxy | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/mapproxy
docker build --tag=sisgeodef/mapproxy .

cp ./mapproxy.yaml /srv/mapproxy/
cp ./seed.yaml /srv/mapproxy/
chmod -R 0777 /srv/mapproxy

docker run -it --name mapproxy --hostname=mapproxy \
-v /srv/mapproxy:/mapproxy/ \
-d sisgeodef/mapproxy mapproxy http

docker network connect apolo mapproxy
docker network connect sisgeodef mapproxy


# mapproxy-seed -f mapproxy.yaml -c 10 seed.yaml

