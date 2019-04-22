#!/bin/bash

# Usage: ./check-docker-container.sh _container_id_
#
# The script checks if a container is running.
#   OK - running
#   WARNING - container is ghosted
#   CRITICAL - container is stopped
#   UNKNOWN - does not exist

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Usage: ./check-docker-container.sh _container_id_"
fi

#
# The script checks if a container is running.
#   OK - running
#   WARNING - container is ghosted
#   CRITICAL - container is stopped
#   UNKNOWN - does not exist

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

CONTAINER=$1

RUNNING=$(sudo docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "UNKNOWN - $CONTAINER does not exist."
  exit -1
fi

if [ "$RUNNING" == "false" ]; then
  echo "CRITICAL - $CONTAINER is not running."
  exit 2
fi

GHOST=$(sudo docker inspect --format="{{ .State.Ghost }}" $CONTAINER)

if [ "$GHOST" == "true" ]; then
  echo "WARNING - $CONTAINER has been ghosted."
  exit 1
fi

STARTED=$(sudo docker inspect --format="{{ .State.StartedAt }}" $CONTAINER)
NETWORK=$(sudo docker inspect --format="{{ .NetworkSettings.IPAddress }}" $CONTAINER)

echo "OK - $CONTAINER is running. IP: $NETWORK, StartedAt: $STARTED"
exit 0
    exit 1
fi

CONTAINER=$1

RUNNING=$(sudo docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "UNKNOWN - $CONTAINER does not exist."
  exit -1
fi

if [ "$RUNNING" == "false" ]; then
  echo "CRITICAL - $CONTAINER is not running."
  exit 2
fi

GHOST=$(sudo docker inspect --format="{{ .State.Ghost }}" $CONTAINER)

if [ "$GHOST" == "true" ]; then
  echo "WARNING - $CONTAINER has been ghosted."
  exit 1
fi

STARTED=$(sudo docker inspect --format="{{ .State.StartedAt }}" $CONTAINER)
NETWORK=$(sudo docker inspect --format="{{ .NetworkSettings.IPAddress }}" $CONTAINER)

echo "OK - $CONTAINER is running. IP: $NETWORK, StartedAt: $STARTED"
exit 0