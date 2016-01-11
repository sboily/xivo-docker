Dockerfile for XiVO

Please note this is only a POC for playing with docker.

## Install Docker

To install docker on Linux :

    curl -sL https://get.docker.io/ | sh
 
 or
 
     wget -qO- https://get.docker.io/ | sh

## Build

To build the image, simply invoke

    docker build -t xivo-docker github.com/sboily/xivo-docker

A prebuilt container is also available in the docker index

    docker pull quintana/xivo-docker
  
## Usage

To run the container, do the following:

    docker run -d -P xivo-docker

or

    docker run -d -P quintana/xivo-docker
    
On interactive mode :

    docker run -i -t quintana/xivo-docker /bin/bash

or

    docker run -i -t  xivo-docker /bin/bash

After launch xivo-service in /root directory.

    cd /root
    ./xivo-service

## Infos

- Using docker version 0.11.1 (from get.docker.io) on ubuntu 14.04.
- The root password is xivo by default.
- If you want to using a simple webi to administrate docker use : https://github.com/crosbymichael/dockerui

To get the IP of your container use :

    docker ps -a
    docker inspect <container_id> | grep IPAddress | awk -F\" '{print $4}'
