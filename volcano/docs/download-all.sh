#! /bin/sh

cd /home/apolo/srtm/


export ftp_proxy="http://06902331758:nextstep@proxy-1dn.mb:6060/"
export http_proxy="http://06902331758:nextstep@proxy-1dn.mb:6060/"
export https_proxy="https://06902331758:nextstep@proxy-1dn.mb:6060/"

phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -74.312:-11.351:-65.083:-3.996 --earthdata-user=icemagno --earthdata-password=Antares2#2


phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -64.995:-11.867:-34.497:5.354 --earthdata-user=icemagno --earthdata-password=Antares2#2


phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -70.137:-9.882:-65.039:2.328 --earthdata-user=icemagno --earthdata-password=Antares2#2


phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -65.500:-12.039:-64.512:-9.536 --earthdata-user=icemagno --earthdata-password=Antares2#2


phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -74.048:-10.099:-71.038:-4.872 --earthdata-user=icemagno --earthdata-password=Antares2#2


phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -65.479:-13.710:-37.723:-11.265 --earthdata-user=icemagno --earthdata-password=Antares2#2


phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -60.645:-16.594:-38.540:-13.539 --earthdata-user=icemagno --earthdata-password=Antares2#2


phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -58.579:-22.513:-38.848:-16.383 --earthdata-user=icemagno --earthdata-password=Antares2#2


phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -57.832:-34.089:-41.221:-22.350 --earthdata-user=icemagno --earthdata-password=Antares2#2


for osmfile in *.osm.pbf; do

osm2pgsql --number-processes 8 --latlong --verbose --append --cache 20000 --style ./srtm.style --database contour --username postgres -W --host 127.0.0.1 $osmfile
		 
done			 

