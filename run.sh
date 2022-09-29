#!/bin/bash

if [ -f "/certificates/fullchain.pem" ]; then 
    cp ./etc/nginx/ssl.conf /certificates/ssl.conf 
else
    cp ./etc/nginx/selfsignedsslcerts.conf /certificates/ssl.conf
fi

echo "Starting nginx"
nginx

./app/docker-entrypoint.sh
