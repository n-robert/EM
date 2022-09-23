git clone git@github.com:n-robert/em.nginx
docker compose up --build --remove-orphans

docker exec -it php-fpm-em bash

[//]: # (    first installation)
    chown -R www-data:www-data storage bootstrap/cache
    chgrp -R www-data storage bootstrap/cache
    chmod -R ug+rwx storage bootstrap/cache
    composer install
    npm install
    
[//]: # (    updating)
    composer update
    npm update

[//]: # (    always)
    npm run dev

exit
