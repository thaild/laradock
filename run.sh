#!/usr/bin/env bash

DIR=$(pwd)
# echo $DIR

# RUN CHANGE PERMISSION 
echo 'CHANGED PERMISSION FOLDER STORAGE & BOOTSTRAP/CACHE'
chmod 777 -Rf $DIR/blog/bootstrap/cache $DIR/blog/storage

# BUILD CONTAINER
docker-compose -f develop.yml down && docker-compose -f develop.yml build

# COMPOSER
VENDER_FOLDER=$DIR
if [ -d "$VENDER_FOLDER/blog/vendor" ]; then  
    echo '==========================================================================='
    echo "UPDATE COMPOSER"
    echo '==========================================================================='
    docker run --rm -v $DIR/blog:/var/www/html $(docker images | grep "php-laravel" | awk '{print $1}'):latest /bin/bash -c "composer update"
else
    echo '==========================================================================='
    echo "INSTALL COMPOSE"
    echo '==========================================================================='
    docker run --rm -v $DIR/blog:/var/www/html $(docker images | grep "php-laravel" | awk '{print $1}'):latest /bin/bash -c "composer install"
fi

# CHECK FILE .ENV EXISTS
echo '==========================================================================='
echo "CHECK FILE .ENV"
echo '==========================================================================='
    if [[ -f "$DIR/blog/.env" ]]; then
            echo File .env is exists
    else
        echo Not found file .env!
        echo Copy file .env.develop to .env
        cp $DIR/.env.develop $DIR/.env
        echo Copy success..
    fi

# START CONTAINER 
echo '==========================================================================='
echo 'DOCKER START CONTAINER IN DEAMOND'
echo '==========================================================================='
docker-compose  -f develop.yml  up -d
