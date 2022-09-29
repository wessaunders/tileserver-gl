#!/bin/bash

if [ -f "/certificates/fullchain.pem" ]; then 
    cp nginx/ssl.conf /certificates/ssl.conf 
fi

echo "Starting nginx"
nginx

./app/docker-entrypoint.sh
