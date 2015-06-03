FROM debian:jessie
MAINTAINER Ohge <https://github.com/Ohge>

### INSTALL DEPENDENCIES
RUN set -xe &&\
    apt-get update &&\
    apt-get install -y transmission-daemon

### CLEAN UP CONTAINER
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### CREATE PERSISTENT VOLUMES
VOLUME ["/etc/transmission-daemon"]
VOLUME ["/downloads"]

### EXPOSE PORTS
EXPOSE 9091
EXPOSE 54321
EXPOSE 54321/udp

### RUN SCRIPT
CMD ["/etc/transmission-daemon/transmission.sh"]
