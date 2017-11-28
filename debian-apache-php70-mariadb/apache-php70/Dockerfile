FROM debian:9.2

MAINTAINER Patrick Thomas <patrick.thomas@staudacher.de>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https aptitude build-essential libssl-dev \
    nasm build-essential htop vim curl git subversion imagemagick unzip supervisor daemon libimage-exiftool-perl screen zsh wget \
    php7.0 php7.0-mysqlnd php7.0-sqlite php7.0-readline php7.0-xdebug php7.0-gd php7.0-mbstring php7.0-xml php7.0-zip php7.0-imagick php7.0-curl \
    imagemagick imagemagick-6-common imagemagick-6.q16 \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

RUN a2enmod rewrite

COPY 000-default.conf /etc/apache2/sites-available/

COPY apache2.conf /etc/apache2/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

WORKDIR /var/www/html

EXPOSE 80

COPY supervisor.conf /etc/supervisor/conf.d

COPY docker-entrypoint.sh /

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]

# RUN pecl install xdebug
# RUN echo 'zend_extension = "/usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so"' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#
# RUN echo "" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
#     echo xdebug.remote_enable=1 >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
#   	echo xdebug.remote_autostart=0 >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
#   	echo xdebug.remote_connect_back=1 >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
#   	echo xdebug.remote_port=9000 >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini;
#
# RUN apt-get update && apt-get install -y libmcrypt-dev \
#     mysql-client libmagickwand-dev --no-install-recommends \
#     git zsh ssh zip unzip vim supervisor \
#     && docker-php-ext-install mcrypt pdo_mysql
#
#
# WORK /var/www