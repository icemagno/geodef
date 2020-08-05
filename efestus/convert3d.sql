WITH j (geom,height) AS (
  SELECT (ST_DumpPoints(way::geometry)).geom, alt from planet_osm_polygon 
)
update planet_osm_polygon set buildings3d = ( SELECT 
 ST_MakePolygon( ( ST_ForceClosed( ST_MakeLine( ST_MakePoint(ST_X(geom),ST_Y(geom),height) ) ) ) ) 
FROM j );