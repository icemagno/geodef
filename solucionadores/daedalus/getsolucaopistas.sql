/*

select * from icaro_airphelip limit 10

create or replace view icaro_airphelip as
SELECT 
	rw.interpretation,
	null::geometry as way_geom,
	rw.designator as way_designator,
	rw.type as way_type,
	rw.nominallength,
	rw.nominalwidth,
	rw.nominalwidth_uom,
	rw.composition,
	rw.classpcn,
	rw.pavementsubgradepcn,
	rw.pavementtypepcn, 
	rw.maxtyrepressurepcn,
	rw.evaluationmethodpcn,
	rw.lengthstrip,
	rw.lengthstrip_uom,
	rw.widthstrip,
	rw.widthstrip_uom,
	rw.preparation,
	rw.weightsiwl,
	rw.weightsiwl_uom,
	rw.tyrepressuresiwl,
	rw.tyrepressuresiwl_uom,
	ah.geom as airp_helip_geom,
	ah.designator,
	ah.name,
	ah.type,
	ah.privateuse,
	ah.fieldelevation,
	ah.fieldelevation_uom,
	ah.controltype,
	rw.classpcn || '/' || LEFT(rw.pavementtypepcn, 1) || '/' || rw.pavementsubgradepcn || '/' || rw.maxtyrepressurepcn || '/' || rw.evaluationmethodpcn as pcn_code
FROM 
	icaro.runway rw
join 
	icaro.airportheliport ah 
		on trim(LEADING '#' from rw.associatedairportheliport_href ) = ah.gml_id
*/
-- 1 - CLASSE PCN
-- 2 - FLEXIBLE  | RIGID
-- 3 - A | B | C | D
-- 4 - W | X | Y | Z
-- 5 - TECH      | ACFT
-- 6 - LENGTH
-- 7 - WIDTH

-- select icaro_pcn( 'FLEXIBLE', '*', '*', '*' )
--	ACN máximo aceitado	pavimento flexível	resistência alta	pressão média admissível	análise técnica	comprimento	largura
--	40					F					A					X							T				100			30



CREATE OR REPLACE FUNCTION icaro_pcn( pcn double precision, pavimento character varying(8), resistencia char,  pressao char, avaliacao character varying(5), 
		comprimento double precision, largura double precision,  designator text)
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
            --ST_AsGeoJSON(ST_Transform(airp_helip_geom, 4326), 6) :: json as "geometry",
			ST_AsGeoJSON( airp_helip_geom ) :: json as "geometry",
            (
                select json_strip_nulls(row_to_json(t))
                from (
                    select icaro_airphelip.* 
                ) t
            ) as "properties"
        from icaro_airphelip
		where 
		    (
				((case when classpcn = '' then null else classpcn end)::numeric  >= $1 or $1 = -1) 
			and 
				(icaro_airphelip.pavementtypepcn = $2 or $2 = '*')
			and
				(icaro_airphelip.pavementsubgradepcn = $3 or $3 = '*')
			and
				(icaro_airphelip.maxtyrepressurepcn = $4 or $4 = '*')
			and
				(icaro_airphelip.evaluationmethodpcn = $5 or $5 = '*')
			and
				((case when nominallength = '' then null else nominallength end)::numeric  >= $6 or $6 = -1)
			and 
				((case when nominalwidth = '' then null else nominalwidth end)::numeric >= $7 or $7 = -1)
			and
				(icaro_airphelip.designator = $8 or $8 = '*')
		    )
    ) as f
) as fc;
$func$ LANGUAGE sql STABLE STRICT;
