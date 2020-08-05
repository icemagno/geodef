#! /bin/sh

cd poseidon/
svn update
mvn clean package

docker ps -a | awk '{ print $1,$2 }' | grep sisgeodef/poseidon:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi sisgeodef/poseidon:1.0

docker build --tag=sisgeodef/poseidon:1.0 --rm=true .

docker run --name poseidon --hostname=poseidon \
	-e ARCHIMEDES_CONFIG_URI=http://archimedes:36206/ \
	-e CONFIG_PROFILES=default \
	-v /etc/localtime:/etc/localtime:ro \
	-p 36004:36004 \
	-d sisgeodef/poseidon:1.0	

docker network connect sisgeodef poseidon
docker network connect apolo poseidon

