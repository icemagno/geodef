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
-e HTTP_PROXY="http://07912470743:da030801@proxy-1dn.mb:6060/" \
-e HTTPS_PROXY="http://07912470743:da030801@proxy-1dn.mb:6060/" \
-d sisgeodef/mapproxy mapproxy http

docker network connect apolo mapproxy
docker network connect sisgeodef mapproxy


# mapproxy-seed -f mapproxy.yaml -c 10 seed.yaml

#-e HTTP_PROXY="172.22.200.10:3128" \
#-e HTTPS_PROXY="172.22.200.10:3128" \
