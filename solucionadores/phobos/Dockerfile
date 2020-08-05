FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com
COPY ./target/phobos-1.0.war /opt/lib/
RUN mkdir /pbf/
COPY ./pbf /pbf
ENTRYPOINT ["java"]
ENV LANG=pt_BR.utf8 
CMD ["-jar", "/opt/lib/phobos-1.0.war"]