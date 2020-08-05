#! /bin/sh

mkdir -p result/hgt/SRTM1v3.0/

for hgtfile in hgt/SRTM1v3.0/*.hgt; do

gdaldem hillshade -co TILED=YES -co compress=lzw -s 111120 -z 5 -az 315 -combined -compute_edges $hgtfile result/$hgtfile.tif

done

ls result/hgt/SRTM1v3.0/* > list_of_files.txt

gdalbuildvrt -input_file_list list_of_files.txt -overwrite -addalpha imagens.vrt

gdal_translate -tr 0.000170 0.000170 -r cubicspline -of GTiff imagens.vrt teste.tif

gdaldem hillshade -co TILED=YES -co compress=lzw -s 111120 -z 5 -az 315 -combined -compute_edges teste.tif final.tif

gdaladdo -r cubicspline --config COMPRESS_OVERVIEW DEFLATE --config GDAL_TIFF_OVR_BLOCKSIZE 512 final.tif 2 4 8 16 32






