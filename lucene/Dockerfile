FROM openjdk:13-jdk-alpine
MAINTAINER magno.mabreu@gmail.com
COPY ./target/lucene-1.0.war /opt/lib/
RUN mkdir /etls/
ENV ftp_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/"
ENV http_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/"
ENV https_proxy="http://07912470743:da030801@proxy-1dn.mb:6060/"
ENTRYPOINT ["java"]
CMD ["-jar", "/opt/lib/lucene-1.0.war"]
