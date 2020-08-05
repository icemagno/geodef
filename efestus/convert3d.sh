#! /bin/sh

export PGPASSWORD=admin 
export PGPASS=admin

psql "host='localhost' dbname='efestus' user='postgres' password='admin'"  -a -f /home/convert3d.sql
