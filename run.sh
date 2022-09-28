#!/bin/bash

echo "Starting nginx"
nginx -g "daemon off;"

echo "Docker entrypoint start"
./app/docker-entrypoint.sh

