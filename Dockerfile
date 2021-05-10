FROM hermsi/alpine-fpm-php:7.4

ARG VERSION=2.0.16
ARG FILENAME=webtrees-${VERSION}.zip
ARG URL=https://github.com/fisharebest/webtrees/releases/download/${VERSION}/${FILENAME}

RUN apk add --no-cache curl unzip
#RUN mkdir -p /var/www/html

RUN curl -sL "${URL}" > /tmp/webtrees.zip \
    && unzip /tmp/webtrees.zip -d /tmp \
    && rm /tmp/webtrees.zip \
    && mv /tmp/webtrees/* /var/www/html

#RUN apk add --no-cache \
#    php7 \
#    php7-fpm \
#    php7-pdo_mysql \
#    php7-gd \
#    php7-pecl-imagick \
#    php7-exif \
#    php7-intl \
#    php7-zip \
#    pcre2

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

#RUN cp /etc/php7/conf.d/* /usr/local/etc/php/conf.d
COPY php.ini /usr/local/etc/php/
#COPY php.ini /etc/php7/


WORKDIR /var/www/html
ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["/usr/local/sbin/php-fpm"]
