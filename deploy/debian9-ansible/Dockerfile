FROM php:7.2.2-apache-stretch

MAINTAINER Patrick Thomas <patrick.thomas@staudacher.de>

ENV DEBIAN_FRONTEND noninteractive

COPY supervisor/*.conf /etc/supervisor/conf.d/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN apt-get update \
 && apt-get install -y git gnupg openssh-server zlib1g-dev supervisor libmagickwand-dev mysql-client python-pip \
 && echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 \
 && apt-get update \
 && apt-get install -y ansible \
 && pecl install imagick \
 && pip install 'docker-py>=1.7.0' \
 && pip install 'docker-compose>=1.7.0' \
 && a2enmod rewrite \
 && rm -rf /var/lib/apt/lists/* \
 && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
 && apt-get clean
 
ENV PATH "$PATH:$HOME/.composer/vendor/bin"

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
  && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
  && touch /root/.Xauthority \
  && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
  && true

WORKDIR /var/www/html

EXPOSE 80
EXPOSE 22

COPY docker-entrypoint.sh /
ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]