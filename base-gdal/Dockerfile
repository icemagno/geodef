FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com
ENV ftp_proxy="http://172.22.200.10:3128"
ENV http_proxy="http://172.22.200.10:3128"
ENV https_proxy="http://172.22.200.10:3128"
ENV OGR_S57_OPTIONS="RETURN_PRIMITIVES=ON,RETURN_LINKAGES=ON,LNAM_REFS=ON,SPLIT_MULTIPOINT=ON,ADD_SOUNDG_DEPTH=ON"
RUN apt -y update
RUN apt -y install gdal