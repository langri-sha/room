FROM langrisha/room:polyglot

ENV DISPLAY :99.0 \
	CHROME_BIN /usr/bin/google-chrome

RUN apt-get update && apt-get install -y --no-install-recommends \
		xvfb \
		chromium \
	&& rm -rf /var/lib/apt/lists/*

COPY xvfb.sh /etc/init.d/xvfb
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
