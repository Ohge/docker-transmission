#!/bin/bash

### APP VARS
TYPE=svc
NAME=transmission
CFG_DIR=$HOME/.docker-transmission
CFG_VOL=/etc/transmission-daemon
USR_DIR=$HOME/downloads
USR_VOL=/downloads
GUI_PORT=9091
P2P_PORT=54321

### RUNTIME VARS
USR=$(whoami)
IMG=$TYPE/$NAME
APP=$USR.$NAME
LUID=$(id -u $USR)
LGID=$(id -g $USR)
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

### CHECK IF CONTAINER ALREADY EXISTS
CHECK=$(docker ps -a | awk '{print $NF}' | grep $APP)
if [[ $CHECK == *"$APP"* ]]; then echo -e "$APP already installed for this user\nRun ./uninstall.sh to remove"; exit 1; fi

### BUILD CONTAINER
CMDMSG="Installation of image"
CMDRES=$(docker build -t $IMG $DIR)
if [ $? -eq 0 ]; then echo "+$CMDMSG $IMG complete"; else echo -e "-$CMDMSG $IMG failed!\n$CMDRES"; exit 1; fi

### MAP CONFIG DIRECTORY
CMDMSG="Installation of volume"
CMDRES=$(cp -r $DIR/$NAME $CFG_DIR)
if [ $? -eq 0 ]; then echo "+$CMDMSG $CFG_DIR complete"; else echo -e "-$CMDMSG $CFG_DIR failed!\n$CMDRES"; exit 1; fi

### MAP DOWNLOAD DIRECTORY
CMDMSG="Installation of volume"
CMDRES=$(mkdir -p $USR_DIR)
if [ $? -eq 0 ]; then echo "+$CMDMSG $USR_DIR complete"; else echo -e "-$CMDMSG $USR_DIR failed!\n$CMDRES"; exit 1; fi

### MAP GUI PORT
CMDMSG="Installation of gui_port"
LGUI_PORT=$($DIR/.port.sh $GUI_PORT)
if [ $LGUI_PORT -gt 0 ]; then echo "+$CMDMSG $LGUI_PORT complete"; else echo "-$CMDMSG $LGUI_PORT failed!\n$LGUI_PORT"; exit 1; fi

### MAP P2P PORT
CMDMSG="Installation of p2p_port"
LP2P_PORT=$($DIR/.port.sh $P2P_PORT)
if [ $LP2P_PORT -gt 0 ]; then echo "+$CMDMSG $LP2P_PORT complete"; else echo "-$CMDMSG $LP2P_PORT failed!\n$LP2P_PORT"; exit 1; fi

### RUN USER CENTRIC CONTAINER
RUN=$(docker run -d \
--name $APP \
-e UID=$LUID \
-e GID=$LGID \
-v $CFG_DIR:$CFG_VOL \
-v $USR_DIR:$USR_VOL \
-p $LGUI_PORT:$GUI_PORT/tcp \
-p $LP2P_PORT:$P2P_PORT/tcp \
-p $LP2P_PORT:$P2P_PORT/udp \
$IMG)
REC=$?
CMDMSG="Installation of container"
if [ $REC -eq 0 ]; then echo "+$CMDMSG $APP complete"; else echo "-$CMDMSG $APP failed!"; fi
exit $REC
