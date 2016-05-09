FROM langrisha/room:laputa

ENV \
	RCRC=/usr/local/lib/rcrc \
	TERM=xterm-256color \
	XDG_CONFIG_HOME=/root/.config

CMD ["/bin/zsh"]

RUN \
	neovim_tag=0.1.4 \

	# neovim
	&& git clone --depth 1 --branch v${neovim_tag} \
		https://github.com/neovim/neovim.git \
		/usr/local/lib/neovim \
	&& (cd /usr/local/lib/neovim; make; make install) \
	&& pip2 install neovim && pip3 install neovim \
	&& npm install -g \
		eslint \
		eslint-config-airbnb \
		eslint-loader \
		eslint-plugin-import \
		eslint-plugin-jsx-a11y \
		eslint-plugin-react \

	# rcm
	&& export rcm_version=1.3.0-1 \
	&& curl https://thoughtbot.github.io/rcm/debs/rcm_${rcm_version}_all.deb \
		-o /tmp/rcm.deb \
	&& rcm_sha=2e95bbc23da4a0b995ec4757e0920197f4c92357214a65fedaf24274cda6806d \
	sha=$(sha256sum /tmp/rcm.deb | cut -f1 -d' ') \
		[ "$sha" = "$rcm_sha" ] \
	&& dpkg -i /tmp/rcm.deb \
	&& rm /tmp/rcm.deb \


	# Goodies
	&& apt-get update && apt-get install -y --no-install-recommends \
		ack-grep \
		dnsutils \
		gdb \
		htop \
		iotop \
		lsof \
		mc \
		net-tools \
		rsync \
		siege \
		silversearcher-ag \
		socat \
		strace \
		tmux \
		vim \
		zsh \
	&& rm -rf /var/lib/apt/lists/* \

	&& pip3 install urwid \
	&& pip3 install sen

COPY rcrc /usr/local/lib/rcrc

RUN \
	# dotfiles
	git clone --depth 1 \
		https://github.com/thoughtbot/dotfiles.git \
		/usr/local/lib/thoughtbot-dotfiles \
	&& git clone --depth 1 \
		https://github.com/langri-sha/dotfiles.git \
		/usr/local/lib/langri-sha-dotfiles \

	# root user
	&& chsh -s /bin/zsh root \
	&& USER=root rcup -t nvim -t tmux -t zsh \
	&& TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/install_plugins \
		$HOME/.tmux/plugins/tpm/bin/install_plugins \
	&& nvim -c "call dein#install() | quit"
