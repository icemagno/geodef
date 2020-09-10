FROM osgeo/gdal:alpine-small-latest

RUN apk update && \
  apk upgrade && \
  apk add bash && \
  apk add --update nodejs npm git && \
  git clone https://github.com/TerriaJS/TerriaMap.git && \
  cd /TerriaMap
  
RUN npm install && \
  npm run gulp release && \
  chmod 0777 /TerriaMap/entrypoint.sh 

EXPOSE 3001

WORKDIR /TerriaMap  

COPY ./entrypoint.sh /TerriaMap
COPY ./config.json /TerriaMap/wwwroot


ENTRYPOINT ["/TerriaMap/entrypoint.sh"]

  