FROM php:7.2.2-apache-stretch

MAINTAINER Patrick Thomas <patrick.thomas@staudacher.de>

ENV DEBIAN_FRONTEND noninteractive

COPY apache/000-default.conf /etc/apache2/sites-available/
COPY apache/apache2.conf /etc/apache2/
COPY supervisor/*.conf /etc/supervisor/conf.d/
COPY php_cli.ini /etc/php/7.0/cli/php.ini
COPY php.ini /etc/php/7.0/apache2/php.ini
COPY xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN apt-get update \
 && apt-get install -y git zlib1g-dev \
 && docker-php-ext-install mysqli pdo pdo_mysql zip \
 && a2enmod rewrite

ENV PATH "$PATH:$HOME/.composer/vendor/bin"

ENV PHP_IDE_CONFIG "serverName=docker"

RUN mkdir /var/run/sshd \
    && chmod 0755 /var/run/sshd \
    && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd

WORKDIR /var/www

EXPOSE 80
EXPOSE 22
EXPOSE 9001

#COPY docker-entrypoint.sh /
#
#ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]