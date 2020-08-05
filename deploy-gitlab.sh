#! /bin/sh

mkdir /srv/gitlab/
mkdir /srv/gitlab/config
mkdir /srv/gitlab/logs
mkdir /srv/gitlab/data

echo "----------------------------------------------"
echo "  SE ESTIVER MIGRANDO"
echo "----------------------------------------------"
echo " RODE chmod -R 0777 /srv/gitlab "
echo " docker exec -it gitlab update-permissions "
echo "---------------ROOT---------------------------"
echo " ACESSE O CONSOLE DA INSTANCIA: "
echo " > gitlab-rails console production "
echo " > user = User.where(id: 1).first "
echo " > user.password = 'sisgeodef' "
echo " > user.password_confirmation = 'sisgeodef' "
echo " > user.unlock_access! "
echo " > user.save! "
echo "----------------APOLO-------------------------"
echo " > user = User.where(id: 2).first "
echo " > user.password = 'sisgeodef' "
echo " > user.password_confirmation = 'sisgeodef' "
echo " > user.unlock_access! "
echo " > user.save! "


docker run --name gitlab --hostname gitlab \
-v /srv/gitlab/config:/etc/gitlab \
-v /srv/gitlab/logs:/var/log/gitlab \
-v /srv/gitlab/data:/var/opt/gitlab  \
-v /etc/localtime:/etc/localtime:ro \
-p 36209:80 \
-d gitlab/gitlab-ce:11.11.0-ce.0

docker network connect apolo gitlab
docker network connect sisgeodef gitlab

