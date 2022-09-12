FROM php:7.4-fpm

RUN apt-get update \
    && apt-get install -y wget git unzip libpq-dev libicu-dev libpng-dev libzip-dev libjpeg-dev libfreetype6-dev\
    && pecl install xdebug-2.9.1 \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install zip \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install pgsql \
    && docker-php-ext-enable pgsql

#pdftk
RUN mkdir -p /usr/share/man/man1/ \
 && apt-get update \
 && apt-get install -y pdftk

ADD ./php.ini /usr/local/etc/php/php.ini

# composer
RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet

# Permissions
RUN chown -R www-data:www-data /var/www/ \
    && chgrp -R www-data /var/www/storage /var/www/bootstrap/cache \
    && chmod -R ug+rwx /var/www/storage /var/www/bootstrap/cache

WORKDIR /var/www
