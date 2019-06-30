#!/bin/bash

CWD=$(pwd)
cd $HOME

sudo apt update
sudo apt install -y git
git config --global user.name "oriophile"
git config --global user.email "bhagwati@incogtech.com"
#git config user.name
#git config user.email



sudo apt install -y software-properties-common
sudo add-apt-repository ppa:ondrej/ppa
sudo apt update
sudo apt install -y apache2
sudo apt install -y mysql-server
sudo apt install -y php7.3
sudo apt install -y libapache2-mod-php7.3
#ctype resides in common extension package (usually gets installed while installing the php package
sudo apt install -y php7.3-bcmath php7.3-common php7.3-json php7.3-mbstring php7.3-pdo php7.3-xml
#these exentions are not required explicitly but composer still requires them to install Laravel
sudo apt install -y php7.3-zip
#sudo apt autoremove


php -r "copy('https://getcomposer.org/installer', 'setup.php');"
php setup.php
php -r "unlink('setup.php');"
sudo mv composer.phar /usr/local/bin/composer
composer global require 'laravel/installer'

sudo systemctl restart apache2
sudo systemctl restart mysql
git --version
git config --list
sudo apache2 -v
sudo mysql --version
php -v
composer --version
echo "Note : add path '\$HOME/.composer/vendor/bin' to path variable\n"
cd $CWD
