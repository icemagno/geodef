FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com

RUN apk --no-cache add curl

COPY ./target/ortelius-1.0.war /opt/lib/
ENTRYPOINT ["java"]
ENV LANG=pt_BR.utf8 
CMD ["-jar", "/opt/lib/ortelius-1.0.war"]

