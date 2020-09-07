#! /bin/sh

wget "http://localhost:36003/aisweb/aerodromo/SBRJ" -O thundercloud-aerodromo.json 
wget "http://localhost:36003/inmet/municipio/5300108" -O thundercloud-municipio.json 
wget "http://localhost:36003/metar/retrieve" -O thundercloud-cormeteoro.json 
wget "http://localhost:36003/metar/plain" -O thundercloud-metar.json 