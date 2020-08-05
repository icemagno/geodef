#!/bin/sh

#  script to add layer/style information
#  for every SLD file in our collection
#
restapi=http://pleione:8080/geoserver/rest
login=admin:geoserver
workspace=$2
store=$1

# ogr.sh <NOME_DATASTORE> <NOME_WORKSPACE> <NOME_CAMADA>

# strip the extension from the filename to use for layer/style names
layername=$3
  
echo "Publicar camada $layername"
curl -v -u $login -XPOST -H "Content-type: text/xml" \
    -d "<featureType><name>$layername</name></featureType>" \
    $restapi/workspaces/$workspace/datastores/$store/featuretypes?recalculate=nativebbox,latlonbbox

echo "Associar o estilo com a camada"
curl -v -u $login -XPUT -H "Content-type: text/xml" \
    -d "<layer><enabled>true</enabled><defaultStyle><name>$layername</name><workspace>$workspace</workspace></defaultStyle></layer>" \
    $restapi/layers/$workspace:$layername



