#!/bin/bash
#download and install
cd /tmp/copal
wget https://files.phpmyadmin.net/phpMyAdmin/$PMA_VER/phpMyAdmin-$PMA_VER-english.tar.gz
tar -xvf phpMyAdmin-$PMA_VER-english.tar.gz
sudo mv phpMyAdmin-$PMA_VER-english /usr/share/phpmyadmin
sudo mkdir -p /var/lib/phpmyadmin/tmp
sudo chown -R www-data:www-data /var/lib/phpmyadmin
sudo mkdir /etc/phpmyadmin/
sudo cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php
#configure defaults
cd $_defaults_/phpmyadmin
sudo cp config.inc.php /usr/share/phpmyadmin
sudo cp phpmyadmin.conf /etc/apache2/conf-enabled
sudo systemctl restart apache2
