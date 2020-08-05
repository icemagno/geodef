#! /bin/sh

cd efestus
svn update

mkdir /srv/efestus-db/
mkdir /srv/efestus/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/efestus:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/efestus:1.0
docker build --tag=sisgeodef/efestus:1.0 --rm=true .

docker run --name efestus --hostname=efestus \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASS=admin \
-e POSTGRES_DBNAME=efestus \
-e ALLOW_IP_RANGE='0.0.0.0/0' \
-e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology,postgis_sfcgal,pointcloud,pointcloud_postgis \
-v /srv/efestus-db/:/var/lib/postgresql/ \
-v /srv/efestus/:/home/ \
-v /srv/osmfile/:/osmfile/ \
-v /etc/localtime:/etc/localtime:ro \
-p 36322:5432 \
-d sisgeodef/efestus:1.0

docker network connect sisgeodef efestus
docker network connect apolo efestus

cp ./build.sh /srv/efestus/
cp ./default.style /srv/efestus/
cp ./generate_buildings.sql /srv/efestus/
cp ./osm2pgsql-0.96.0.tar.gz /srv/efestus/

chmod 0777 /srv/efestus/build.sh

echo "Aguardando o servidor... 20 segundos"

sleep 20

# docker exec efestus /home/build.sh


