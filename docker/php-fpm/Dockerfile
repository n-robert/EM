FROM php:7.4-fpm

RUN apt-get update \
    && apt-get install -y wget git unzip libpq-dev libicu-dev libpng-dev libzip-dev libjpeg-dev libfreetype6-dev \
    && apt-get install -y libz-dev libmemcached-dev \
    && apt-get install -y memcached libmemcached-tools \
    && pecl install memcached \
    && pecl install xdebug-2.9.1 \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install zip \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install pgsql \
    && docker-php-ext-enable pgsql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql

#pdftk
RUN mkdir -p /usr/share/man/man1/ \
    && apt-get update \
    && apt-get install -y pdftk

ADD ./php.ini /usr/local/etc/php/php.ini

# composer
RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet

# npm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN /bin/bash -c 'chown -R www-data:www-data storage bootstrap/cache; chgrp -R www-data storage bootstrap/cache; chmod -R ug+rwx storage bootstrap/cache; composer install; npm install'

WORKDIR /var/www
