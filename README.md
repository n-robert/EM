git clone git@github.com:n-robert/em.nginx
docker compose up --build --remove-orphans
docker compose exec php-fpm composer install
docker compose exec php-fpm chown -R www-data:www-data ./
docker compose exec php-fpm chgrp -R www-data storage bootstrap/cache
docker compose exec php-fpm chmod -R ug+rwx storage bootstrap/cache
npm install
