#!/bin/bash

#sudo systemctl status apache2
#/etc/init.d/apache2 status

cd /var/www
sudo chown -R ubuntu:ubuntu html
cd html
git clone https://github.com/oriophile/proto.git
cd proto
cp .env.example .env
confDir=/etc/apache2/sites-available
confSite=000-default
sudo a2dissite $confSite
sudo systemctl restart apache2
sudo sed -i 's/DocumentRoot \/var\/www\/html$/DocumentRoot \/var\/www\/html\/proto\/public/' ${confDir}/${confSite}.conf
sudo sed -i '/<\/VirtualHost>/i \\t<Directory \/var\/www\/html\/proto\/public>\n\t\tAllowOverride All\n\t<\/Directory>' ${confDir}/${confSite}.conf
sudo a2ensite $confSite
composer install
php artisan key:generate
sudo systemctl restart apache2
sudo systemctl restart mysql
mysql -u root -p -e "create database laravel character set utf8mb4 collate utf8mb4_general_ci"
sudo chown -R www-data:www-data /var/www/html/proto/storage
sudo chown -R www-data:www-data /var/www/html/proto/bootstrap/cache
