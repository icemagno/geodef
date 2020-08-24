#! /bin/sh

docker ps -a | awk '{ print $1,$2 }' | grep apolo/apache-apolo:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}

docker rmi apolo/apache-apolo:1.0

docker build --tag=apolo/apache-apolo:1.0 --rm=true .

docker run --name apache-apolo --hostname=apache-apolo --network=sisgeodef \
--restart=unless-stopped --network-alias=sisgeodef.defesa.mil.br \
-v /etc/localtime:/etc/localtime:ro \
-p 80:80 \
-d apolo/apache-apolo:1.0
