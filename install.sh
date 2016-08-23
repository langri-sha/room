#!/bin/sh

{
	curl -L https://raw.githubusercontent.com/langri-sha/room/master/run.sh -o /usr/local/bin/room
	chmod +x /usr/local/bin/room
} || {
	echo "Failed installing script. See https://github.com/langri-sha/room#room"
}
