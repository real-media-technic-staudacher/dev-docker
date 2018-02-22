FROM mariadb:10.1

MAINTAINER Patrick Thomas <patrick.thomas@staudacher.de>

ENV MYSQL_DATABASE testing
ENV MYSQL_USER testing
ENV MYSQL_PASSWORD testing
ENV MYSQL_ROOT_PASSWORD dev

# copy the file into the container
COPY fix-permissions.sh /docker-entrypoint-initdb.d/fix-permissions.sh

# make it executable
RUN chmod +x /docker-entrypoint-initdb.d/fix-permissions.sh