#!/usr/bin/env bash
# Running as an arbitrary user
mkdir data
ls -lnd data
#drwxr-xr-x 2 1000 1000 4096 Aug 27 15:54 data
docker run -v "$PWD/data":/var/lib/mysql \
    --user 1000:1000 \
    --name neo4j-mysql \
    -p3306:3306 \
    -e MYSQL_ROOT_PASSWORD=123456@ \
    -d mysql:5.7.24