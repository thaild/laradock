ARG PHP_VERSION=7.2

FROM php:${PHP_VERSION}-fpm-alpine

LABEL MAINTAINER="thaild <thai.le.connectiv@gmail.com>"

# Install dependencies
RUN apk update && apk upgrade                                                      && \
    docker-php-source extract                                                      && \
    apk add --no-cache --virtual .build-dependencies                                  \
    $PHPIZE_DEPS                                                                      \
    zlib-dev cyrus-sasl-dev git curl autoconf  g++ gcc libtool make pcre-dev       && \
    \
    apk add --no-cache                                                                 \
    tini libintl icu icu-dev libxml2-dev postgresql-dev freetype-dev libssh2           \
    libssh2-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev gmp gmp-dev                 \
    libmemcached-dev imagemagick-dev   libxslt-dev libmcrypt-dev                    && \
    \
    docker-php-ext-configure gd                                                        \
    --with-freetype-dir=/usr/include/                                                  \
    --with-jpeg-dir=/usr/include/                                                  &&  \
    \
    docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)"                            \
    intl bcmath xsl zip soap mysqli pdo pdo_mysql pdo_pgsql gmp iconv gd exif       && \
    \
    docker-php-ext-configure opcache --enable-opcache                               && \
    docker-php-ext-install opcache pcntl                                            && \
    \
    pecl install apcu imagick ssh2-1 xdebug                                         && \
    docker-php-ext-enable apcu imagick ssh2 xdebug                                  && \
    \
    sed -i -e 's/listen.*/listen = 0.0.0.0:9000/' /usr/local/etc/php-fpm.conf       && \
    echo "expose_php=0" > /usr/local/etc/php/php.ini                                && \
    \
    apk del .build-dependencies                                                     && \
    docker-php-source delete                                                        && \
    rm -rf /tmp/* /var/cache/apk/*

COPY conf.d/* /usr/local/etc/php/conf.d/

# INSTALL COMPOSER
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin/ --filename=composer

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install Laravel Envoy
# CLI to Check For PHP Security Vulnerabilities
RUN composer --version && composer self-update
RUN composer global require laravel/envoy enlightn/security-checker

# Install locales
RUN apk add --update --no-cache tzdata && rm -rf /var/cache/apk/*

# Set locales
# https://github.com/lau/tzdata/blob/master/test/tzdata_fixtures/source_data/asia#L1434
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN ls /usr/share/zoneinfo/Asia
RUN echo "Asia/Tokyo" >  /etc/timezone

ENV TZ Asia/Tokyo
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

# Install NPM
RUN apk add --update --no-cache bash nodejs nodejs-npm && rm -rf /var/cache/apk/*

RUN npm install -g yarn
