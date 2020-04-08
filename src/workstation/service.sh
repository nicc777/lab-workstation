#!/bin/sh

# Start the SSH service. The status info will be available with `docker container logs workstation` command issued on the host
service ssh start
service ssh status

# Start any other service you need to here...

while true
do
    echo `date` ALIVE
    sleep 5
done
