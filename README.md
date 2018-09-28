# Docker-compose for project laravel

## Apache <-> PHP <-> MySQL 

- Change path to your source code of project laravel at `volumes` of service `php-laravel` to mount source code to container.

- example: `- ./laravel.dev:/var/www/html/example.com`

**if need change conf virtual host**
- Change conf here: ./docker/httpd-alpine/conf/virtual-vhosts/example.conf

### blog.com [website laravel default for this Repo]
- Mounted source code into folder `blog` to `blog.com` in container

### Adminer
- Replace for phpmyadmin
- Access on browser: [http://blog.com/adminer.php](https://github.com/thaild/laravel-docker/blob/master/blog/public/adminer.php)


# Information:

## httpd [172.20.0.89:80]
- Please change file hosts: 172.20.0.89     blog.com    example.com

## mysql [172.20.0.3:3306]
- MYSQL_ROOT_PASSWORD: root
- MYSQL_USER: docker
- MYSQL_PASSWORD: docker
- MYSQL_DATABASE: docker

** This container running with user:guid 1000:1000
** If run container with error permission deny please change folder `./docker/database` to 1000:1000 
`Example:# sudo chown -Rf 1000:1000 docker/database`

## php [172.20.0.70:9000]
- This container build base docker-images: `php:7.0-fpm-alpine`  
### This container Installed:
 - Composer
 - npm
 - yarn
 - and more extension php, check extension available: `php -m`
 
 **read more about php-extension** [here](https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions)
 
 # Enjoy it!