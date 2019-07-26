# Docker-compose for project laravel

## Apache
- iamges: httpd:2.4.33-alpine
- IP address: 172.20.0.89
- Please add to file hosts: 172.20.0.89     blog.com    example.com

## mysql 
- IP address: 172.20.0.3
- MYSQL_ROOT_PASSWORD: root
- MYSQL_USER: docker
- MYSQL_PASSWORD: docker
- MYSQL_DATABASE: docker

## php
- This container build base docker-images: `php:7.x-fpm-alpine`  
### This container Installed:
 - Composer
 - npm
 - yarn
 - and more extension php, check extension available: `php -m`
 
 **read more about php-extension** [here](https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions)
 
# Enjoy it!