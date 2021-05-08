FROM php:7.4-fpm-alpine

ARG VERSION=2.0.16
ARG FILENAME=webtrees-${VERSION}.zip
ARG URL=https://github.com/fisharebest/webtrees/releases/download/${VERSION}/${FILENAME}

RUN apk add --no-cache curl unzip php7-pdo_mysql php7-gd php7-pecl-imagick

RUN curl -sL "${URL}" > /tmp/webtrees.zip \
    && unzip /tmp/webtrees.zip -d /tmp \
    && rm /tmp/webtrees.zip \
    && mv /tmp/webtrees/* /var/www/html

RUN php -i
CMD ["php-fpm"]
