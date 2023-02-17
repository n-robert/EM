#!/bin/bash

chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chgrp -R www-data /var/www/storage /var/www/bootstrap/cache
chmod -R ug+rwx /var/www/storage /var/www/bootstrap/cache

