CREATE SEQUENCE geodata_rpr_id_seq;

CREATE TABLE geodata (
    id integer NOT NULL DEFAULT nextval('geodata_rpr_id_seq'::regclass),
    user_cpf character varying(14) NOT NULL,
	op_id character varying(100) NOT NULL,
    geo_json jsonb,
    geom geometry,
    CONSTRAINT geodata_rpr_primarykey PRIMARY KEY (id)
)

TABLESPACE pg_default;


CREATE INDEX geodata_rpr_geom_idx
    ON geodata USING gist
    (geom)
    TABLESPACE pg_default;
