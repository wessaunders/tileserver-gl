#!/bin/bash

echo "Starting nginx"
nginx

echo "Docker entrypoint start"
./app/docker-entrypoint.sh
