#! /bin/sh

docker run  --network sisgeodef  \
-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
-e CONFIG_PROFILES=default \
-p 36340:36340 \
-d magnoabreu/ariia:1.0	

