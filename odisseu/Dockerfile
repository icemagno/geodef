FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com
COPY ./target/odisseu-1.0.war /opt/lib/
RUN mkdir /download-files/
ENV LANG=pt_BR.utf8 
ENTRYPOINT ["java"]
CMD ["-jar", "/opt/lib/odisseu-1.0.war"]
