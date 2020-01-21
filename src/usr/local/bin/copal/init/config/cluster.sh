#!/bin/bash
echo "#!/bin/bash" > $_globals_/cluster.sh
#
read -p "Username: " DEV_USER
echo "DEV_USER=$DEV_USER" >> $_globals_/cluster.sh
while : ; do
read -s -p "Password: " pw && echo
read -s -p "Confirm Password: " DEV_PW
if [[ $pw != $DEV_PW ]]; then
    echo "Passwords do not match. Try again..."
else
    echo "DEV_PW=$DEV_PW" >> $_globals_/cluster.sh
    unset pw && echo && break
fi
done
#
read -p "Cluster Name: " CLUSTER_NAME
echo "CLUSTER_NAME=$CLUSTER_NAME" >> $_globals_/cluster.sh
#
MYSQL_VER="5.7"
read -e -p "MySQL Version: " -i "$MYSQL_VER" MYSQL_VER
echo "MYSQL_VER=$MYSQL_VER" >> $_globals_/cluster.sh
#
GALERA_VER="3"
read -e -p "Galera Version: " -i "$GALERA_VER" GALERA_VER
echo "GALERA_VER=$GALERA_VER" >> $_globals_/cluster.sh
#
PHP_VER="7.4"
read -e -p "PHP Version: " -i "$PHP_VER" PHP_VER
echo "PHP_VER=$PHP_VER" >> $_globals_/cluster.sh
#
PMA_VER="5.0.1"
read -e -p "phpMyAdmin Version: " -i "$PMA_VER" PMA_VER
echo "PMA_VER=$PMA_VER" >> $_globals_/cluster.sh