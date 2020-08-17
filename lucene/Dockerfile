FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com
COPY ./target/lucene-1.0.war /opt/lib/
RUN mkdir /etls/
ENTRYPOINT ["java"]
CMD ["-jar", "/opt/lib/lucene-1.0.war"]
