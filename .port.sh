#!/bin/bash

### CHECK FOR VALID ARGS
if [ "$#" -ne 1 ]; then echo "Usage: d-port [PORT]"; exit 1; fi
if [[ $1 =~ [a-z]+ ]]; then echo "Usage: d-port [PORT]"; exit 1; fi
PORT=$1

### VERIFY PORT IS LEGAL
read LOW HIGH < /proc/sys/net/ipv4/ip_local_port_range
if [ $PORT -gt $HIGH ]; then
   echo "Port must be less than $HIGH"; exit 1
fi

### CHECK FOR NEXT AVAILABLE PORT
NEXT=1
while [[ "$NEXT" -gt 0 ]]; do
  INUSE=$[1-$(nc -z 127.0.0.1 $PORT; echo $?)]
  INRES=$(docker ps -a | grep ':' | awk '{print $NF}' | xargs --no-run-if-empty docker inspect | grep HostPort | sort -u | awk -F '"' '{ print $4 }' | grep -c $PORT)
  NEXT=$[INUSE+INRES]
  [ $NEXT -gt 0 ] && PORT=$[PORT+1]
done

### PRINT RESULT
echo "$PORT"
exit 0
