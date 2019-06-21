FROM php:7.3.6-fpm-alpine3.9

ENV TZ=Europe/Moscow

COPY php-ext.ini /usr/local/etc/php/conf.d/php-ext.ini
COPY docker.conf /usr/local/etc/php-fpm.d/docker.conf
COPY run.sh /run.sh

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apk add --no-cache --virtual .build-deps postgresql-dev git zlib-dev libmemcached-dev autoconf \
    && apk add libmemcached postgresql-libs \
    && docker-php-ext-install opcache pcntl pgsql mbstring \
    #
    && git clone -b php7 https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
    && cd /usr/src/php/ext/memcached \
    && git checkout v3.1.3 \
    && docker-php-ext-configure /usr/src/php/ext/memcached --disable-memcached-sasl \
    && docker-php-ext-install /usr/src/php/ext/memcached \
    && docker-php-ext-enable memcached \
    && rm -rf /usr/src/php/ext/memcached \
    #
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    #
    && docker-php-source delete \
    && chmod a+x /run.sh \
    && apk del .build-deps

ENTRYPOINT ["/run.sh"]
CMD ["php-fpm"]