#!/bin/bash

case "$1" in
        *sh)
                exec "$@"
                exit 1
        ;;
esac

########## Did only work directly in docker-entrypoint.sh ##############
OLDIFS="$IFS"

export IFS=" "

for filename in $SUPERVISOR_CONFIGS; do
  cp "$SUPERVISOR_PATH/${filename}" /etc/supervisor/conf.d
done

export IFS="$OLDIFS"
########## Did only work directly in docker-entrypoint.sh ##############

exec /usr/bin/supervisord -n