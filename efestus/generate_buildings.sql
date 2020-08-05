-- select * from public.getbuildings( 1000, -45, -24, -40, -20)


CREATE OR REPLACE FUNCTION public.getbuildings( quantos integer, xmin double precision, ymin double precision, xmax double precision, ymax double precision)
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
            ST_AsGeoJSON(ST_Transform(way, 4326), 6) :: json as "geometry",
            (
                select json_strip_nulls(row_to_json(t))
                from (
                    select
                        osm_id,
                        alt as height
                ) t
            ) as "properties"
        from planet_osm_polygon
        where public.planet_osm_polygon.way && ST_MakeEnvelope($2, $3, $4, $5, 4326)
        limit $1
    ) as f
) as fc;
$func$ LANGUAGE sql STABLE STRICT;


CREATE OR REPLACE FUNCTION public.getbuildings3D( quantos integer, xmin double precision, ymin double precision, xmax double precision, ymax double precision)
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
            ST_AsGeoJSON(ST_Transform(buildings3d, 4326), 6) :: json as "geometry",
            (
                select json_strip_nulls(row_to_json(t))
                from (
                    select
                        osm_id,
                        alt as height
                ) t
            ) as "properties"
        from planet_osm_polygon
        where public.planet_osm_polygon.buildings3d && ST_MakeEnvelope($2, $3, $4, $5, 4326)
        limit $1
    ) as f
) as fc;
$func$ LANGUAGE sql STABLE STRICT;


CREATE OR REPLACE FUNCTION ST_ForceClosed(geom geometry)
  RETURNS geometry AS
$BODY$BEGIN
  IF ST_IsClosed(geom) THEN
    RETURN geom;
  ELSIF GeometryType(geom) = 'LINESTRING' THEN
    SELECT ST_AddPoint(geom, ST_StartPoint(geom)) INTO geom;
  ELSIF GeometryType(geom) ~ '(MULTI|COLLECTION)' THEN
    -- Recursively deconstruct parts
    WITH parts AS (
      SELECT ST_ForceClosed(gd.geom) AS closed_geom FROM ST_Dump(geom) AS gd
    ) -- Reconstitute parts
    SELECT ST_Collect(closed_geom) INTO geom
    FROM parts;
  END IF;
  IF NOT ST_IsClosed(geom) THEN
    RAISE EXCEPTION 'Could not close geometry';
  END IF;
  RETURN geom;
END;$BODY$ LANGUAGE plpgsql IMMUTABLE COST 42;



drop function dump_geom(geom geometry, height real);							  
CREATE OR REPLACE FUNCTION dump_geom(the_geom geometry, the_height real) returns geometry
AS $$
BEGIN

WITH j (geom,height) AS (
 SELECT 
  (ST_DumpPoints(the_geom)).geom, the_height
)
SELECT 

 ST_MakePolygon( ST_ForceClosed(
  ST_MakeLine(
   ST_MakePoint(ST_X(geom),ST_Y(geom),height))) )
FROM j INTO the_geom;

return the_geom;

END; $$ LANGUAGE plpgsql;


delete from planet_osm_polygon where height is null;
-- sobram 2 201 000 poligonos
delete from planet_osm_point;
delete from planet_osm_line;
delete from planet_osm_ways;
delete from planet_osm_roads;
delete from planet_osm_nodes;
delete from planet_osm_rels;

alter table planet_osm_polygon add column alt real;
alter table planet_osm_polygon add column buildings3d Geometry;
delete from planet_osm_polygon where height !~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$'
update planet_osm_polygon set alt = CAST ( REPLACE(height,',','.') AS real);

WITH j (geom,height) AS (
  SELECT (ST_DumpPoints(way::geometry)).geom, alt from planet_osm_polygon 
)
update planet_osm_polygon set buildings3d = ( SELECT 
 ST_MakePolygon( ( ST_ForceClosed( ST_MakeLine( ST_MakePoint(ST_X(geom),ST_Y(geom),height) ) ) ) ) 
FROM j );

ALTER TABLE planet_osm_polygon ALTER COLUMN buildings3d TYPE geometry(PolygonZ) USING ST_Force3D(buildings3d);	
SELECT UpdateGeometrySRID('planet_osm_polygon','buildings3d',4326);
CREATE INDEX buildings3d_index ON public.planet_osm_polygon USING gist (buildings3d) TABLESPACE pg_default;

	