#!/bin/bash

IPADDRESS=192.168.1.13
SUITS=$1


if [ $# -eq 0 ]
  then
    echo "Need number of parallel executions."
else
   echo "Number of parallel executions is $1"
fi

for (( VAR=1; VAR<=$SUITS; VAR++ ))
do
   echo "Starting Wordpress container wp${VAR} on port 491${VAR}0"
   docker run -name wp${VAR} -d -p 491${VAR}0:80 -p 22 preznik/wordpress
done

echo "Waiting for 20 seconds for DB to sturtup"
sleep 20

for (( VAR=1; VAR<=$SUITS; VAR++ ))
do
   echo "Running Selenuim script in container selenium_setup${VAR} to setup Wordpress on http://${IPADDRESS}:491${VAR}0"
   docker run -name=selenium_setup${VAR} -v `pwd`/selenium/:/tmp/src/ preznik/selenium-python xvfb-run python /tmp/src/setup-wordpress.py http://${IPADDRESS}:491${VAR}0 & pid_selenuim_setup="${pid_selenuim_setup} $!"
#   sleep 1
done

wait $pid_selenuim_setup

echo "Waiting for 10 seconds to finish Wordpress configuration"
sleep 10

for (( VAR=1; VAR<=$SUITS; VAR++ ))
do
   echo "Running Selenuim script in container selenium_setup${VAR} to add comment to  Wordpress on http://${IPADDRESS}:491${VAR}0"
   docker run -name=selenium_test${VAR} -v `pwd`/selenium/:/tmp/src/ preznik/selenium-python xvfb-run python /tmp/src/add-comment.py http://${IPADDRESS}:491${VAR}0 "Comment" & pid_selenuim_test="${pid_selenuim_test} $!"
#   sleep 1
done 

wait $pid_selenuim_test

echo "Cleanning up containers"
for (( VAR=1; VAR<=$SUITS; VAR++ ))
do
   CONTAINERS_TO_KILL="$CONTAINERS_TO_KILL wp${VAR}"
   CONTAINERS_TO_RM="$CONTAINERS_TO_RM wp${VAR} selenium_setup${VAR} selenium_test${VAR}"
done

echo docker kill $CONTAINERS_TO_KILL 
echo docker rm $CONTAINERS_TO_RM
