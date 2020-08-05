#!/bin/bash

echo "Baixando América do Sul (~1GB) ..."
wget http://download.geofabrik.de/south-america-latest.osm.pbf -O pbffiles/south-america-latest.osm.pbf

#echo "Baixando América Central (~280MB) ..."
wget http://download.geofabrik.de/central-america-latest.osm.pbf -O pbffiles/central-america-latest.osm.pbf

#echo "Baixando América do Norte... (~7GB)"
wget http://download.geofabrik.de/north-america-latest.osm.pbf -O pbffiles/north-america-latest.osm.pbf

#echo "Baixando Antártica (~30MB) ..."
wget http://download.geofabrik.de/antarctica-latest.osm.pbf -O pbffiles/antarctica-latest.osm.pbf

#echo "Baixando Africa (~2GB) ..."
wget http://download.geofabrik.de/africa-latest.osm.pbf -O pbffiles/africa-latest.osm.pbf

#echo "Baixando Oceania (~507MB) ..."
wget http://download.geofabrik.de/australia-oceania-latest.osm.pbf -O pbffiles/australia-oceania-latest.osm.pbf

#echo "Baixando Europa (~17GB) ..."
wget http://download.geofabrik.de/europe-latest.osm.pbf -O pbffiles/europe-latest.osm.pbf

#echo "Baixando Asia (~? ) ..."
wget http://download.geofabrik.de/asia-latest.osm.pbf  -O pbffiles/asia-latest.osm.pbf

rm -f mundo.osm.pbf
osmium merge --verbose *.osm.pbf -o mundo.osm.pbf --overwrite




