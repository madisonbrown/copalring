#!/bin/bash
mkdir temp && cd temp
wget https://files.phpmyadmin.net/phpMyAdmin/$PMA_VER/phpMyAdmin-$PMA_VER-english.tar.gz
tar -xvf phpMyAdmin-$PMA_VER-english.tar.gz
sudo mv phpMyAdmin-$PMA_VER-english /usr/share/phpmyadmin
sudo mkdir -p /var/lib/phpmyadmin/tmp
sudo chown -R www-data:www-data /var/lib/phpmyadmin
sudo mkdir /etc/phpmyadmin/
sudo cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php
cd .. && rm -R temp
sudo cp $indir/config/phpmyadmin/config.inc.php /usr/share/phpmyadmin
sudo cp $indir/config/phpmyadmin/phpmyadmin.conf /etc/apache2/conf-enabled
sudo systemctl restart apache2
