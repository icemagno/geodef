#! /bin/sh

osm2pgsql  --number-processes 8 --latlong --verbose --create --cache 20000 --style ./srtm.style --database contour --username postgres -W --host 127.0.0.1 pbf/consolidado-final.osm.pbf
