# docker-transmission
This is a user centric release of Transmission for Docker. When a user executes "install.sh" it automaticaly creates the mapped volumes in their home directory, assigns unused ports to the container, and runs the container proccess using their UID and GID giving them full ownership of any files created by the container process. Unlike other Transmission examples for Docker, this one is persistent even after being restarted, or rebuilt. Best of all it supports multiple isolated users!

This is still a "very alpha" release. Please check back for the finished project.

Persistent user directories:

~/.docker-transmission

~/downloads

## Requirements
-Debian/Ubuntu base OS (other flavors untested yet)

-Docker v1.6

-Installing user must be in "docker" group

## Install
Clone the project
> git clone https://github.com/Ohge/docker-transmission.git

Execute the build script
> ./install.sh

## Uninstall
> ./uninstall.sh

## Usage
Open your browser to start using the Transmission torrent client
> http://host:port

## Future releases
-Update dynamic bookmarks RSS file to users home dir during install and uninstall.

-Add a persistent blocklist downloader to install and start scripts.

-Switch to init.d daemon start/stop/reload methods, and "tail -f" the transmission log file as CMD.

-Add external scripts to users home dir that call "docker exec" the start/stop/reload commands.
