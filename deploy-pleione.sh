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
-p 36212:8080 \
-e STABLE_EXTENSIONS=netcdf-plugin,netcdf-out-plugin,querylayer-plugin,sldservice-plugin,grib-plugin,csw-plugin,css-plugin \
-e COMMUNITY_EXTENSIONS=gpx-plugin,mbtiles-plugin,netcdf-ghrsst-plugin,mbtiles-store-plugin,ncwms-plugin,colormap-plugin \
-e GEOSERVER_ADMIN_PASSWORD=sisgeodef \
-e http_proxy=http://172.22.200.10:3128 \
-e https_proxy=http://172.22.200.10:3128 \
-e no_proxy="172.22.1.44,172.22.1.47" \
-e INITIAL_MEMORY=8G \
-e MAXIMUM_MEMORY=16G \
-e REQUEST_TIMEOUT=60 \
-e PARARELL_REQUEST=500 \
-e SINGLE_USER=12 \
-e GWC_REQUEST=64 \
-e JAVA_OPTS="-Dhttp.proxyHost=172.22.200.10 -Dhttp.proxyPort=3128 -Dhttps.proxyHost=172.22.200.10 -Dhttps.proxyPort=3128 -Dhttp.nonProxyHosts=\"localhost|172.22.1.44|172.22.1.47\" -Dhttps.nonProxyHosts=\"localhost|172.22.1.44|172.22.1.47\"" \
-v /etc/localtime:/etc/localtime:ro \
-v /srv/pleione/:/opt/geoserver/data_dir/ \
-d sisgeodef/pleione:1.0

docker network connect sisgeodef pleione
docker network connect apolo pleione

#echo "Aguardando a imagem... (5 segundos)"
#sleep 5

#cp ./afterrun.sh /srv/pleione/
#chmod 0777 /srv/pleione/afterrun.sh

#cp -r ./estilos/ /srv/pleione/
#chmod 0777 /srv/pleione/estilos/*.sh

#docker exec pleione /opt/geoserver/data_dir/afterrun.sh

