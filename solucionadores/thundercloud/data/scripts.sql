CREATE OR REPLACE FUNCTION public.getmunicipios( linestring text )
RETURNS json as
$func$  		
select row_to_json(fc)
from (
    select
        'FeatureCollection' as "type",
        array_to_json(array_agg(f)) as "features"
    from (
        select
            'Feature' as "type",
            ST_AsGeoJSON(ST_Transform(geom, 4326), 6) :: json as "geometry",
            (
                select json_strip_nulls(row_to_json(t))
                from (
                    select
                        cd_geocodm,
                        cd_geocodu,
						nm_municip	
                ) t
            ) as "properties"
        from uf_municipio
		where ST_Intersects( ST_MakePolygon( ST_GeomFromText( $1,4326) ), geom )
    ) as f
) as fc;		
$func$ LANGUAGE sql STABLE STRICT;


CREATE OR REPLACE FUNCTION public.getaerodromos( linestring text )
RETURNS json as
$func$  		
select row_to_json(fc)
from (
    select
        'FeatureCollection' as "type",
        array_to_json(array_agg(f)) as "features"
    from (
        select
            'Feature' as "type",
            ST_AsGeoJSON(ST_Transform(geom, 4326), 6) :: json as "geometry",
            (
                select json_strip_nulls(row_to_json(t))
                from (
                    select
                        dt,
                        uf,
						lng,
						lat,
						city,
						ciad,
						aeroCode,
						nameAe,
						ciad_id,
						idAe,
						typeAe
                ) t
            ) as "properties"
        from aerodromos
		where ST_Intersects( ST_MakePolygon( ST_GeomFromText( $1,4326) ), geom ) and typeAe = 'AD'
    ) as f
) as fc;		
$func$ LANGUAGE sql STABLE STRICT;


CREATE OR REPLACE FUNCTION public.getestacoes( linestring text )
RETURNS json as
$func$  		
select row_to_json(fc)
from (
    select
        'FeatureCollection' as "type",
        array_to_json(array_agg(f)) as "features"
    from (
        select
            'Feature' as "type",
            ST_AsGeoJSON(ST_Transform(geom, 4326), 6) :: json as "geometry",
            (
                select json_strip_nulls(row_to_json(t))
                from (
                    select
                        CD_ESTACAO,
                        CD_WMO,
						DT_MEDICAO,
						HR_MEDICAO,
						UF,
						VL_ALTITUDE,
						VEN_VEL,
						VEN_DIR,
						VEN_RAJ
                ) t
            ) as "properties"
        from estacoes_inmet
		where ST_Intersects( ST_MakePolygon( ST_GeomFromText( $1,4326) ), geom )
    ) as f
) as fc;		
$func$ LANGUAGE sql STABLE STRICT;



create table estacoes_inmet(
	CD_ESTACAO character varying(250) primary key,
	CD_WMO char(5),
	DT_MEDICAO char(10),
	HR_MEDICAO char(4),
	UF char(2),
	VL_ALTITUDE character varying(10),
	VEN_VEL character varying(10),
	VEN_DIR character varying(10),
	VEN_RAJ character varying(10),
	geom Geometry
);

create table aerodromos (
	dt character(10),
	uf character(2),
	lng double precision,
	city character varying(250),
    ciad character varying(100),
	aeroCode character varying(10),
	nameAe character varying(250),
    ciad_id integer,
    idAe character(36),
    typeAe character(2),
    lat double precision,
	geom Geometry
);