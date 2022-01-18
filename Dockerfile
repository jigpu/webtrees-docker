FROM hermsi/alpine-fpm-php:7.4

ARG VERSION=2.0.19
ARG FILENAME=webtrees-${VERSION}.zip
ARG URL=https://github.com/fisharebest/webtrees/releases/download/${VERSION}/${FILENAME}

RUN apk add --no-cache curl unzip imagemagick

RUN curl -sL "${URL}" > /tmp/webtrees.zip \
    && unzip /tmp/webtrees.zip -d /tmp \
    && rm /tmp/webtrees.zip \
    && mv /tmp/webtrees/* /var/www/html

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

COPY php.ini /usr/local/etc/php/

WORKDIR /var/www/html
ENTRYPOINT ["/docker-entrypoint.sh"]
