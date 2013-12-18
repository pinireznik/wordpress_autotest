#!/bin/bash

IPADDRESS=192.168.1.13

docker run -name wp -d -p 49100:80 -p 22 preznik/wordpress

sleep 20

docker run -name=selenium1 -v `pwd`/selenium/:/tmp/src/ preznik/selenium-python xvfb-run python /tmp/src/setup-wordpress.py http://${IPADDRESS}:49100

sleep 10

docker run -name=selenium2 -v `pwd`/selenium/:/tmp/src/ preznik/selenium-python xvfb-run python /tmp/src/add-comment.py http://${IPADDRESS}:49100 sgdsfsdfsdfsdfgds

#docker kill wp selenium1 selenium2 ; docker rm wp selenium1 selenium2

