FROM openjdk:11.0-stretch
MAINTAINER magno.mabreu@gmail.com
COPY ./admin-1.0.war /opt/lib/
ENV LANG=pt_BR.utf8 
ENTRYPOINT ["java"]
CMD ["-jar", "/opt/lib/admin-1.0.war"]