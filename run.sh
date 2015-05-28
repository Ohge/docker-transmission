#!/bin/bash

### RUN CONTAINER
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
docker run -d \
-v $DIR/torrents/incoming:/torrents/incoming \
-v $DIR/torrents/complete:/torrents/complete \
-p 9091:9091 \
svc/transmission
