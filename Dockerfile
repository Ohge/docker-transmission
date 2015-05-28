FROM debian:jessie
MAINTAINER Ohge <chris.ohge@gmail.com>

### INSTALL DEPENDENCIES
RUN set -xe &&\
    apt-get update &&\
    apt-get install -y transmission-daemon

### IMPORT LOCAL CONFIG
ADD settings.json /etc/transmission-daemon/settings.json

### CLEAN UP CONTAINER
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### CREATE PERSISTENT VOLUMES
VOLUME ["/torrents/incoming/"]
VOLUME ["/torrents/complete/"]

### EXPOSE PORT
EXPOSE 9091

### RUN SCRIPT
CMD ["/usr/bin/transmission-daemon", "-f", "-g", "/etc/transmission-daemon/"]
