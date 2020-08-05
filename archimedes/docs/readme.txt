É necessário instalar o GitLab do zero.

parar o container

Apagar 
/srv/gitlab/config
/srv/gitlab/data

Restaurar estas pastas do backup

Subir o container

Se der erro no login:

Acessar o terminal
gitlab-rails console production
user = User.where(id: 1).first  //// ou //// user = User.find_by(email: 'apolo@casnav.mb')
user.password = 'secret_pass'
user.password_confirmation = 'secret_pass'
user.save!
user.unlock_access!
