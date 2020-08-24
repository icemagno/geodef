FROM httpd:2.4.41
LABEL MAINTAINER="arthur.femar@marinha.mil.br"

COPY ./sisgeodef.conf /usr/local/apache2/sites-enabled/
COPY ./httpd-change.conf /usr/local/apache2/conf/httpd.conf

EXPOSE 80
