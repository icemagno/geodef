FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com
COPY ./target/olimpo-1.0.war /opt/lib/
ENTRYPOINT ["java"]
ENV LANG=pt_BR.utf8 
CMD ["-jar", "/opt/lib/olimpo-1.0.war"]