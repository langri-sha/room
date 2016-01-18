FROM debian:jessie

ENV \
	RCRC=/usr/local/lib/rcrc \
	TERM=xterm

CMD ["/bin/zsh"]

RUN \
	neovim_tag=0.1.1 && \

	# Pre-requisites.
	apt-get update && apt-get install -y \
		apt-transport-https \
		autoconf \
		automake \
		build-essential \
		cmake \
		cmake \
		curl \
		g++ \
		git \
		libpcre3-dev \
		libtool \
		libtool-bin \
		lsb-release \
		pkg-config \
		pkg-config \
		python-setuptools \
		python3-setuptools \
		unzip && \

	# neovim
	git clone --depth 1 --branch v${neovim_tag} \
		https://github.com/neovim/neovim.git \
		/usr/local/lib/neovim && \
	(cd /usr/local/lib/neovim; make; make install) && \

	# rcm
	export rcm_version=1.3.0-1 && \
	curl https://thoughtbot.github.io/rcm/debs/rcm_${rcm_version}_all.deb \
		-o /tmp/rcm.deb && \
	rcm_sha=2e95bbc23da4a0b995ec4757e0920197f4c92357214a65fedaf24274cda6806d \
	sha=$(sha256sum /tmp/rcm.deb | cut -f1 -d' ') \
		[ "$sha" = "$rcm_sha" ] && \
	dpkg -i /tmp/rcm.deb && \
	rm /tmp/rcm.deb && \

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

	# nodejs; will run `apt-get update` for us
	curl -sL https://deb.nodesource.com/setup_5.x | bash - && \

	apt-get update && apt-get install -y \
		# Goodies
		ack-grep \
		dnsutils \
		gdb \
		golang \
		htop \
		iotop \
		lsof \
		net-tools \
		nodejs \
		python \
		python3 \
		ruby \
		siege \
		socat \
		strace \
		tmux \
		vim \
		wget \
		zsh \

		# Cloud
		docker-engine \
		google-cloud-sdk \
		heroku-toolbelt && \

	# pip
	easy_install pip && \
	easy_install3 pip && \

	# docker-compose
	pip install docker-compose

COPY rcrc /usr/local/lib/rcrc

RUN \
	# dotfiles
	git clone --depth 1 \
		https://github.com/thoughtbot/dotfiles.git \
		/usr/local/lib/thoughtbot-dotfiles && \
	git clone --depth 1 \
		https://github.com/langri-sha/dotfiles.git \
		/usr/local/lib/langri-sha-dotfiles && \

	# root user
	chsh -s /bin/zsh root && \
	USER=root rcup
