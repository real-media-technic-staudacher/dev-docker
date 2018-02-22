#!/bin/sh

case "$1" in
        *sh)
                exec "$@"
                exit 1
        ;;
esac

cp "${SUPERVISOR}" /etc/supervisor/conf.d

exec /usr/bin/supervisord -n