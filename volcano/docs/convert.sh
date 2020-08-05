#! /bin/sh



phyghtmap --pbf –no-zero-contour –output-prefix contour –line-cat=500,100 –step=20 --jobs=8 --srtm=1 --a -44.978:-23.383:-40.902:-20.705 --earthdata-user=icemagno --earthdata-password=Antares2#2


ls hgt/SRTM1v3.0/*.hgt > list_of_files.txt
gdalbuildvrt -input_file_list list_of_files.txt -overwrite -addalpha imagens.vrt

gdal_translate -tr 0.000170 0.000170 -r cubicspline -of GTiff imagens.vrt teste.tif

gdaldem hillshade -co TILED=YES -co compress=lzw -s 111120 -z 5 -az 315 -combined -compute_edges teste.tif final.tif

gdaladdo -r cubicspline --config COMPRESS_OVERVIEW DEFLATE --config GDAL_TIFF_OVR_BLOCKSIZE 512 final.tif 2 4 8 16 32



		 
		 
			 
