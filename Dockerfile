FROM debian:jessie

WORKDIR /work

CMD ["/bin/zsh"]

RUN \
	# Pre-requisites.
	apt-get update && apt-get install -y \
		apt-transport-https \
		build-essential \
		cmake \
		curl \
		libpcre3-dev \
		lsb-release \
		wget && \

	# RCM
	export rcm_version=1.3.0-1 && \
	wget https://thoughtbot.github.io/rcm/debs/rcm_${rcm_version}_all.deb && \
	rcm_sha=2e95bbc23da4a0b995ec4757e0920197f4c92357214a65fedaf24274cda6806d \
	sha=$(sha256sum rcm_${rcm_version}_all.deb | cut -f1 -d' ') \
		[ "$sha" = "$rcm_sha" ] &&\
	dpkg -i rcm_${rcm_version}_all.deb && \
	rm rcm_${rcm_version}_all.deb && \

	# wercker
	curl https://s3.amazonaws.com/downloads.wercker.com/cli/stable/linux_amd64/wercker \
		-o /usr/local/bin/wercker && \
	chmod +x /usr/local/bin/wercker && \

	# docker-engine
	apt-key adv \
		--keyserver hkp://p80.pool.sks-keyservers.net:80 \
		--recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
	echo "deb https://apt.dockerproject.org/repo debian-jessie main" \
		| tee /etc/apt/sources.list.d/docker.list && \

	# gcloud
	cloud_sdk_repo=cloud-sdk-`lsb_release -c -s` && \
	echo "deb http://packages.cloud.google.com/apt $cloud_sdk_repo main" \
		| tee /etc/apt/sources.list.d/google-cloud-sdk.list && \
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
		| apt-key add - && \

	# heroku-toolbelt
	echo "deb http://toolbelt.heroku.com/ubuntu ./" \
		| tee /etc/apt/sources.list.d/heroku.list && \
	curl https://toolbelt.heroku.com/apt/release.key \
		| apt-key add - && \

	# nodejs
	curl -sL https://deb.nodesource.com/setup_5.x | bash - && \

	apt-get update && apt-get install -y \
		# Goodies
		ack-grep \
		git \
		golang \
		htop \
		net-tools \
		python \
		ruby \
		tmux \
		vim \
		nodejs \
		zsh \

		# Cloud
		docker-engine \
		google-cloud-sdk \
		heroku-toolbelt
