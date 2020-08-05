#! /bin/sh
ogr2ogr -append -update -f PostgreSQL  PG:"host='icaro-db' dbname='icaro' user='postgres' password='admin'" $1 -skipfailures -nlt GEOMETRY -lco SCHEMA=aixm;
