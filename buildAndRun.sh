#!/bin/sh
mvn clean package && docker build -t com.prodismo/WebApplicationTest .
docker rm -f WebApplicationTest || true && docker run -d -p 9080:9080 -p 9443:9443 --name WebApplicationTest com.prodismo/WebApplicationTest