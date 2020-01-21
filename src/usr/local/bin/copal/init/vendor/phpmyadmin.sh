#!/bin/bash
cd $_defaults_/phpmyadmin
#download and install
mkdir temp && cd temp
wget https://files.phpmyadmin.net/phpMyAdmin/$PMA_VER/phpMyAdmin-$PMA_VER-english.tar.gz
tar -xvf phpMyAdmin-$PMA_VER-english.tar.gz
sudo mv phpMyAdmin-$PMA_VER-english /usr/share/phpmyadmin
sudo mkdir -p /var/lib/phpmyadmin/tmp
sudo chown -R www-data:www-data /var/lib/phpmyadmin
sudo mkdir /etc/phpmyadmin/
sudo cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php
cd .. && rm -R temp
#configure defaults
sudo cp config.inc.php /usr/share/phpmyadmin
sudo cp phpmyadmin.conf /etc/apache2/conf-enabled
sudo systemctl restart apache2