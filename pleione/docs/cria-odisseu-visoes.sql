CREATE SCHEMA IF NOT EXISTS odisseu;

CREATE OR REPLACE FUNCTION create_table_odisseu(t_name varchar(100))
  RETURNS VOID AS
$func$
BEGIN

--NAO ESQUECE DE CRIAR OS INDICES !!!!

EXECUTE format('
drop materialized view  if exists odisseu.%I;
create materialized view odisseu.%I AS (
	select * from indexacao."geodata" where fonte = ''DSG''
    and substring(tipo from 5 for 100) = ''%I'' 
);', t_name, t_name, t_name);

END
$func$ LANGUAGE plpgsql;

-- NAO RODA ESSAS CONSULTAS. 
-- EXECUTAR TABELA POR TABELA SEPERADAMENTE.

--SELECT substring(g."tipo" from 5 for 100) 
--FROM indexacao.geodata g,
--     LATERAL create_table_odisseu( substring(g."tipo" from 5 for 100)  ) f;

	 
	 
--SELECT substring(g."tipo" from 5 for 100) 
--FROM indexacao.geodata g,
--     LATERAL create_table_odisseu( substring(g."tipo" from 5 for 100)  ) f
--where g."tipo" like 'adm_%'