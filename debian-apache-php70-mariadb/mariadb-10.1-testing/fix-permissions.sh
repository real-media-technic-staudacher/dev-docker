#!/bin/bash

mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "grant all on *.* to '$MYSQL_USER'@'%' identified by '${MYSQL_PASSWORD}' with grant option; flush privileges;"