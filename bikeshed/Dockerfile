FROM buildpack-deps:jessie

ENV \
	DEBIAN_FRONTEND=noninteractive \
	DEBCONF_NONINTERACTIVE_SEEN=true

RUN \
	echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
	&& echo 'locales locales/default_environment_locale select en_US.UTF-8' \
		| debconf-set-selections \
	&& echo 'locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8' \
		| debconf-set-selections \

	&& apt-get update && apt-get install -y -qq --no-install-recommends \
		apt-transport-https \
		build-essential \
		cmake \
		libtool-bin \
		lsb-release \
		locales \
		unzip \
		libappindicator1 \
		fuse \
	&& rm -rf /var/lib/apt/lists/* \

	&& locale-gen en_US.UTF-8 \
	&& dpkg-reconfigure locales \
	&& /usr/sbin/update-locale update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV \
	LANG='en_US.UTF-8' \
	LANGUAGE='en_US:en' \
	LC_ALL='en_US.UTF-8' \
