#!/bin/bash
sudo apt install -y software-properties-common
echo | sudo add-apt-repository ppa:ondrej/php
sudo apt install -y php$PHP_VER php-pear php$PHP_VER-curl php$PHP_VER-dev php$PHP_VER-gd php$PHP_VER-mbstring php$PHP_VER-zip php$PHP_VER-mysqlnd php$PHP_VER-xml php$PHP_VER-imap
sudo chown -R $DEV_USER /var/www
sudo echo "<?php echo phpinfo();?>" > /var/www/html/info.php
