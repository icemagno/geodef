FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com
COPY ./target/thundercloud-1.0.war /opt/lib/
ENTRYPOINT ["java"]
ENV LANG=pt_BR.utf8 
CMD ["-jar", "/opt/lib/thundercloud-1.0.war"]