#! /bin/sh


tar -xvf /home/osm2pgsql-0.96.0.tar.gz -C /home/
mv /home/osm2pgsql-0.96.0/ /home/osm2pgsql/

cd /home/osm2pgsql/
mkdir build 
cd build 
cmake ..
make install 
ldconfig

export PGPASSWORD=admin 
export PGPASS=admin

/usr/local/bin/osm2pgsql --number-processes 8 \
--flat-nodes /home/osm_flat_nodes.db  \
--latlong \
--verbose \
--create \
--slim \
--hstore \
--cache 5000 \
--database efestus \
--username postgres \
--host 127.0.0.1 \
--style /home/default.style \
/osmfile/brazil-latest.osm.pbf

psql "host='localhost' dbname='efestus' user='postgres' password='admin'"  -a -f /home/generate_buildings.sql
