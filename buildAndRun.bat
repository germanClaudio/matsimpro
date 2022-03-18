@echo off
call mvn clean package
call docker build -t com.prodismo/WebApplicationTest .
call docker rm -f WebApplicationTest
call docker run -d -p 9080:9080 -p 9443:9443 --name WebApplicationTest com.prodismo/WebApplicationTest