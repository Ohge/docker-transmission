#!/bin/bash

### RUN CONTAINER
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
docker run -d \
-v $DIR/transmission:/etc/transmission-daemon \
-p 9091:9091 \
-p 54321:54321 \
svc/transmission
