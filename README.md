Dockerfile for XiVO

## Warning

This dockerfile is not working for the moment because Docker support 64 bits guest. Working when XiVO 64 bits are ready.

## Build

To build the image, simply invoke

    docker.io build github.com/sboily/xivo-docker

A prebuilt container is also available in the docker index

    docker.io pull quintana/xivo-docker
  
## Usage

To run the container, do the following:

    docker.io run -d -P quintana/xivo-docker

If you want to using a simple webi to administrate docker use : https://github.com/crosbymichael/dockerui
