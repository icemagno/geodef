#! /bin/sh

cd volcano/
svn update
mvn clean package

mkdir /srv/volcano/home
mkdir /srv/volcano/data

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/volcano:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/volcano:1.0
docker build --tag=sisgeodef/volcano:1.0 --rm=true .

docker run --name volcano --network apolo --hostname=volcano \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-v /srv/volcano/home/:/home/ \
-v /srv/volcano/data/:/var/lib/postgresql/data \
-v /etc/localtime:/etc/localtime:ro \
-v /srv/srtm/:/home/srtm/ \
-p 36351:36351 \
-d sisgeodef/volcano:1.0	

docker network connect sisgeodef volcano

echo "Aguardando a imagem... (5 segundos)"
echo "Lembre-se de verificar se existem arquivos HGT na pasta /srv/srtm/"
sleep 5


cp ./srtm.style /srv/volcano/home
cp ./color-relief.txt /srv/volcano/home/
cp ./color-slope.txt /srv/volcano/home/
cp ./*.sh /srv/volcano/home/
chmod 0777 /srv/volcano/home/*.sh

#rm -rf /srv/volcano/osm2pgsql/
#tar -xvf ./osm2pgsql-0.96.0.tar.gz -C /srv/volcano/
#mv /srv/volcano/osm2pgsql-0.96.0/ /srv/volcano/osm2pgsql/

docker exec volcano /home/afterrun.sh

