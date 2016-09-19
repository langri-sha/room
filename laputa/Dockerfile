FROM langrisha/room:polyglot
RUN \
	# keybase
	keybase=keybase_amd64.deb && \
	apt-get update && \
	curl -O https://prerelease.keybase.io/$keybase && \
	dpkg -i $keybase && \
	apt-get install -f && \
	rm $keybase && \

	# letsencrypt
	letsencrypt=/usr/local/lib/letsencrypt \
	&& mkdir -p $letsencrypt \
	&& git clone https://github.com/letsencrypt/letsencrypt $letsencrypt \
	&& ln -s $letsencrypt/letsencrypt-auto /usr/local/bin \

	# docker-engine
	&& apt-key adv \
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

	# travis-ci
	&& gem install travis \

	# terraform
	&& curl -O https://keybase.io/hashicorp/key.asc \
	&& gpg --with-fingerprint key.asc | grep "91A6 E7F8 5D05 C656 30BE  F189 5185 2D87 348F FC4C" \
	&& gpg --import key.asc \
	&& terraform_version=0.7.3 \
	&& terraform_prefix=terraform_${terraform_version} \
	&& terraform_url=https://releases.hashicorp.com/terraform/${terraform_version}/${terraform_prefix} \
	&& curl -O ${terraform_url}_linux_amd64.zip \
	&& curl -O ${terraform_url}_SHA256SUMS \
	&& curl -O ${terraform_url}_SHA256SUMS.sig \
	&& gpg --verify ${terraform_prefix}_SHA256SUMS.sig ${terraform_prefix}_SHA256SUMS \
	&& shasum -a 256 -c ${terraform_prefix}_SHA256SUMS \
		| grep "linux_amd64.zip: OK" \
	&& unzip ${terraform_prefix}_linux_amd64.zip -d .\
	&& cp terraform /usr/local/bin \
	&& chmod +x $_\

	&& apt-get update && apt-get install -y --no-install-recommends \
		docker-engine \
		ftp \
		google-cloud-sdk \
		heroku-toolbelt \
	&& rm -rf /var/lib/apt/lists/* \

	# Finish installing heroku-toolbelt.
	&& heroku --version
