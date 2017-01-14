#!/bin/sh
#
# Starts `langrisha/room` in the working directory.
#
# See:
# - https://github.com/langri-sha/room

set -e

uid=$(id -u)

# Setup options for connecting to docker host.
if [ -z "$DOCKER_HOST" ]; then
    DOCKER_HOST="/var/run/docker.sock"
fi
if [ -S "$DOCKER_HOST" ]; then
    DOCKER_ADDR="-v $DOCKER_HOST:$DOCKER_HOST:rw -e DOCKER_HOST"
else
    DOCKER_ADDR="-e DOCKER_HOST -e DOCKER_TLS_VERIFY -e DOCKER_CERT_PATH"
fi

# Volumize current directory.
VOLUMES="-v $(pwd):/mnt/$(pwd)"

# Volumize X11 socket if present.
if [ -f /tmp/.X11.sock ]; then
  VOLUMES="$VOLUMES -v /tmp/.X11.sock:/tmp/.X11.sock"
fi

# For root users, the image is already configured, so we simply run it.
if [ "$uid" -eq "0" ]; then
	exec docker run --rm -ti $DOCKER_ADDR $VOLUMES -w /mnt/$(pwd) langrisha/room $@
	exit
fi

# For non-root users, we dynamically create an image if one does not exist with
# the current user and group provisioned.

gid=$(id -g)
key=$uid:$gid
group=$(getent group `id -g` | cut -d: -f1)
user=$(getent user `id -u` | cut -d: -f1)

# For non-root users, we dynamically create an image with the user provisioned therein.
exec docker run $DOCKER_ADDR langrisha/room -u 0 useradd --skel /root -u $uid $user

# Configure container permissions.
PERMISSIONS="-u ${uid}:${gid}"
