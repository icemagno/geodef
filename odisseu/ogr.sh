#! /bin/sh

ogr2ogr -append -update -lco SCHEMA=temp -f "PostgreSQL" PG:"host='odisseu-db' user='postgres' dbname='odisseu' password='admin' " $1 -nlt GEOMETRY -lco precision=NO


