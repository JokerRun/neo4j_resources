# [Tutorial: Import Data Into Neo4j](https://neo4j.com/developer/guide-importing-data-and-etl/)

## 1.下载Northwind数据

地址： [NorthWind dataset](https://code.google.com/p/northwindextended/downloads/detail?name=northwind.postgre.sql&can=2&q=)

## 2.运行Docker

```shell
#!/usr/bin/env bash
# start neo4j
docker run \
   -d --publish=7474:7474 --publish=7687:7687 \
    --volume=$HOME/neo4j/data:/data \
    --env=NEO4J_AUTH=none neo4j
   
# Running as an arbitrary user
mkdir data
ls -lnd data
#drwxr-xr-x 2 1000 1000 4096 Aug 27 15:54 data
docker run -v "$PWD/data":/var/lib/mysql \
    --user 1000:1000 \
    --name some-mysql \
    -p3306:3306 \
    -e MYSQL_ROOT_PASSWORD=123456@ \
    -d mysql:5.7.24
```

> docker images [mysql](https://hub.docker.com/_/mysql)  [neo4j](https://hub.docker.com/_/neo4j?tab=description)

