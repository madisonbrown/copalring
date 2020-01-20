#!/bin/bash
sudo apt install -y apache2
sudo a2enmod rewrite
sudo a2enmod proxy
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_wstunnel
sudo a2enmod ssl
#apply default configurations
cd $indir/config/apache
sudo cp apache2.conf /etc/apache2
sudo cp dir.conf /etc/apache2/mods-enabled
sudo cp -a sites-available /etc/apache2
#entrust apache config files
cp -a /etc/apache2 /etc/copal/config
sudo rm -R /etc/apache2
sudo ln -s /etc/copal/config/apache2 /etc/apache2
sudo systemctl restart apache2
#enable password protecttion
#sudo cp .htaccess /var/www/html
#sudo htpasswd -b -c /etc/apache2/.htpasswd $DEV_USER $DEV_PW
