#! /bin/sh


docker ps -a | awk '{ print $1,$2 }' | grep portainer | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker run --name portainer --restart=always -d -p 8000:8000 -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

