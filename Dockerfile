FROM php:7.4-fpm-alpine

ARG VERSION=2.0.16
ARG FILENAME=webtrees-${VERSION}.zip
ARG URL=https://github.com/fisharebest/webtrees/releases/download/${VERSION}/${FILENAME}

RUN apk add --no-cache \
    curl \
    unzip \
    php7-pdo_mysql \
    php7-gd \
    php7-pecl-imagick \
    php7-exif \
    php7-intl \
    php7-zip \
    pcre2

RUN curl -sL "${URL}" > /tmp/webtrees.zip \
    && unzip /tmp/webtrees.zip -d /tmp \
    && rm /tmp/webtrees.zip \
    && chown -R www-data:www-data /tmp/webtrees \
    && mv /tmp/webtrees/* /var/www/html

RUN cp /etc/php7/conf.d/* /usr/local/etc/php/conf.d

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

COPY php.ini /usr/local/etc/php/


WORKDIR /var/www/html
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["php-fpm"]
