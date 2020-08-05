#! /bin/sh

cd pleione
svn update

#mkdir /srv/pleione/

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/pleione:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/pleione:1.0

docker build \
--tag=sisgeodef/pleione:1.0 \
--rm=true .

docker run --name pleione --hostname=pleione \
-e USERNAME=postgres \
-e PASS=admin \
-e GEOSERVER_ADMIN_PASSWORD=sisgeodef \
-v /etc/localtime:/etc/localtime:ro \
-v /srv/pleione/:/opt/geoserver/data_dir/ \
-p 36212:8080 \
-d sisgeodef/pleione:1.0

docker network connect sisgeodef pleione
docker network connect apolo pleione

echo "Aguardando a imagem... (5 segundos)"
sleep 5

#cp ./afterrun.sh /srv/pleione/
#chmod 0777 /srv/pleione/afterrun.sh

#cp -r ./estilos/ /srv/pleione/
#chmod 0777 /srv/pleione/estilos/*.sh

#docker exec pleione /opt/geoserver/data_dir/afterrun.sh

