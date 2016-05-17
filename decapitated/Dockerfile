FROM langrisha/room:polyglot

ENV	\
	CHROME_BIN=/usr/bin/google-chrome \
	XVFB_ARGS="-ac -screen 0 1280x720x16 -nolisten tcp"

COPY xvfb-chromium /usr/bin/xvfb-chromium

RUN apt-get update && apt-get install -y --no-install-recommends \
		xvfb \
		chromium \
	&& rm -rf /var/lib/apt/lists/* \
	&& chmod +x /usr/bin/xvfb-chromium \
	&& ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome \
	&& ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser
