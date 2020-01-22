#!/bin/bash
cd $_defaults_/galera
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv BC19DDBA
sudo cp galera.list /etc/apt/sources.list.d
sudo cp galera.pref /etc/apt/preferences.d
sudo apt update && sudo apt install -y galera-$GALERA_VER
sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-wsrep-$MYSQL_VER
sudo ln -s /etc/apparmor.d/usr.sbin.mysqld /etc/apparmor.d/disable/
sudo apparmor_parser -R /etc/apparmor.d/usr.sbin.mysqld
sudo cp galera.cnf $_target_/data/locals
#apply default configurations 
cd $_target_/data/locals
sed -i "s/{CLUSTER_NAME}/$CLUSTER_NAME/g" galera.cnf
sed -i "s/{CLUSTER_IPS}/$NODE_IP/g" galera.cnf
sed -i "s/{NODE_IP}/$NODE_IP/g" galera.cnf
sed -i "s/{NODE_NAME}/$NODE_NAME/g" galera.cnf
sudo ln -s galera.cnf /etc/mysql/conf.d/galera.cnf
#synchronize peer configurations
hkey=$(sed "s/localhost //g" <<< $(ssh-keyscan -t ssh-rsa localhost))
sync="copal sync add '$NODE_IP' '$hkey'"
eval "$sync" && copal cycle -e "$sync"
unset hkey && unset sync
#initialize service
sudo systemctl enable mysql
if [[ $BOOTSTRAP == 1 ]]; then
  sudo mysqld_bootstrap
  sudo mysql --user="root" --execute="CREATE USER '$DEV_USER'@'localhost' IDENTIFIED BY '$DEV_PW'; GRANT ALL PRIVILEGES ON *.* TO '$DEV_USER'@'localhost'; FLUSH PRIVILEGES;"
else
  sudo systemctl start mysql
fi
