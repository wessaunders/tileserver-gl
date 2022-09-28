#!/bin/bash

echo "Starting nginx"
nginx

./app/docker-entrypoint.sh
