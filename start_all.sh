#!/bin/bash

docker run -d -p 80 -p 22 preznik/wordpress

docker run -v `pwd`/selenium/:/tmp/src/ preznik/selenium-python xvfb-run python /tmp/src/setup-wordpress.py http://192.168.1.13:49158


docker run -v `pwd`/selenium/:/tmp/src/ preznik/selenium-python xvfb-run python /tmp/src/add-comment.py http://192.168.1.13:49158 sgdsfsdfsdfsdfgds


