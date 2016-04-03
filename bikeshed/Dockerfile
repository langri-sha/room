FROM buildpack-deps:jessie

RUN apt-get install -y --no-install-recommends \
		apt-transport-https \
		build-essential \
		cmake \
		libtool-bin \
		lsb-release \
		unzip \
	&& rm -rf /var/lib/apt/lists/*
