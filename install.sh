#!/bin/sh
{
	curl -L https://raw.githubusercontent.com/langri-sha/room/master/run.sh -o /usr/local/bin/room && \
	chmod +x /usr/local/bin/room && \
	printf "\nSuccessfullya installed 'room' command.\n\n"
} || {
	sudo curl -L https://raw.githubusercontent.com/langri-sha/room/master/run.sh -o /usr/local/bin/room && \
	sudo chmod +x /usr/local/bin/room && \
	printf "\nSuccessfully installed 'room' command.\n"
} || {
	printf "\nFailed installing room command. See https://github.com/langri-sha/room#room for more options\n"
}
