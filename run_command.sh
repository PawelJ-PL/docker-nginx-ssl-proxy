#!/bin/bash

if [ -z "$HOST_ADDR" ]
then
    export HOST_ADDR=`/sbin/ip route|awk '/default/ { print $3 }'`
fi

openssl genrsa -out /tmp/server.key 4096

openssl req -new -sha256 -key /tmp/server.key -subj "/C=PL/CN=${CERT_CN}" -out /tmp/server.csr
echo "Generated CSR:"
openssl req -in /tmp/server.csr -noout -text
echo

echo
openssl x509 -req -in /tmp/server.csr -CA /tmp/rootCA.crt -CAkey /tmp/rootCA.key -CAcreateserial -out /tmp/server.crt -days 365 -sha256 -passin pass:secret
echo "Generated Certificate:"
openssl x509 -in /tmp/server.crt -text -noout
echo

cat /tmp/server.crt /tmp/rootCA.crt > /tmp/bundle.crt

envsubst < /tmp/proxy_ssl.conf.template > /etc/nginx/conf.d/proxy_ssl.conf
exec nginx -p /tmp -g 'daemon off;'

