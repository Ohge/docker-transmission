#!/bin/bash

### LOAD COMMON COMPONENTS
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $DIR/.appvars
source $DIR/.common

### CHECK IF CONTAINER ALREADY EXISTS
CHECK=$(docker ps -a | awk '{print $NF}' | grep $APP)
if [[ $CHECK == *"$APP"* ]]; then echo -e "$APP already installed for this user\nRun ./uninstall.sh to remove"; exit 1; fi

### BUILD CONTAINER
printf "Installation of image $IMG "
CMDRES=$(docker build -t $IMG $DIR)
if [ $? -eq 0 ]; then echo "complete";
else echo -e "failed!\n$CMDRES"; exit 1; fi

### SETUP CONFIG DIRECTORY
printf "Installation of volume $CONFIG_DIR "
CMDRES=$(cp -r $DIR/$NAME $CONFIG_DIR)
if [ $? -eq 0 ]; then echo "complete";
else echo -e "failed!\n$CMDRES"; exit 1; fi

### SETUP DOWNLOAD DIRECTORY
printf "Installation of volume $USER_DIR "
CMDRES=$(mkdir -p $USER_DIR/.incoming $USER_DIR/.incomplete)
if [ $? -eq 0 ]; then echo "complete";
else echo -e "failed!\n$CMDRES"; exit 1; fi

### SETUP FETCH DIRECTORY
printf "Installation of volume $FETCH_DIR "
CMDRES=$(mkdir -p $FETCH_DIR)
if [ $? -eq 0 ]; then echo "complete";
else echo -e "failed!\n$CMDRES"; exit 1; fi

### FIND GUI PORT
LGUI_PORT=$(GetPort $GUI_PORT)
echo "Installation of gui_port $LGUI_PORT complete";

### FIND P2P PORT
LP2P_PORT=$(GetPort $P2P_PORT)
echo "Installation of p2p_port $LP2P_PORT complete";

### RUN APP CONTAINER
RUN=$(docker run -d \
--name $APP \
-e UID=$LUID \
-e GID=$LGID \
-v $CONFIG_DIR:$CONFIG_VOL \
-v $FETCH_DIR:$FETCH_VOL \
-v $USER_DIR:$USER_VOL \
-p $LGUI_PORT:$GUI_PORT/tcp \
-p $LP2P_PORT:$P2P_PORT/tcp \
-p $LP2P_PORT:$P2P_PORT/udp \
$IMG)
REC=$?
printf "Installation of container $APP "
if [ $REC -eq 0 ]; then echo "complete"; else echo "failed!"; exit 1; fi
exit $REC
