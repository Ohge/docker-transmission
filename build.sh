#!/bin/bash

### BUILD CONTAINER
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
docker build -t svc/transmission $DIR
