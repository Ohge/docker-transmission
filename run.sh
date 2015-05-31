#!/bin/bash

### RUN CONTAINER USING CURRENT USER UID AND GID
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
HOME="$(getent passwd $USER | awk -F ':' '{print $6}')"
docker run -d \
-e UID=$( id -u $(whoami) ) \
-e GID=$( id -g $(whoami) ) \
-v $DIR/transmission:/home/transmission \
-p 9091:9091 \
-p 54321:54321 \
svc/transmission
