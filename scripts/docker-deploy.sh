#!/usr/bin/env bash

LOCAL_IP=$(ifconfig eth0 | grep "inet addr:" | cut -d : -f 2 | cut -d " " -f 1)

echo "Start build baseline environment for Docker images"

cd /home/vagrant/docker-files/docker-redis

docker-compose up -d

docker-compose down --volumes

echo "Bootstrap redis cluster using docker Docker Swarm"

docker swarm init --advertise-addr $LOCAL_IP

# Other nodes can join this swarm cluster and this would easily 
# allow to deploy the multi-container application to a multi-host 
# as well. 

echo "Deploy the services defined in Compose file"

docker stack deploy --compose-file=docker-compose.yml stackdemo-cluster
