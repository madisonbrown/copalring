#!/bin/bash
indir=$(cd $(dirname $0) && pwd)
if [[ -d "/etc/copal" ]]; then
  echo "Copal has already been installed on this system and cannot be installed again."
  exit;
fi
. $indir/0-cluster.sh
if [[ $USER == "root" ]]; then
  . $indir/1-node.sh
  #prepare the dev user
  adduser $DEV_USER --gecos "" --disabled-password
  echo -e "$DEV_PW\n$DEV_PW" | passwd $DEV_USER
  usermod -aG sudo $DEV_USER
  cd $indir && indir=/home/$DEV_USER/copal
  rsync --archive --chown=$DEV_USER:$DEV_USER ~/.ssh /home/$DEV_USER
  rsync --archive --chown=$DEV_USER:$DEV_USER ./ $indir
  #serialize environment variables
  cd $indir
  echo "#!/bin/bash" > 0-cluster.sh
  echo "BOOTSTRAP=$BOOTSTRAP" >> 0-cluster.sh
  echo "DEV_USER='$DEV_USER'" >> 0-cluster.sh
  echo "DEV_PW='$DEV_PW'" >> 0-cluster.sh
  echo "CLUSTER_NAME='$CLUSTER_NAME'" >> 0-cluster.sh
  echo "NODE_IP='$NODE_IP'" >> 0-cluster.sh
  echo "NODE_NAME='$NODE_NAME'" >> 0-cluster.sh
  echo "DATA_NODE='$DATA_NODE'" >> 0-cluster.sh
  echo "APP_NODE='$APP_NODE'" >> 0-cluster.sh
  echo "MYSQL_VER='$MYSQL_VER'" >> 0-cluster.sh
  echo "GALERA_VER='$GALERA_VER'" >> 0-cluster.sh
  echo "PHP_VER='$PHP_VER'" >> 0-cluster.sh
  echo "PMA_VER='$PMA_VER'" >> 0-cluster.sh
  sudo -u $DEV_USER -H sh -c "bash $indir/install.sh"
  su - $DEV_USER
else
  mv config/id_rsa ~/.ssh && chmod 400 ~/.ssh/id_rsa
  cp config/id_rsa.pub ~/.ssh
  cp config/known_hosts ~/.ssh
  cat config/id_rsa.pub >> ~/.ssh/authorized_keys
  #
  outdir=/etc/copal
  sudo mkdir $outdir
  sudo chown $DEV_USER:$DEV_USER $outdir
  cp -a config/copal/* $outdir
  mkdir $outdir/config && mkdir $outdir/state
  #
  sudo apt update
  . $indir/2-apache.sh
  . $indir/3-galera.sh
  . $indir/4-php.sh
  . $indir/5-phpmyadmin.sh
  . $indir/6-git.sh
  . $indir/7-ufw.sh
  #sudo apt upgrade -y
  . $indir/8-finalize.sh
fi
