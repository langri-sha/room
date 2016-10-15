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
PERMISSIONS="-e USER=$USER -e GROUP=$(getent group `id -g $USER` | cut -d: -f1) -u $(id -u $USER):$(id -g $USER)"

# Volumize current directory.
VOLUMES="-v $(pwd):/mnt/$(pwd)"

# Volumize X11 socket if present.
if [ -f /tmp/.X11.sock ]; then
  VOLUMES="$VOLUMES -v /tmp/.X11.sock:/tmp/.X11.sock"
fi

exec docker run --rm -ti $DOCKER_ADDR $PERMISSIONS $VOLUMES -w /mnt/$(pwd) langrisha/room $@
