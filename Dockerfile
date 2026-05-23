 ## debian-bookworm
FROM node:22-bookworm-slim

## Install x11 dependencies
RUN \
  DEBIAN_FRONTEND= && \
  apt update && \
  apt install --no-install-recommends -y \
    curl \
    xvfb \
    xauth \
    x11vnc \
    fluxbox \
    supervisor \
    gettext \
    novnc \
    procps

## Add node files
ADD ${PWD}/app/. /app/.

## Install node dependencies
WORKDIR /app
RUN \
  npm install && \
  npx playwright install && \
  npx playwright install chromium --with-deps

# Add supervisord config
ADD ${PWD}/supervisord.conf /etc/supervisord.conf.template
ADD ${PWD}/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

## Cleanup
RUN \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /tmp/* /var/tmp/*

WORKDIR /app
EXPOSE 3000

# Entrypoint
#ENTRYPOINT ["/entrypoint.sh"]
CMD ["npm", "start"]