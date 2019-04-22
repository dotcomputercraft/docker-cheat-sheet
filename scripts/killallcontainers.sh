#!/usr/bin/env bash

docker stop $(sudo docker ps -a -q) 2>/dev/null

if [ -d /data ]; then
   	echo "directory /data exists."
	rm -fr /data
else
   echo "directory /data does not exist."
fi
