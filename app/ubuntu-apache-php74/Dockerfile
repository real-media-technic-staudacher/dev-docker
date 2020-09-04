FROM ubuntu:20.04

MAINTAINER Patrick Thomas <patrick.thomas@staudacher.de>

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update \
 && apt install -y curl php php-imagick php-soap php-mysqli php-mbstring php-curl php-xdebug php-pdo php-zip php-gd php-exif php-bcmath php-pear php-redis php7.4-dev php-soap git openssh-server zlib1g-dev supervisor imagemagick libmagickwand-dev libimage-exiftool-perl mysql-client libyaml-dev gnupg python3-pip python3-netaddr ffmpeg cron sudo vim zip lsof \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 \
 && apt update \
 && pip3 install 'docker-py>=1.7.0' \
 && pip3 install 'docker-compose>=1.7.0' \
 && pip3 install zabbix-api \
 && pip3 install git+https://github.com/ansible/ansible.git@v2.9.2 \
# && pecl install imagick yaml \
# && docker-php-ext-enable imagick yaml \
# && docker-php-ext-install mysqli pdo pdo_mysql zip pcntl gd exif \
 && a2enmod headers rewrite \
 && rm -rf /var/lib/apt/lists/* \
 && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
 && apt-get clean

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

ENV PATH "$PATH:$HOME/.composer/vendor/bin"

ENV PHP_IDE_CONFIG "serverName=docker"

ENV WEB_DOCUMENT_ROOT=/var/www/html/public

COPY apache/000-default.conf /etc/apache2/sites-available/
COPY apache/apache2.conf /etc/apache2/
COPY supervisor/*.conf /etc/supervisor/conf.d/
#COPY php.rmts.ini /usr/local/etc/php/conf.d/
COPY php.rmts.ini /etc/php/7.4/apache2/php.ini
COPY xdebug.rmts.ini /etc/php/7.4/apache2/conf.d/

ADD laravel-scheduler /etc/cron.d/laravel-scheduler
RUN chmod 0600 /etc/cron.d/laravel-scheduler

RUN sed -ri -e 's!/var/www/html!${WEB_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
  && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
  && touch /root/.Xauthority \
  && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
  && true

ARG imagemagic_config=/etc/ImageMagick-6/policy.xml

RUN sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' $imagemagic_config
RUN sed -i 's/<policy domain="coder" rights="none" pattern="EPS" \/>/<policy domain="coder" rights="read|write" pattern="EPS" \/>/g' $imagemagic_config

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 22
EXPOSE 9001

## Will be handled in the docker-entrypoint.sh because outside I had no access to environment variables!?
ENV QUEUE_WORKER ""
ENV QUEUE_WORKER_DIR "/var/www/html/resources/queue-worker"

COPY docker-entrypoint.sh /
ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
