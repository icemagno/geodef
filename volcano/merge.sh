#!/bin/bash


counter=1
for value in {-180..180} 
do
	filename=lon$value
	
	set -- $filename*
	if [ -f "$1" ]; then
		osmium merge $filename* --overwrite -o $counter-merged.osm.pbf
	fi	
	
	((counter++))
done

osmium merge *-merged.osm.pbf --overwrite -o final.osm.pbf

osm2pgsql --verbose --create --latlong --slim --style ./srtm.style --database contour --username postgres --host volcano-db final.osm.pbf


echo "Processo encerrado."







