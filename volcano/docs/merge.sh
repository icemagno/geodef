#!/bin/bash



for value in {-180..180} 
do
	filename=lon$value
	
	set -- $filename*
	if [ -f "$1" ]; then
		echo "Fusao de arquivos $filename ..."
		osmium merge $filename* --overwrite -o x-$value-merged.osm.pbf
	fi	
	

done

osmium merge *-merged.osm.pbf --overwrite -o final.osm.pbf

osm2pgsql --verbose --create --latlong --slim --style ./srtm.style --database contour --username postgres --host volcano-db final.osm.pbf

echo "Processo encerrado."







