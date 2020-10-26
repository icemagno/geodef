CREATE TABLE geodata (
    id integer NOT NULL DEFAULT nextval('geodata_rpr_id_seq'::regclass),
    fonte character varying(50),
    tipo character varying(50),
    geom_json jsonb,
    metadados jsonb,
    geom geometry,
    CONSTRAINT geodata_rpr_primarykey PRIMARY KEY (id)
)

TABLESPACE pg_default;


CREATE INDEX geodata_rpr_geom_idx
    ON geodata USING gist
    (geom)
    TABLESPACE pg_default;
