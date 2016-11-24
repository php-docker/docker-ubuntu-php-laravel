FROM fabioluciano/ubuntu-nginx-php

MAINTAINER Fábio Luciano <fabioluciano@php.net>

ENV COMPOSER_HOME /usr/share/composer/

COPY files/certificados.pem files/certificado.crt files/certificado.key  files/certificado.key /etc/nginx/ssl/
RUN git config --global http.sslVerify false

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && /usr/local/bin/composer global require hirak/prestissimo \
  && rm -rf $COMPOSER_HOME/cache/*

COPY files/laravel.conf /etc/nginx/sites-available/default

VOLUME ["/var/www/application"]
