#!/bin/sh
#
# Starts `langrisha/room` in the working directory.
#
# See:
# - https://github.com/langri-sha/room

set -e

# Setup options for connecting to docker host.
if [ -z "$DOCKER_HOST" ]; then
    DOCKER_HOST="/var/run/docker.sock"
fi
if [ -S "$DOCKER_HOST" ]; then
    DOCKER_ADDR="-v $DOCKER_HOST:$DOCKER_HOST:rw -e DOCKER_HOST"
else
    DOCKER_ADDR="-e DOCKER_HOST -e DOCKER_TLS_VERIFY -e DOCKER_CERT_PATH"
fi

# Configure container permissions.
PERMISSIONS="-e USER=$USER -u $(id -u $USER):$(id -g $USER)"

# Setup volume mounts.
VOLUMES="-v $(pwd):$(pwd)"

exec docker run --rm -ti $DOCKER_ADDR $PERMISSIONS $VOLUMES -w /mnt/$(pwd) room $@
