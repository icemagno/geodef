#! /bin/sh

wget "http://localhost:36002/v1/runways?pcn=-1&pavimento=*&resistencia=*&pressao=*&avaliacao=*&comprimento=-1&largura=-1&icao=SBRJ" -O daedalus.json 