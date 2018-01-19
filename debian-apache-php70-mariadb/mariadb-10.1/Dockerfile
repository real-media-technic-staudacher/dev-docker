FROM mariadb:10.1

MAINTAINER Patrick Thomas <patrick.thomas@staudacher.de>

COPY create-testingdb.sql /docker-entrypoint-initdb.d

ENV MYSQL_USER dev
ENV MYSQL_PASSWORD dev
ENV MYSQL_ROOT_PASSWORD dev