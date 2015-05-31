#!/bin/bash

### SET VARIABLES
USRN=transmission
HOME_DIR=/home/$USRN
USR_CONF=$HOME_DIR/settings.json
DEF_CONF=$HOME_DIR/settings.json.default

### MANAGE CONFIGS
if [[ ! -f $USR_CONF ]]; then cp $DEF_CONF $USR_CONF; fi

### MANAGE USER AND VOLUME OWNERSHIP
if [[ ! $(grep --quiet '$HOME_DIR' /etc/passwd) ]]; then
  ### CREATE APPLICAITON USER
  echo "$USRN:x:$UID:$GID:$USRN,,,:$HOME_DIR:/bin/bash" >> /etc/passwd
  echo "$USRN:x:$UID:" >> /etc/group
  ### ASSIGN VOLUME OWNERSHIP
  chown $UID:$GID -R $HOME_DIR
fi

### START SERVICE USING RUNTIME UID AND GID
exec su - $USRN -c "/usr/bin/transmission-daemon -f -g $HOME_DIR 2>&1" 2>/dev/null
