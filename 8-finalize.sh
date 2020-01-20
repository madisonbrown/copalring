#!/bin/bash
#secret=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c256)
#prepare relay installer
cd $indir && cat ~/.ssh/known_hosts > config/known_hosts
echo $NODE_IP >> config/copal/peers.list
sed -i "s/BOOTSTRAP=1/BOOTSTRAP=0/g" 0-cluster.sh
sed -i "s/DEV_PW='$DEV_PW'/DEV_PW='$(echo $DEV_PW | sha256sum)'/g" 0-cluster.sh
cat 0-cluster.sh > $outdir/state/globals.sh
cd .. && tar -czf /var/www/html/copal.tar.gz copal && rm -R copal
#restart mysql
[[ $BOOTSTRAP == 1 ]] || sudo systemctl restart mysql
#complete
clear
echo -e "Installation successful!\n"
sudo mysql -u root -e "SHOW STATUS LIKE 'wsrep_cluster_size'"
echo -e "\nReserve the following private key..."
cat .ssh/id_rsa
echo -e "\nand use the following command to continue installation on the next node:"
echo -e "  wget http://$NODE_IP/copal.tar.gz && tar -xzf copal.tar.gz && cd copal && bash install.sh\n"
