FROM debian:9.2

MAINTAINER Patrick Thomas <patrick.thomas@staudacher.de>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https aptitude build-essential libssl-dev \
    nasm build-essential htop vim curl git subversion imagemagick unzip supervisor daemon libimage-exiftool-perl screen zsh wget \
    php7.0 php7.0-mysqlnd php7.0-sqlite php7.0-readline php7.0-xdebug php7.0-gd php7.0-mbstring php7.0-xml php7.0-zip php7.0-imagick php7.0-curl \
    imagemagick imagemagick-6-common imagemagick-6.q16 \
    mysql-client \
    pdftk \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

RUN a2enmod rewrite

COPY apache/000-default.conf /etc/apache2/sites-available/
COPY apache/apache2.conf /etc/apache2/
COPY supervisor/*.conf /etc/supervisor/conf.d/
COPY php_cli.ini /etc/php/7.0/cli/php.ini
COPY php.ini /etc/php/7.0/apache2/php.ini
COPY xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

ENV PHP_IDE_CONFIG docker

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 9001

COPY docker-entrypoint.sh /

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]