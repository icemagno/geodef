#! /bin/sh

cd olimpo
svn update

mkdir -p /srv/olimpo/tilesets/terrain/sisgide/

cp virtual/*.vrt /srv/srtm/

echo "Criando superficies do terreno..."
docker run -v /srv/srtm/:/srtm/ -v /srv/olimpo/:/data tumgis/ctb-quantized-mesh ctb-tile -c 8 -f Mesh -C -N -o /data/tilesets/terrain/sisgide /srtm/prototipo.vrt 
echo "Criando arquivo JSON de descricao..."
docker run -v /srv/srtm/:/srtm/ -v /srv/olimpo/:/data tumgis/ctb-quantized-mesh ctb-tile -c 8 -f Mesh -C -N -l -o /data/tilesets/terrain/sisgide /srtm/prototipo.vrt 
