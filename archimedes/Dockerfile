FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com
RUN mkdir /archimedes/
COPY ./target/archimedes-1.0.war /opt/lib/
ENTRYPOINT ["java"]
CMD ["-jar", "/opt/lib/archimedes-1.0.war"]
EXPOSE 36206 
