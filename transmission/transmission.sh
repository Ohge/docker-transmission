#!/bin/bash

### SET VARIABLES
USRN=transmission
USER_DIR=/downloads
CONF_DIR=/etc/transmission-daemon
USR_CONF=$CONF_DIR/settings.json
DEF_CONF=$CONF_DIR/settings.json.default

### MANAGE CONFIGS
if [[ ! -f $USR_CONF ]]; then cp $DEF_CONF $USR_CONF; fi

### MANAGE USER AND VOLUME OWNERSHIP
if [[ ! $(grep --quiet '$CONF_DIR' /etc/passwd) ]]; then
  ### CREATE APPLICAITON USER
  echo "$USRN:x:$UID:$GID:$USRN,,,:$CONF_DIR:/bin/bash" >> /etc/passwd
  echo "$USRN:x:$GID:" >> /etc/group
  ### CREATE FETCH DIRECTORY
  mkdir -p $CONF_DIR/fetch
  ### ASSIGN VOLUME OWNERSHIP
  chown $UID:$GID -R $CONF_DIR
  chown $UID:$GID -R $USER_DIR
fi

### START SERVICE USING RUNTIME UID AND GID
exec su - $USRN -c "/usr/bin/transmission-daemon -f 2>&1" 2>/dev/null
