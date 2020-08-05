#  script to add layer/style information
#  for every SLD file in our collection
#
restapi=http://localhost:8080/geoserver/rest
login=admin:geoserver
workspace=volcano
store=volcano

echo "Criar workspace $workspace" 
curl -v -u $login -XPOST -H "Content-type: text/xml" \
	-d "<workspace><name>$workspace</name></workspace>" \
	$restapi/workspaces

echo "Criar datastore $store"	
curl -v -u $login -XPOST -H "Content-type: text/xml" \
	-d @volcano-datastore.xml \
	$restapi/workspaces/$workspace/datastores	
	
	
	
for sldfile in volcano/*.sld; do

  layername=`basename $sldfile .sld`
  
  echo "Criar estilo no workspace $workspace"
  curl -v -u $login -XPOST -H "Content-type: text/xml" \
    -d "<style><name>$layername</name><filename>$sldfile</filename></style>" \
    $restapi/workspaces/$workspace/styles
  curl -v -u $login -XPUT -H "Content-type: application/vnd.ogc.sld+xml" \
    -d @$sldfile \
    $restapi/workspaces/$workspace/styles/$layername

done


