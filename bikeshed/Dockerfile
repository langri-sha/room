FROM buildpack-deps:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
		apt-transport-https \
		build-essential \
		cmake \
		libtool-bin \
		lsb-release \
		locales \
		unzip \
	&& rm -rf /var/lib/apt/lists/* \

	&& locale-gen en_US.UTF-8 \
	&& dpkg-reconfigure locales \
	&& /usr/sbin/update-locale update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
