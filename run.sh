#!/bin/bash

if [ -f "/certificates/fullchain.pem" ]; then 
    cp ../app/ssl.conf /certificates/ssl.conf 
else
    cp ../app/selfsignedsslcerts.conf /certificates/ssl.conf
fi

echo "Starting nginx"
nginx

../app/docker-entrypoint.sh
