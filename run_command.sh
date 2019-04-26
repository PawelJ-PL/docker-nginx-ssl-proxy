#!/bin/bash

export HOST_ADDR=`/sbin/ip route|awk '/default/ { print $3 }'`

envsubst < /tmp/proxy_ssl.conf.template > /etc/nginx/conf.d/proxy_ssl.conf
exec nginx -p /tmp -g 'daemon off;'

