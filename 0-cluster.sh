#!/bin/bash
BOOTSTRAP=1
read -p "Username: " DEV_USER
while : ; do
  read -s -p "Password: " pw && echo
  read -s -p "Confirm Password: " DEV_PW
  if [[ $pw != $DEV_PW ]]; then
    echo "Passwords do not match. Try again..."
  else
    unset pw && echo && break
  fi
done
read -p "Cluster Name: " CLUSTER_NAME
MYSQL_VER="5.7"
read -e -p "MySQL Version: " -i "$MYSQL_VER" MYSQL_VER
GALERA_VER="3"
read -e -p "Galera Version: " -i "$GALERA_VER" GALERA_VER
PHP_VER="7.4"
read -e -p "PHP Version: " -i "$PHP_VER" PHP_VER
PMA_VER="5.0.1"
read -e -p "phpMyAdmin Version: " -i "$PMA_VER" PMA_VER
#generate ssh keys for peer communication
cat /dev/zero | ssh-keygen -q -f config/id_rsa -N ""
