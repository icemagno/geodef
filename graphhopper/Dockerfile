FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com
ENV JAVA_OPTS "-server -Xconcurrentio -Xmx2g -Xms2g -XX:+UseG1GC"
RUN mkdir -p /data 
VOLUME [ "/data" ]
WORKDIR /data
ENTRYPOINT ["java"]
CMD ["-Dgraphhopper.datareader.file=/osmfile/brazil-latest.osm.pbf","-jar","*.jar","server","/data/config.yml"]