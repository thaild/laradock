ARG PHP_VERSION=5.6

FROM php:${PHP_VERSION}-fpm-alpine

LABEL MAINTAINER="thaild <thai.le.connectiv@gmail.com>"

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
    intl bcmath mcrypt xsl zip soap mysqli pdo pdo_mysql pdo_pgsql gmp iconv gd     && \
    \
    docker-php-ext-configure opcache --enable-opcache                               && \
    docker-php-ext-install opcache                                                  && \
    \
    pecl install imagick xdebug                                                     && \
    docker-php-ext-enable imagick                                                   && \
    \
    sed -i -e 's/listen.*/listen = 0.0.0.0:9000/' /usr/local/etc/php-fpm.conf       && \
    echo "expose_php=0" > /usr/local/etc/php/php.ini                                && \
    \
    apk del .build-dependencies                                                     && \
    docker-php-source delete                                                        && \
    rm -rf /tmp/* /var/cache/apk/*

COPY conf.d/* /usr/local/etc/php/conf.d/

# INSTALL COMPOSER
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/ \
    && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install NPM
RUN apk add --update --no-cache bash nodejs nodejs-npm && rm -rf /var/cache/apk/*

RUN npm install -g yarn
