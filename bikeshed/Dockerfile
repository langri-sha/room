FROM buildpack-deps:jessie

ENV LC_ALL=en_US.UTF-8 \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
		apt-transport-https \
		build-essential \
		cmake \
		libtool-bin \
		lsb-release \
		unzip \
	&& rm -rf /var/lib/apt/lists/*
