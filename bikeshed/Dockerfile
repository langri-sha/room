# Preamble image. First, we built a bikeshed so there's a place we can think of
# as coming to work.

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

	# Use geographical mirrors.
	&& sed -i -- 's/http:\/\/deb/http:\/\/httpredir/g' /etc/apt/sources.list \
	&& echo /etc/apt/sources.list \

	# Configure 'jessie' as default release.
	&& echo 'APT::Default-Release "jessie";' \
		| tee /etc/apt/apt.conf.d/99preferjessie \

	# Pin packages from testing source to a lower priority.
	&& echo '\
	Package: *\n\
	Pin: release a=testing,a=testing/main \n\
	Pin-Priority: 100' \
		| tee /etc/apt/preferences.d/testing \

	# Add source for testing packages.
	&& echo '\
	deb http://httpredir.debian.org/debian testing main\n' \
		| tee /etc/apt/sources.list.d/testing.list \

	# Add base packages.
	&& apt-get update && apt-get install -y apt-utils \
	&& apt-get install -y -qq --no-install-recommends \
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

	# Confgiure locale.
	&& locale-gen en_US.UTF-8 \
	&& dpkg-reconfigure locales \
	&& /usr/sbin/update-locale update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV \
	LANG='en_US.UTF-8' \
	LANGUAGE='en_US:en' \
	LC_ALL='en_US.UTF-8'
