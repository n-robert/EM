#### This is a Laravel-based HRP template for employers, who use foreign workers in Russia. It will make your life a bit easier by preparing legal documents, monitoring workers legal state and much more...
## Installation steps
### 1. Clone this repo
`git clone git@github.com:n-robert/em`

### 2. Go to app folder
`cd em`

### 3. Add .env file from .env.example
`cp .env.example .env`

### 4. Change ownership and permissions for folders "storage" and "bootstrap/cache"
`chown -R www-data:www-data storage bootstrap/cache\
chgrp -R www-data storage bootstrap/cache\
chmod -R ug+rwx storage bootstrap/cache`

### 5. Build containers
`docker compose up -d --build --remove-orphans`

### 6. Get in to "php-fpm-em" container
`docker exec -it php-fpm-em bash`

### 7. Install dependencies and run executables in node_modules
`composer install\
npm install && npm audit fix\
npm run dev`

### 8. Install Orchid admin panel
`composer require orchid/platform
php artisan orchid:install
php artisan migrate
php artisan orchid:admin --id=1`

### 9. Exit and restore our User model
`exit
cp app/Models/User.php.example app/Models/User.php`

### Site will be available at http://your_host:8002 {email: test@mail.ru, password: test1234}
### Admin panel will be available at http://your_host:8002/admin {email: test@mail.ru, password: test1234}
