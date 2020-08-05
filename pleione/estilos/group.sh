#! /bin/bash

restapi=http://localhost:8080/geoserver/rest
login=admin:geoserver

rm -rf layergroup-$1.xml

echo "<layerGroup><name>group$1</name><workspace><name>$1</name></workspace><layers>" > layergroup-$1.xml
for sldfile in $1/*.sld; do
	layername=`basename $sldfile .sld`
	
	RESP=$(curl -I -s -u admin:geoserver -XGET -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/$1/layers/$layername)

	if [[ $RESP = *404* ]]
	then
		echo "ALERTA: Camada $layername nao existe no servidor para este workspace."
	else
		echo "<layer>$layername</layer>" >> layergroup-$1.xml	
	fi	
	
	
done
echo "</layers><bounds><minx>-180</minx><maxx>180</maxx><miny>-90</miny><maxy>90</maxy><crs class='projected'>EPSG:4326</crs></bounds></layerGroup>" >> layergroup-$1.xml
curl -v -u $login -XPOST -d @layergroup-$1.xml -H "Content-type: text/xml" $restapi/workspaces/$1/layergroups
echo "Processo encerrado."


#curl -v -u admin:geoserver -XPOST -d @layergroup-odisseu.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/odisseu/layergroups


