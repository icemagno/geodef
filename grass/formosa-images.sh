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

# BAIXA IMAGENS

## BAIXAR CURVAS DO NOSSO SERVIDOR VIA WMS!!
r.in.wms url=http://volcano:36212/geoserver/wms layers=curvas-hillshade output=CURVAS_HILL format=png --overwrite
r.out.png input=CURVAS_HILL output=CURVAS_HILL.png -t --overwrite compression=9 -w

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

## IBAMA
r.in.wms url=http://siscom.ibama.gov.br/geoserver/wms layers=publica:veg_cerrado_mdbbs_2009_a output=SISCOM_CERRADO format=png --overwrite
r.out.png input=SISCOM_CERRADO output=SISCOM_CERRADO.png -t --overwrite compression=9 -w

## IBGE
r.in.wms url=https://geoservicos.ibge.gov.br/geoserver/wms layers=CREN:Pedologia_area_Brasil output=IBGE_PED_BRAS format=png --overwrite
r.out.png input=IBGE_PED_BRAS output=IBGE_PED_BRAS.png -t --overwrite compression=9 -w

r.in.wms url=https://geoservicos.ibge.gov.br/geoserver/wms layers=CREN:ClimadoBrasil_5000 output=IBGE_CLIMA_BRAS format=png --overwrite
r.out.png input=IBGE_CLIMA_BRAS output=IBGE_CLIMA_BRAS.png -t --overwrite compression=9 -w

r.in.wms url=https://geoservicos.ibge.gov.br/geoserver/wms layers=CREN:vegetacao_5000 output=IBGE_VEGETACAO_BRAS format=png --overwrite
r.out.png input=IBGE_VEGETACAO_BRAS output=IBGE_VEGETACAO_BRAS.png -t --overwrite compression=9 -w

