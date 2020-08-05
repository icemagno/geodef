#! /bin/sh

docker start archimedes
echo "Aguardando Archimedes... (20 seg)"
sleep 20
docker start delphos


docker start ariia-db
docker start atlas-db
docker start guardiao-db
docker start icaro-db
docker start indra-db
docker start lucene-db
docker start nautilo-db
#docker start nextcloud-db
docker start odisseu-db
#docker start ortelius-db
docker start volcano-db
docker start nyx-db
# Efestus eh um banco
docker start efestus

echo "Aguardando os bancos de dados... (20 seg)"
sleep 20

docker start zipkin
docker start midas
docker start olimpo
docker start pleione
docker start mapproxy
docker start thredds
docker start rabbitmq
docker start ariia

echo "Aguardando grupo... (20 seg)"
sleep 20

docker start guardiao
docker start ortelius
docker start calisto
docker start graphhopper
#docker start entwine
#docker start grass
docker start lucene
docker start icaro
docker start nautilo
docker start odisseu

echo "Aguardando grupo... (20 seg)"
sleep 20

docker start sistram
docker start daedalus
docker start thundercloud

echo "Aguardando grupo... (20 seg)"
sleep 20

docker start gaia
docker start node-exporter
docker start cadvisor
docker start prometheus
docker start grafana
docker start draco
docker start nyx
docker start iscy
docker start pgadmin
docker start admin
docker start hades
#docker start nextcloud

docker start atlas


