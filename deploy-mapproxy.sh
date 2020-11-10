#! /bin/sh

mkdir /srv/mapproxy/
cd mapproxy
svn update

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/mapproxy | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/mapproxy
docker build --tag=sisgeodef/mapproxy .

yes | cp ./*.yaml /srv/mapproxy/
#chmod -R 0777 /srv/mapproxy

docker run -it --name mapproxy --hostname=mapproxy \
-v /srv/mapproxy:/mapproxy/ \
-p 36890:8080 \
-e http_proxy="http://172.22.200.10:3128" \
-e https_proxy="http://172.22.200.10:3128" \
-d sisgeodef/mapproxy mapproxy http

docker network connect apolo mapproxy
docker network connect sisgeodef mapproxy


# mapproxy-seed -f mapproxy.yaml -c 10 seed.yaml


