#! /bin/bash

export http_proxy=""
export https_proxy=""

INPUT=importacao.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read tipo quantidade
do
	tablename="${tipo:4}"
	echo "$tablename"
	psql "host='lucene-db' dbname='lucene' user='postgres' password='admin'"  -c "select create_table_odisseu('$tablename');"
	
	wget -O x.txt "http://ortelius:36303/v1/pleione/publicar?workspace=odisseu&datastore=odisseu&layername=$tablename"
	
done < $INPUT
IFS=$OLDIFS


rm -rf x.txt