FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com

ENV http_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/"

RUN apk --no-cache add curl

ENV http_proxy=""

COPY ./target/ortelius-1.0.war /opt/lib/
ENTRYPOINT ["java"]
ENV LANG=pt_BR.utf8 
CMD ["-jar", "/opt/lib/ortelius-1.0.war"]

