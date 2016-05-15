# See: https://github.com/mark-adams/docker-chromium-xvfb

FROM langrisha/room:polyglot

ENV	CHROME_BIN /usr/bin/google-chrome

RUN apt-get update && apt-get install -y --no-install-recommends \
		xvfb \
		chromium \
	&& rm -rf /var/lib/apt/lists/*

COPY xvfb-chromium /usr/bin/xvfb-chromium
RUN \
	ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome \
	ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser
