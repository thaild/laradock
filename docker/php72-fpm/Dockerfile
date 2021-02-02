ARG PHP_VERSION=7.2

FROM php:${PHP_VERSION}-fpm

LABEL MAINTAINER="thaild <thai.le.connectiv@gmail.com>"

# Install dependencies
RUN apt-get update && apt-get install -y --fix-missing apt-utils                       \
    git libtool argon2 libargon2-0 libargon2-0-dev libzip-dev libpq-dev libgmp-dev     \
    tini libmcrypt-dev libmemcached-dev libxslt-dev libmagickwand-dev libssh2-1-dev && \
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
    docker-php-source delete                                                        && \
    rm -rf /tmp/* /var/cache/*

COPY conf.d/* /usr/local/etc/php/conf.d/

# INSTALL COMPOSER
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/ \
    && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install Laravel Envoy
# CLI to Check For PHP Security Vulnerabilities
RUN composer global require laravel/envoy enlightn/security-checker

# Install Nodejs NPM Yarn
RUN apt-get install sudo bash -y                                                                        && \
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -                                     && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -                              && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
    
RUN apt-get update -y && apt-get install -y --no-install-recommends nodejs yarn

# Install locales
RUN apt-get install locales locales-all -y && \
    locale-gen en_US.UTF-8 en_GB.UTF-8 ja_JP.UTF-8 vi_VN UTF-8 zh_CN.UTF-8

# Set locales
# https://github.com/lau/tzdata/blob/master/test/tzdata_fixtures/source_data/asia#L1434
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN ls /usr/share/zoneinfo/Asia
RUN echo "Asia/Tokyo" >  /etc/timezone

ENV TZ Asia/Tokyo
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
