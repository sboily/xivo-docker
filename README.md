Dockerfile for XiVO

## Build

To build the image, simply invoke

    docker.io build -t xivo-docker github.com/sboily/xivo-docker

A prebuilt container is also available in the docker index

    docker.io pull quintana/xivo-docker
  
## Usage

To run the container, do the following:

    docker.io run -d -P xivo-docker

or

    docker.io run -d -P quintana/xivo-docker

On interactive mode :

    docker.io run -i -t quintana/xivo-docker /bin/bash

or

    docker.io run -i -t  xivo-docker /bin/bash

After launch xivo-service in /root directory.

    cd /root
    ./xivo-service

## Infos

- Using docker version 9.1 on ubuntu 14.04.
- The root password is xivo by default.
- To get the IP of your container use :

    docker.io inspect <container_id> | grep IPAddress | awk -F\" '{print $4}'

- If you want to using a simple webi to administrate docker use : https://github.com/crosbymichael/dockerui
