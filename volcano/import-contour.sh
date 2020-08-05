#! /bin/sh


# ./import-contour.sh > output.log 2>&1 &
# rm -f output.log

export PGPASSWORD=admin 
export PGPASS=admin

echo "---------------CONTINUANDO -------------------" > filelist.txt

echo "Gerando curvas de nivel em volcano-db/contour. Isso vai demorar ..."
#gdal_contour -f PostgreSQL -a elevation -nln contour_gdal -i 10 srtm-files.vrt "PG:host=volcano-db user=postgres password=admin dbname=contour" -lco OVERWRITE=YES 


input="./towork.txt"
while IFS= read -r f
do

  	echo "Processando $f"
	echo "$f" >> filelist.txt
	
	gdal_contour -f PostgreSQL -a elevation -nln contour_lines -i 10 $f "PG:host=volcano-db user=postgres password=admin dbname=contour" -lco OVERWRITE=YES

	psql "host='volcano-db' dbname='contour' user='postgres' password='admin'" -c "insert into contour ( select * from contour_lines);"

	psql "host='volcano-db' dbname='contour' user='postgres' password='admin'" -c "create table if not exists contour as ( select * from contour_lines);"	



done < "$input"


#for f in srtm/*.hgt
#do
#  	echo "Processando $f"
#	echo "$f" >> filelist.txt
	
#	gdal_contour -f PostgreSQL -a elevation -nln contour_lines -i 10 $f "PG:host=volcano-db user=postgres password=admin dbname=contour" -lco OVERWRITE=YES

#	psql "host='volcano-db' dbname='contour' user='postgres' password='admin'" -c "insert into contour ( select * from contour_lines);"

#	psql "host='volcano-db' dbname='contour' user='postgres' password='admin'" -c "create table if not exists contour as ( select * from contour_lines);"	
	
#done

psql "host='volcano-db' dbname='contour' user='postgres' password='admin'" -c "CREATE INDEX contour_idx ON contour USING gist (wkb_geometry);"	
psql "host='volcano-db' dbname='contour' user='postgres' password='admin'" -c "ALTER TABLE contour ADD PRIMARY KEY (ogc_fid);"	
psql "host='volcano-db' dbname='contour' user='postgres' password='admin'" -c "drop table contour_lines;"	

echo "Processo encerrado."

