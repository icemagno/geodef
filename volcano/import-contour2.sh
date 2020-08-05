#! /bin/sh

# ./import-contour2.sh > output.log 2>&1 &

export PGPASSWORD=admin 
export PGPASS=admin

ls srtm/*.hgt > list_of_files.txt

gdalbuildvrt -input_file_list list_of_files.txt -overwrite srtm-files.vrt


#gdal_contour -a elevation -amin min -amax max -nln contour_gdal fl 100 200 300 -p -i 10 srtm-files.vrt srtm.shp
gdal_contour -f PostgreSQL -a elevation -nln contour_gdal -i 10 srtm-files.vrt "PG:host=volcano-db user=postgres password=admin dbname=contour" -lco OVERWRITE=YES 

#gdal_contour -f PostgreSQL -a elevation -nln contour_gdal -fl 100 200 300 -i 10 srtm/S23W043.hgt "PG:host=volcano-db user=postgres password=admin dbname=volcano" -lco OVERWRITE=YES 

echo "Processo encerrado."

#for f in *.asc
#do
#  echo "Processing $f"
# gdal_contour -a ELEV -i 0.25 $f $f-250mm.shp
#done



