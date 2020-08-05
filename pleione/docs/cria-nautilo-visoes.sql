CREATE SCHEMA IF NOT EXISTS nautilo;

CREATE OR REPLACE FUNCTION create_table_nautilo(t_name varchar(100))
  RETURNS VOID AS
$func$
BEGIN


EXECUTE format('
drop materialized view  if exists nautilo.%I;
create materialized view nautilo.%I AS (
	select * from indexacao."geodata" where tipo = ''%I'' and fonte = ''CHM''
);
drop index if exists nautilo_ndx_%I;
create index nautilo_ndx_%I on nautilo.%I using gist ("geom") ', t_name, t_name, t_name, t_name, t_name, t_name, t_name);

END
$func$ LANGUAGE plpgsql;




