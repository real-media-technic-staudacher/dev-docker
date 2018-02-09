FROM php:7.2

MAINTAINER Patrick Thomas <patrick.thomas@staudacher.de>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https aptitude build-essential libssl-dev \
    nasm build-essential htop vim curl git subversion imagemagick unzip supervisor daemon libimage-exiftool-perl screen zsh wget \
    openssh-server \
    imagemagick imagemagick-6-common imagemagick-6.q16 \
    mysql-client \
    pdftk \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

RUN docker-php-ext-install mysqlnd sqlite readline xdebug gd mbstring xml zip imagick curl

RUN a2enmod rewrite

COPY apache/000-default.conf /etc/apache2/sites-available/
COPY apache/apache2.conf /etc/apache2/
COPY supervisor/*.conf /etc/supervisor/conf.d/
COPY php_cli.ini /etc/php/7.0/cli/php.ini
COPY php.ini /etc/php/7.0/apache2/php.ini
COPY xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

ENV PHP_IDE_CONFIG "serverName=docker"

RUN mkdir /var/run/sshd \
    && chmod 0755 /var/run/sshd \
    && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 22
EXPOSE 9001

COPY docker-entrypoint.sh /

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]