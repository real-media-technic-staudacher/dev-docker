#!/bin/sh
if grep -q "address=/$PROXYTLD/$PROXYIP" /etc/dnsmasq.conf; then
    echo "Already configured, all $PROXYIP addresses will be resolved to $PROXYTLD"
else
  echo -e "address=/$PROXYTLD/$PROXYIP" >> /etc/dnsmasq.conf
  echo "$PROXYIP addresses will be resolved to $PROXYTLD"
fi

exec "$@"