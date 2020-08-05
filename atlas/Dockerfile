FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com
RUN mkdir /templates
COPY ./templates /templates/
COPY ./target/atlas-1.0.war /opt/lib/
ENTRYPOINT ["java"]
ENV LANG=pt_BR.utf8 
CMD ["-jar", "/opt/lib/atlas-1.0.war"]