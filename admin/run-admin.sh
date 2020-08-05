#! /bin/sh

docker run --name admin --network apolo --hostname=admin \
--restart=always \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-p 36208:36208 \
-d magnoabreu/admin:1.0	

