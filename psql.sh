#! /bin/sh

docker exec -i -t $1 psql -U postgres

#SELECT * FROM pg_stat_activity  ORDER BY xact_start ASC;
#select * from pg_stat_progress_vacuum