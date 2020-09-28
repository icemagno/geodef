create table if exists bat( 
	id integer, 
	featureid character varying(50), 
	the_geom Geometry, 
	objectid integer, 
	gridcode integer, 
	shape_length double precision, 
	shape_area double precision 
);