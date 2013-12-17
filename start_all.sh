#!/bin/bash

docker run -name wp -d -p 49100:80 -p 22 preznik/wordpress

sleep 20

docker run -v `pwd`/selenium/:/tmp/src/ preznik/selenium-python xvfb-run python /tmp/src/setup-wordpress.py http://172.20.10.9:49100

sleep 10

docker run -v `pwd`/selenium/:/tmp/src/ preznik/selenium-python xvfb-run python /tmp/src/add-comment.py http://172.20.10.9:49100 sgdsfsdfsdfsdfgds

#docker kill wp ; docker rm wp

