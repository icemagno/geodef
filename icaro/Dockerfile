FROM sisgeodef/base-gdal:1.0
MAINTAINER magno.mabreu@gmail.com
COPY ./target/icaro-1.0.war /opt/lib/
ENTRYPOINT ["java"]
CMD ["-jar", "/opt/lib/icaro-1.0.war"]