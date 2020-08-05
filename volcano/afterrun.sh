#! /bin/sh


# GDAL
apt-get -y install build-essential python-all-dev
wget http://download.osgeo.org/gdal/3.0.0/gdal-3.0.0.tar.gz
tar xvfz gdal-1.9.0.tar.gz
cd gdal-1.9.0
./configure --with-python
make
sudo make install


# OSM2PGSQL
cd /home/osm2pgsql/
mkdir build 
cd build 
cmake .. 
make install 

ldconfig

# phyghtmap
cd /home/
wget http://katze.tfiu.de/projects/phyghtmap/phyghtmap_2.21-1_all.deb
dpkg -i phyghtmap_2.21-1_all.deb

psql "host='volcano-db' dbname='volcano' user='postgres' password='admin'" -c "create database contour;"
psql "host='volcano-db' dbname='contour' user='postgres' password='admin'" -c "create extension hstore; create extension postgis;"


echo "Para criar curvas de nivel no banco de dados Volcano-DB use o script import-contour.sh"
echo "Para criar Hillshades no Geoserver Pleione use o script import-hgt.sh"
echo "ATENCAO: Estes scripts podem demorar dias e consumir muito espaco em disco!"
 