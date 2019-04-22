#!/bin/bash

# remove orphan containers
docker ps -a | grep -v ":" | awk '{print $1}' | xargs docker rm -f

# remove exited containers
docker ps -a | grep Exit | awk '{print $1}' | xargs docker rm -f

# To quickly remove any untagged containers (ones that show up as <none> <none> 
# when you run sudo docker images) you can run the following command:
docker images -q --filter "dangling=true" | xargs docker rmi

# remove orphan images
docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi -f