FROM langrisha/room:bikeshed

RUN \
	# nodejs; will run `apt-get update` for us
	curl -sL https://deb.nodesource.com/setup_6.x | bash - \

	&& apt-get install -y --no-install-recommends \
		nodejs \
		python \
		python-dev \
		python3-dev \
		python3 \
		python-setuptools \
		python3-setuptools \
		ruby \
		ruby-dev \
		golang \
	&& rm -rf /var/lib/apt/lists/* \

	&& easy_install pip \
	&& easy_install3 pip
