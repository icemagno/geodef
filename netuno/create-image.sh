#! /bin/sh


mkdir /srv/netuno/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/netuno:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/netuno:1.0
docker build --tag=sisgeodef/netuno:1.0 --rm=true .

docker run --name netuno --network sisgeodef --hostname=netuno \
--restart=always \
-p 36218:36218 \
-d sisgeodef/netuno:1.0
