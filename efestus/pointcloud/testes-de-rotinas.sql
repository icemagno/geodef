CREATE OR REPLACE FUNCTION public.getpoints( xmin double precision, ymin double precision, xmax double precision, ymax double precision, quantos integer)
returns table ( ppp pcpoint ) 
language plpgsql
as $$
begin
  return query 
	WITH
	patches AS (
		SELECT pa FROM congonhas where pa::geometry && ST_MakeEnvelope($1, $2, $3, $4, 4326)
	),
	pa_pts AS (
		SELECT PC_Explode(pa) AS ppp FROM patches 
	)
	select * from pa_pts;
end; $$ 


CREATE OR REPLACE FUNCTION public.getpcloud( quantos integer, xmin double precision, ymin double precision, xmax double precision, ymax double precision)
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
        ST_AsGeoJSON(ST_Transform( ppp::geometry, 4326), 6) :: json as "geometry",
		json_build_object('data', array_to_json( PC_Get(ppp) ) ) as "properties"
        from getpoints(  $2, $3, $4, $5, $1  ) order by random() limit $1
    ) as f
) as fc;	
$func$ LANGUAGE sql STABLE STRICT;



select * from getpcloud( 5, -46.66422, -23.63013, -46.66345, -23.62943 )
select ppa from getpatches( -46.66422, -23.63013, -46.66345, -23.62943 )
select ppp from getpoints( -46.66422, -23.63013, -46.66345, -23.62943, 5 )

lopocs=# EXPLAIN ANALYZE select * from getpcloud( 5000, -46.66422, -23.63013, -46.66345, -23.62943 );
                                                QUERY PLAN                                                 
-----------------------------------------------------------------------------------------------------------
 Function Scan on getpcloud  (cost=0.25..0.26 rows=1 width=32) (actual time=88.040..88.041 rows=1 loops=1)
 Planning Time: 0.130 ms
 Execution Time: 88.057 ms
(3 rows)

lopocs=# EXPLAIN ANALYZE select * from getpcloud( 50000, -46.66422, -23.63013, -46.66345, -23.62943 );
                                                 QUERY PLAN                                                  
-------------------------------------------------------------------------------------------------------------
 Function Scan on getpcloud  (cost=0.25..0.26 rows=1 width=32) (actual time=751.489..751.491 rows=1 loops=1)
 Planning Time: 0.142 ms
 Execution Time: 751.513 ms
(3 rows)

lopocs=# EXPLAIN ANALYZE select * from getpcloud( 500000, -46.66422, -23.63013, -46.66345, -23.62943 );
                                                  QUERY PLAN                                                   
---------------------------------------------------------------------------------------------------------------
 Function Scan on getpcloud  (cost=0.25..0.26 rows=1 width=32) (actual time=2165.795..2165.797 rows=1 loops=1)
 Planning Time: 0.137 ms
 Execution Time: 2165.816 ms
(3 rows)
