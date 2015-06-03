# docker-transmission
This is a user centric release of Transmission for Docker. When a user executes "install.sh" it automaticaly creates the mapped volumes in their home directory, assigns unused ports to the container, and runs the container proccess using their UID and GID giving them full ownership of any files created by the container process. Unlike other Transmission examples for Docker, this one is persistent even after being restarted, or rebuilt. Best of all it support multiple isolated users!

Persistent user directories:

~/.docker-transmission

~/downloads

## Requirements

-Docker v1.6

-Installing user must be in "docker" group

## Installation
Clone the project
> git clone https://github.com/Ohge/docker-transmission.git

Execute the build script
> ./install.sh

## Uninstallation
> ./uninstall.sh

## Usage
Open your browser to start using the Transmission torrent client
> http://host:port

## Future releases
-Write dynamic bookmarks file to users home dir.

-Verify user is in docker group before install and uninstall.

-Authenticate using username:transmission credentials.

-Replace transmission web dir with username.
