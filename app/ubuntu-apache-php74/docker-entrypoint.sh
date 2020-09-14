#!/bin/bash

case "$1" in
        *sh)
                exec "$@"
                exit 1
        ;;
esac

########## Did only work directly in docker-entrypoint.sh ##############
QUEUE_WORKER="${QUEUE_WORKER//\"/}"
files="${QUEUE_WORKER// /$IFS}"

for filename in $QUEUE_WORKER; do
  cp "$QUEUE_WORKER_DIR/${filename}" /etc/supervisor/conf.d
done
########## Did only work directly in docker-entrypoint.sh ##############

exec /usr/bin/supervisord -n