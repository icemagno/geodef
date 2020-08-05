#! /bin/sh

#########  FORMOSA  ##########
#             |              #
# S16W048.hgt |              #
#             |              #
#----------------------------#
#             |              #
# S17W048.hgt |	             #
#             |              #
##############################


## COMBINA / MERGE VARIOS RASTERS
#r.patch input=teste1234,S23W043_CLR output=combined
#r.out.png input=combined output=/home/magno/grass/combined.png -t --overwrite compression=9 -w
# RASTERIZA VETOR
#v.to.rast input=FORMOSA_CNT output=FORMOSA_CNT_R attribute_column=level use=attr type=line --overwrite
#r.out.png input=FORMOSA_CNT_R output=FORMOSA_CNT_R.png -t --overwrite compression=9 -w

# FORA DO GRASS:
ls S1* > hgt_formosa.txt 
gdalbuildvrt -input_file_list hgt_formosa.txt -overwrite hgt_formosa.vrt

# INICIA O GRASS
grass -c /data/formosa/ hgt_formosa.vrt

# se tiver travado em outro terminal
grass -f

# DENTRO DO GRASS:

r.in.gdal input=hgt_formosa.vrt output=FORMOSA --overwrite
g.region rast=FORMOSA

# HILLSHADE
r.relief input=FORMOSA output=FORMOSA_HSH --overwrite
r.out.png input=FORMOSA_HSH output=FORMOSA_HSH.png -t --overwrite compression=9 -w

# COLOR 
r.shade shade=FORMOSA_HSH color=FORMOSA output=FORMOSA_CLR --overwrite
r.out.png input=FORMOSA_CLR output=FORMOSA_CLR.png -t --overwrite compression=9 -w

## SLOPE
r.slope.aspect elevation=FORMOSA slope=FORMOSA_SLP aspect=FORMOSA_ASP --overwrite
r.colors -n map=FORMOSA_SLP color=sepia
r.out.png input=FORMOSA_SLP output=FORMOSA_SLP.png -t --overwrite compression=9 -w

# BAIXA IMAGENS

# export no_proxy="127.0.0.1, localhost, volcano, osm.casnav.mb, pleione"
# export http_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/"

## BAIXAR CURVAS DO NOSSO SERVIDOR VIA WMS!!
r.in.wms url=http://pleione:8080/geoserver/wms layers=curvas-hillshade output=CURVAS_HILL format=png --overwrite
r.out.png input=CURVAS_HILL output=CURVAS_HILL.png -t --overwrite compression=9 -w

## OSM CASNAV
r.in.wms url=http://osm.casnav.mb:8080/geoserver/wms layers=osm:OSMMapa output=OSMMAPA format=png --overwrite
r.out.png input=OSMMAPA output=OSMMAPA.png -t --overwrite compression=9 -w

export https_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/"
export http_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/"


## BDGEX
r.in.wms url=https://bdgex.eb.mil.br/mapcache layers=rapideye output=RAPIDEYE format=png --overwrite
r.out.png input=RAPIDEYE output=RAPIDEYE.png -t --overwrite compression=9 -w

r.in.wms url=https://bdgex.eb.mil.br/mapcache layers=Multiescala_LocalidadesLimites output=BDGEX_MEL format=png --overwrite
r.out.png input=BDGEX_MEL output=BDGEX_MEL.png -t --overwrite compression=9 -w

r.in.wms url=https://bdgex.eb.mil.br/mapcache layers=Multiescala_RodoviasFerrovias output=BDGEX_RODFER format=png --overwrite
r.out.png input=BDGEX_RODFER output=BDGEX_RODFER.png -t --overwrite compression=9 -w

r.in.wms url=https://bdgex.eb.mil.br/mapcache layers=Multiescala_Relevo output=BDGEX_RELEVO format=png --overwrite
r.out.png input=BDGEX_RELEVO output=BDGEX_RELEVO.png -t --overwrite compression=9 -w

r.in.wms url=https://bdgex.eb.mil.br/cgi-bin/mapaindice layers=F25_WGS84_ORTOIMAGEM output=BDGEX_ORTOIMAGEM format=png --overwrite
r.out.png input=BDGEX_ORTOIMAGEM output=BDGEX_ORTOIMAGEM.png -t --overwrite compression=9 -w


## IBGE
r.in.wms url=https://geoservicos.ibge.gov.br/geoserver/wms layers=CREN:Pedologia_area_Brasil output=IBGE_PED_BRAS format=png --overwrite
r.out.png input=IBGE_PED_BRAS output=IBGE_PED_BRAS.png -t --overwrite compression=9 -w
wget -O IBGE_PED_BRAS_LEG.png
https://geoservicos.ibge.gov.br/geoserver/wms?request=GetLegendGraphic&version=1.3.0&format=image/png&layer=CREN:Pedologia_area_Brasil

r.in.wms url=https://geoservicos.ibge.gov.br/geoserver/wms layers=CREN:ClimadoBrasil_5000 output=IBGE_CLIMA_BRAS format=png --overwrite
r.out.png input=IBGE_CLIMA_BRAS output=IBGE_CLIMA_BRAS.png -t --overwrite compression=9 -w
wget -O IBGE_CLIMA_BRAS_LEG.png
https://geoservicos.ibge.gov.br/geoserver/wms?request=GetLegendGraphic&version=1.3.0&format=image/png&layer=CREN:ClimadoBrasil_5000

r.in.wms url=https://geoservicos.ibge.gov.br/geoserver/wms layers=CREN:vegetacao_5000 output=IBGE_VEGETACAO_BRAS format=png --overwrite
r.out.png input=IBGE_VEGETACAO_BRAS output=IBGE_VEGETACAO_BRAS.png -t --overwrite compression=9 -w
wget -O IBGE_VEGETACAO_BRAS_LEG.png https://geoservicos.ibge.gov.br/geoserver/wms?request=GetLegendGraphic&version=1.3.0&format=image/png&layer=CREN:vegetacao_5000





## OSM
export OSM_CONFIG_FILE=/data/osm_config.ini

v.in.ogr input=formosa.osm layer=multilinestrings  output=FORMOSA_OSM_L --overwrite -o
v.in.ogr input=formosa.osm layer=points output=FORMOSA_OSM_P --overwrite -o

v.in.ogr input=brazil-latest.osm.pbf layer=multipolygons output=OSM_BRASIL --overwrite -o

v.colors FORMOSA_OSM_L column=cat color=random
v.colors FORMOSA_OSM_P column=cat color=random
v.colors FORMOSA_OSM_M column=cat color=random

d.mon start=png output=FORMOSA_OSM.png width=3601 height=7201 --overwrite
d.rast FORMOSA_SLP
d.vect FORMOSA_OSM_L
d.vect FORMOSA_OSM_P
d.vect FORMOSA_OSM_M
d.mon stop=png

## FUNDE RASTER ( Transparencia? )
r.patch input=CURVAS_HILL,OSMMAPA output=CURVASOSM
r.out.png input=CURVASOSM output=CURVASOSM.png -t --overwrite compression=9 -w


## CRIA VIEWSHED
r.viewshed input=FORMOSA output=FORMOSA_VS max_distance=10000 coordinates=-47.265102,-15.600131
## EXPORTA VIEWSHED PARA IMAGEM
r.out.png input=FORMOSA_VS output=FORMOSA3_VS.png -t --overwrite compression=9 -w
## CONVERTE VIEWSHED PARA VETOR
r.to.vect input=FORMOSA_VS output=FORMOSA_SHP type=area -s

## VARIAS FORMAS DE EXPORTAR O VETOR COM A AREA VISTA
v.out.ogr input=FORMOSA_SHP output=FORMOSA_SHP.shp -c --overwrite -e --verbose
v.out.ogr input=FORMOSA_SHP output=FORMOSA_SHP.kml format=KML 
## v.out.ogr -c input=FORMOSA_SHP output="PG:host=volcano-db dbname=volcano user=postgres password=admin" format=PostgreSQL --overwrite

# FUNDE HILLSHADE COLOR com VIEWSHED
d.mon start=png --overwrite output=FORMOSA_OSM_SHP.png #width=1920 height=1080
d.rast FORMOSA_OSM
d.vect FORMOSA_SHP
d.mon stop=png

d.mon start=png --overwrite output=FORMOSA_HSH_SHP.png #width=1920 height=1080
d.rast FORMOSA_HSH
d.vect FORMOSA_SHP
d.mon stop=png





