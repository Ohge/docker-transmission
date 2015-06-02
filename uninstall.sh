#!/bin/bash

### APP VARS
TYPE=svc
NAME=transmission
CFG_DIR=$HOME/.docker-transmission

### RUNTIME VARS
USR=$(whoami)
IMG=$TYPE/$NAME
APP=$USR.$NAME

### CHECK IF INSTALLED
if ! [[ $(docker ps -a | awk '{print $NF}' | grep $APP) == *"$APP"* ]]; then
  echo "Error: $APP not installed for this user"; exit 1
fi

### STOP CONTAINER
RES=$(docker ps -a | grep 'Up' | awk '{print $NF}' | grep -c '$APP')
if [ $RES -gt 0 ]; then
  RES=$(docker stop $APP)
fi
echo "-$APP stopped"

### REMOVE CONTAINER
RES=$(docker rm "$APP")
if [[ $RES == *"$APP"* ]]; then
  echo "-$APP uninstalled";
fi

### REMOVE UNUSED IMAGES
RES=$(docker ps -a | awk '{print $2}' | grep -c $IMG)
if [ $RES -eq 0 ]; then
  RES=$(docker rmi "$IMG")
  echo "-$IMG uninstalled"
fi

### REMOVE 
RES=$(docker images -notrunc | grep "^<none>" | awk '{print $1}' | xargs --no-run-if-empty docker rmi)
