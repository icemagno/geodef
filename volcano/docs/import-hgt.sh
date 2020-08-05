#! /bin/sh

# ./import-hgt.sh > log.txt 2>&1 &

export PGPASSWORD=admin 
export PGPASS=admin
export http_proxy=""
export https_proxy=""

echo "<layerGroup><name>hillshade</name><workspace><name>volcano</name></workspace><layers>" > layergroup.xml

for hgtfile in /home/srtm/*.hgt; do
	hgtname=`basename $hgtfile .hgt`
	tifname=$hgtname.hill.tif

	# Create TIFF	
	echo "Gerando arquivo GEOTIFF..."
	gdal_translate -tr 0.000170 0.000170 -r cubicspline -of GTiff $hgtfile $hgtname.tmp.tif
	
	# EXTRAI O HILLSHADE DO TIFF
	echo "Criando hillshades..."
	gdaldem hillshade -co TILED=YES -co compress=lzw -s 111120 -z 3 -combined -compute_edges $hgtname.tmp.tif $tifname

	# COMPRIME O TIFF
	echo "Otimizando para Geoserver..."
	gdaladdo -r cubicspline --config COMPRESS_OVERVIEW DEFLATE --config GDAL_TIFF_OVR_BLOCKSIZE 512 $hgtname.hill.tif 2 4 8 16 32

	rm 	$hgtname.tmp.tif
	
	echo "Publicando no Geoserver..."
	curl -u admin:geoserver -v -XPUT -H "Content-type: image/tiff"  \
		--data-binary @$hgtname.hill.tif   \
		http://pleione:8080/geoserver/rest/workspaces/volcano/coveragestores/$hgtname/file.geotiff
		
	echo "Aplicando estilo..."	
	curl -u admin:geoserver -XPUT -H "Content-type: text/xml" \
		-d "<layer><defaultStyle><name>hillshade</name></defaultStyle></layer>" \
		http://pleione:8080/geoserver/rest/layers/volcano:$hgtname
	
	echo "<layer>volcano:$hgtname</layer>" >> layergroup.xml
	
	echo "Concluido $hgtname"
		
done

echo "</layers></layerGroup>" >> layergroup.xml

echo "Criando grupo de camadas..."
curl -v -u admin:geoserver -XPOST -d @layergroup.xml -H "Content-type: text/xml" http://pleione:8080/geoserver/rest/layergroups


echo "Processo encerrado."

