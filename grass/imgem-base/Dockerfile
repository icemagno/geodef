FROM ubuntu:18.04

LABEL authors="Carlos Magno Abreu"
LABEL maintainer="magno.mabreu@gmail.com"
 
ENV DATA_DIR /data

ENV GRASS_PNGFILE=/data/grass7output.png
ENV GRASS_TRUECOLOR=TRUE
ENV GRASS_WIDTH=900
ENV GRASS_HEIGHT=1200
ENV GRASS_PNG_COMPRESSION=1
ENV GRASS_MESSAGE_FORMAT=plain


# GDAL
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntugis/ppa 

# GRASS GIS compile dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        libblas-dev \
        libbz2-dev \
        libcairo2-dev \
        libfftw3-dev \
        libfreetype6-dev \
        libgdal-dev \
        libgeos-dev \
        libglu1-mesa-dev \
        libgsl0-dev \
        libjpeg-dev \
        liblapack-dev \
        libncurses5-dev \
        libnetcdf-dev \
        libopenjp2-7 \
        libopenjp2-7-dev \
        libpdal-dev pdal \
        libpdal-plugin-python \
        libpng-dev \
        libpq-dev \
        libproj-dev \
        libreadline-dev \
        libsqlite3-dev \
        libtiff-dev \
        libxmu-dev \
        libzstd-dev \
		libgdal-dev \
        bison \
        flex \
        g++ \
        gettext \
        gdal-bin \
        libfftw3-bin \
        make \
        ncurses-bin \
        netcdf-bin \
        proj-bin \
        proj-data \
        sqlite3 \
        subversion \
        unixodbc-dev \
        zlib1g-dev \
		python3 \
        python3-dev \
        python3-numpy \
        python3-pil \
        python3-ply \
        python3-six \
        openjdk-8-jdk \
		grass \
		grass-dev \
    && apt-get autoremove \
    && apt-get clean && \
    mkdir -p $DATA_DIR

RUN echo "alias python=python3" >> /root/.bashrc	
	
RUN echo LANG="en_US.UTF-8" > /etc/default/locale
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN mkdir /code
RUN mkdir /code/grass

WORKDIR /code/grass

#RUN pip install GDAL

# enable simple grass command regardless of version number
RUN ln -s /usr/local/bin/grass* /usr/local/bin/grass

# Reduce the image size
RUN apt-get autoremove -y
RUN apt-get clean -y

# set SHELL var to avoid /bin/sh fallback in interactive GRASS GIS sessions in docker
ENV SHELL /bin/bash

# Fix permissions
RUN chmod -R a+rwx $DATA_DIR

# create a user
#RUN useradd -m -U grass

# declare data volume late so permissions apply
VOLUME $DATA_DIR
WORKDIR $DATA_DIR

CMD ["grass", "--version"]
