git clone git@github.com:n-robert/em

cd em
mv .env.example .env

chown -R www-data:www-data storage bootstrap/cache \
&& chgrp -R www-data storage bootstrap/cache \
&& chmod -R ug+rwx storage bootstrap/cache

docker compose up --build --remove-orphans

docker exec -it php-fpm-em bash
composer install
npm install && npm audit fix && npm run dev

# Site will be available at http://your_host:8002
