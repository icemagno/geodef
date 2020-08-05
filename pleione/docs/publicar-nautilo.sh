#! /bin/bash

export http_proxy=""
export https_proxy=""

rm layergroup.xml

echo "<layerGroup><name>chm</name><workspace><name>nautilo</name></workspace><layers>" > layergroup.xml

INPUT=nautilo-tables.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read tipo quantidade
do
	tablename="${tipo}"
	echo "$tablename"
	psql "host='lucene-db' dbname='lucene' user='postgres' password='admin'"  -c "select create_table_nautilo('$tablename');"
	
	wget -O x.txt "http://ortelius:36303/v1/pleione/publicar?workspace=nautilo&datastore=nautilo&layername=$tablename"
	
	echo "<layer>nautilo:$tablename</layer>" >> layergroup.xml
	
done < $INPUT
IFS=$OLDIFS


rm -rf x.txt

echo "</layers></layerGroup>" >> layergroup.xml

echo "Criando grupo de camadas..."

curl -v -u admin:geoserver -XPOST -d @layergroup.xml -H "Content-type: text/xml" http://pleione:8080/geoserver/rest/layergroups
