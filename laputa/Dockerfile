FROM langrisha/room:polyglot
RUN \
	# docker-engine
	apt-key adv \
		--keyserver hkp://p80.pool.sks-keyservers.net:80 \
		--recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
	&& echo "deb https://apt.dockerproject.org/repo debian-jessie main" \
		| tee /etc/apt/sources.list.d/docker.list \

	# docker-compose
	&& pip install docker-compose \

	# wercker
	&& curl https://s3.amazonaws.com/downloads.wercker.com/cli/stable/linux_amd64/wercker \
		-o /usr/local/bin/wercker \
	&& chmod +x /usr/local/bin/wercker \

	# gcloud
	&& cloud_sdk_repo="cloud-sdk-$(lsb_release -c -s)" \
	&& echo "deb http://packages.cloud.google.com/apt $cloud_sdk_repo main" \
		| tee /etc/apt/sources.list.d/google-cloud-sdk.list \
	&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
		| apt-key add - \

	# heroku-toolbelt
	&& echo "deb http://toolbelt.heroku.com/ubuntu ./" \
		| tee /etc/apt/sources.list.d/heroku.list \
	&& curl https://toolbelt.heroku.com/apt/release.key \
		| apt-key add - \

	&& apt-get update && apt-get install -y --no-install-recommends \
		docker-engine \
		google-cloud-sdk \
		heroku-toolbelt \
	&& rm -rf /var/lib/apt/lists/* \

	# Finish installing heroku-toolbelt.
	&& heroku
