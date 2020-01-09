ARG PHP_VERSION=7.2

FROM php:${PHP_VERSION}-apache

LABEL MAINTAINER="thaild <thai.le.connectiv@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y --fix-missing                                 \
    apt-utils git libtool argon2 libargon2-0 libargon2-0-dev libzip-dev libpq-dev      \
    tini libmcrypt-dev libmemcached-dev libxslt-dev libmagickwand-dev libssh2-1-dev    \
    libgmp-dev                                                                      && \
    \
    docker-php-source extract                                                       && \
    \
    docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)"                            \
    bcmath calendar hash intl opcache pcntl shmop                                      \
    soap tokenizer xml xsl zip mysqli pdo pdo_mysql pdo_pgsql gmp iconv gd          && \
    \
    docker-php-ext-configure opcache --enable-opcache                               && \
    docker-php-ext-install opcache                                                  && \
    \
    pecl install apcu imagick ssh2-1 xdebug                                         && \
    \
    echo "expose_php=0" > /usr/local/etc/php/php.ini                                && \
    \
    docker-php-source delete                                                        && \
    apt-get autoremove -y                                                           && \
    rm -rf /tmp/* /var/cache/*

# Set the locale
RUN apt-get install locales locales-all -y && \
    locale-gen en_US.UTF-8 en_GB.UTF-8 es_ES.UTF-8 ja_JP.UTF-8 vi_VN UTF-8 zh_CN.UTF-8

# INSTALL COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install Laravel Envoy
RUN composer global require "laravel/envoy=~1.0"

# Install Nodejs NPM Yarn
RUN apt-get install sudo bash -y                                                                        && \
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -                                     && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -                              && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -y && apt-get install -y --no-install-recommends nodejs yarn

# Configure PHP for laravel
COPY conf.d/* /usr/local/etc/php/conf.d/

# Configure apache 
RUN a2enmod rewrite expires ssl headers proxy_http vhost_alias                      &&\
    echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf   &&\
    a2enconf servername

# Configure vhost 
# COPY vhosts/example72.conf /etc/apache2/sites-available/
# RUN a2dissite 000-default
# RUN a2ensite example72

WORKDIR /var/www/html

EXPOSE 80 443
