# Docker-compose for project laravel

### (MySQL+PHP+Adminer+Apache)

- Change path to source code of project at `volumes` of service `php-laravel` to mount source code to container.

- example: `- ./laravel.dev:/var/www/html/example.com`

**if change conf virtual host**
- conf here: ./docker/httpd-alpine/conf/virtual-vhosts/example.conf

### blog.com [Website default for repo]
- Mounted source code into folder `blog` to `blog.com` in container

### Adminer
- phpmyadmin


# Information:

## Apache [172.20.0.89:80]
- Please change file hosts: 172.20.0.89     blog.com

## Mysql [172.20.0.3:3306]
- MYSQL_ROOT_PASSWORD: root
- MYSQL_USER: docker
- MYSQL_PASSWORD: docker
- MYSQL_DATABASE: docker

## php-laravel [172.20.0.70:9000]
- 