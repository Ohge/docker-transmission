#!/bin/bash
set -xe

CONFIG_DIR=/etc/transmission-daemon/
DEF_SETTINGS=$CONFIG_DIR/settings.json.default
USR_SETTINGS=$CONFIG_DIR/settings.json

### MANAGE CONFIGS
if [[ ! -f $USR_SETTINGS ]]; then cp $DEF_SETTINGS $USR_SETTINGS; fi

### START SERVICE
exec /usr/bin/transmission-daemon -f -g $CONFIG_DIR
