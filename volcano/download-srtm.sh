#! /bin/sh

export ftp_proxy="http://07912470743:da03082001MB%21@proxy-1dn.mb:6060/"
export http_proxy="http://07912470743:da03082001MB%21@proxy-1dn.mb:6060/"
export https_proxy="https://07912470743:da03082001MB%21@proxy-1dn.mb:6060/"

 
mkdir /srv/srtm/

## phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -74.312:-11.351:-65.083:-3.996 --earthdata-user=icemagno --earthdata-password=Antares2#2

# America do Sul
phyghtmap --download-only \
	--srtm=1 \
	--area -82.18:-56.46:-33.22:-13.15 \
	--earthexplorer-user=icemagno \
	--earthexplorer-password=Antares2#2 \
	--jobs=10 \
	--srtm-version=3 \
	--hgtdir=/srv/srtm/ 

# America Central
phyghtmap --download-only \
	--srtm=1 \
	--area -118.30:6.75:-78.75:32.84 \
	--earthdata-user=icemagno \
	--earthdata-password=Antares2#2 \
	--jobs=10 \
	--srtm-version=3 \
	--hgtdir=/srv/srtm/ 


######     INSTALACAO      ###############
	
# http://katze.tfiu.de/projects/phyghtmap/phyghtmap.1.html
# http://katze.tfiu.de/projects/phyghtmap/download.html

	
# If you are not running a Debian-like system, you will want to have the source distribution. 
# phyghtmap_2.21.orig.tar.gz
# This is especially true, if you want to use phyghtmap on a Windows machine. 
# If so, go down to the seperate Windows installation section.

# To install phyghtmap, unpack the source file, chdir to the unpacked source directory and then say
#   sudo python3 setup.py install

# pip install matplotlib
