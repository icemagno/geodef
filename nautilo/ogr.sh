#! /bin/sh
ogr2ogr -overwrite -update -lco SCHEMA=temp -f PostgreSQL  PG:"host='nautilo-db' dbname='nautilo' user='postgres' password='admin' port='36310'" $1 -skipfailures -nlt GEOMETRY;
