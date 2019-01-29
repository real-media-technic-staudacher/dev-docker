FROM php:7.2.2-apache-stretch

MAINTAINER Patrick Thomas <patrick.thomas@staudacher.de>

ENV DEBIAN_FRONTEND noninteractive

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN apt-get update \
 && apt-get install -y git openssh-server zlib1g-dev supervisor imagemagick libmagickwand-dev libimage-exiftool-perl mysql-client libyaml-dev gnupg python-pip python-netaddr ffmpeg cron sudo vim zip \
 && echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 \
 && apt-get update \
 && apt-get install -y ansible \
 && pip install 'docker-py>=1.7.0' \
 && pip install 'docker-compose>=1.7.0' \
 && pecl install imagick yaml xdebug \
 && docker-php-ext-enable imagick yaml \
 && docker-php-ext-install mysqli pdo pdo_mysql zip pcntl gd exif bcmath \
 && a2enmod headers rewrite \
 && rm -rf /var/lib/apt/lists/* \
 && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
 && apt-get clean

ENV PATH "$PATH:$HOME/.composer/vendor/bin"

ENV PHP_IDE_CONFIG "serverName=docker"

ENV WEB_DOCUMENT_ROOT=/var/www/html/public

COPY apache/000-default.conf /etc/apache2/sites-available/
COPY apache/apache2.conf /etc/apache2/
COPY supervisor/*.conf /etc/supervisor/conf.d/
#COPY php_cli.ini /etc/php/7.0/cli/php.ini
COPY php.rmts.ini /usr/local/etc/php/conf.d
COPY xdebug.rmts.ini /usr/local/etc/php/conf.d
COPY crontab /etc
RUN chmod 0644 /etc/crontab

RUN sed -ri -e 's!/var/www/html!${WEB_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
  && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
  && touch /root/.Xauthority \
  && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
  && true

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 22
EXPOSE 9001

## Will be handled in the docker-entrypoint.sh because outside I had no access to environment variables!?
ENV QUEUE_WORKER ""
ENV QUEUE_WORKER_DIR "/var/www/html/resources/queue-worker"

COPY docker-entrypoint.sh /
ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]