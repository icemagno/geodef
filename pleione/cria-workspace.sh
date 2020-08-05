#! /bin/bash

export http_proxy=""
export https_proxy=""

echo "<layerGroup><name>dsg</name><workspace><name>odisseu</name></workspace><layers>" > layergroup.xml

INPUT=importacao.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read tipo quantidade
do
	tablename="${tipo:4}"
	echo "$tablename"
	echo "<layer>odisseu:$tablename</layer>" >> layergroup.xml
	
done < $INPUT
IFS=$OLDIFS

rm -rf x.txt

echo "</layers></layerGroup>" >> layergroup.xml

echo "Criando grupo de camadas..."

curl -v -u admin:geoserver -XPOST -d @layergroup.xml -H "Content-type: text/xml" http://pleione:8080/geoserver/rest/layergroups
