FROM debian:jessie
MAINTAINER Ohge <chris.ohge@gmail.com>

### INSTALL DEPENDENCIES
RUN set -xe &&\
    apt-get update &&\
    apt-get install -y transmission-daemon

### CLEAN UP CONTAINER
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### CREATE PERSISTENT VOLUME
VOLUME ["/home/transmission"]

### EXPOSE PORTS
EXPOSE 9091
EXPOSE 54321

### RUN SCRIPT
CMD ["/home/transmission/transmission.sh"]
