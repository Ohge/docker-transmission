FROM debian:jessie
MAINTAINER Ohge <chris.ohge@gmail.com>

### INSTALL DEPENDENCIES
RUN set -xe &&\
    apt-get update &&\
    apt-get install -y transmission-daemon

### CLEAN UP CONTAINER
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### CREATE CONTAINER USER AND GROUP
RUN set -xe &&\
    export uid=1000 gid=1000 && \
    mkdir -p /home/transmission/ && \
    echo "transmission:x:${uid}:${gid}:transmission,,,:/home/transmission:/bin/bash" >> /etc/passwd && \
    echo "transmission:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/transmission

### ASSUME USER IDENTITY
USER transmission
ENV HOME /home/transmission

### CREATE PERSISTENT VOLUME
VOLUME ["/etc/transmission-daemon"]

### EXPOSE PORTS
EXPOSE 9091
EXPOSE 54321

### RUN SCRIPT
CMD ["/etc/transmission-daemon/transmission.sh"]
