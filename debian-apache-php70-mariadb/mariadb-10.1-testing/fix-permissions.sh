#!/bin/bash

sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

mysql -u root -e "grant all on *.* to '$MYSQL_USER'@'%' identified by '${MYSQL_PASSWORD}' with grant option; flush privileges;"