FROM ubuntu:18.04

MAINTAINER magno.mabreu@gmail.com

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    gfortran \
    software-properties-common \
    build-essential \
	openjdk-8-jdk

COPY ./target/mare-1.0.war /opt/lib/
RUN mkdir /opt/previsoes/
RUN mkdir /opt/constantes/
RUN mkdir /opt/libraries/

COPY ./dll/source/ROTINAS_MARE_ANALISE.f90 /opt/libraries/
COPY ./dll/source/ROTINAS_MARE_PREVISAO.f90 /opt/libraries/
COPY ./dll/source/compile.sh /opt/libraries/

RUN chmod 0777 /opt/libraries/compile.sh && cd /opt/libraries/ && /opt/libraries/compile.sh 

RUN ls /opt/libraries/
ENTRYPOINT ["java"]
CMD ["-jar", "-Djna.library.path=/opt/libraries", "-Djava.library.path=/opt/libraries", "/opt/lib/mare-1.0.war"]

