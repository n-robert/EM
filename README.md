git clone git@github.com:n-robert/em.nginx

cd em.nginx \
&& sudo chown -R www-data:www-data storage bootstrap/cache \
&& sudo chgrp -R www-data storage bootstrap/cache \
&& sudo chmod -R ug+rwx storage bootstrap/cache

# First installation only: add .env, docker-compose.yml, backup/last/em_pg-latest.sql.gz

docker compose up --build --remove-orphans
docker exec -it php-fpm-em bash

# First installation only
composer install
npm install
    
# Updating
composer update
npm update

# Always
npm run dev

# If there is no /backup/last/em_pg-latest.sql.gz
php artisan migrate --path=/database/migrations/0000_00_00_000000_create_migrations_table.php
php artisan migrate --path=/database/migrations/0000_00_00_000000_create_sessions_table.php
php artisan migrate --path=/database/migrations/0000_00_00_000000_create_teams_table.php
php artisan migrate --path=/database/migrations/0000_00_00_000000_create_users_table.php
php artisan migrate --path=/database/migrations/0000_00_00_000000_add_two_factor_columns_to_users_table.php
php artisan migrate --path=/database/migrations/finish/

[//]: # (db:seed will not work after 23/03/23)
php artisan db:seed

exit

Go to /register, register superuser, rename his team to "admin". As superuser create new team "editor", 
whose admin role can edit.
