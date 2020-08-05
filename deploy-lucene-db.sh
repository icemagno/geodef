#! /bin/sh

cd lucene-db
svn update

mkdir /srv/lucene-db/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/lucene-db:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/lucene-db:1.0
docker build --tag=sisgeodef/lucene-db:1.0 --rm=true .

docker run --name lucene-db --network sisgeodef --hostname=lucene-db \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=lucene \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
-v /srv/lucene-db/:/var/lib/postgresql/ \
-v /etc/localtime:/etc/localtime:ro \
-p 36502:5432 \
-d sisgeodef/lucene-db:1.0




