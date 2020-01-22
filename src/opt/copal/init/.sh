#!/bin/bash
_target_=/etc/copal
_defaults_=/usr/share/copal/defaults
_vendor_=/opt/copal/init/vendor
_config_=/opt/copal/init/config
_globals_=$_target_/data/globals
_locals_=$_target_/data/locals
#
if [[ -f $_globals_/cluster.sh ]]; then
  BOOTSTRAP=$1
  #retreive globals
  . $_globals_/cluster.sh
  . $_config_/node.sh
  #install vendor software
  sudo apt update
  #sudo apt upgrade -y
  mkdir /tmp/copal
  . $_vendor_/apache.sh
  . $_vendor_/galera.sh
  . $_vendor_/php.sh
  . $_vendor_/phpmyadmin.sh
  . $_vendor_/git.sh
  rm -rf /tmp/copal
  #enable firewall
  . $_config_/ufw.sh
  #complete
  clear && echo -e "Installation successful!\n"
else
  if [[ -f $_locals_/node.sh ]];then
    echo "Copal has already been installed on this system and cannot be installed again."
  elif [[ $(whoami) != "root" ]]; then
    echo "Copal must be initialized by the root user."
  else
    read -p "Connect to existing cluster? [Y/n]" BOOTSTRAP
    if ([[ $BOOTSTRAP == "n" || $BOOTSTRAP == "N" ]]); then
      BOOTSTRAP=1
      #create cluster rsa key
      cat /dev/zero | ssh-keygen -q -f ~/.ssh/id_rsa -N ""
      chmod 400 ~/.ssh/id_rsa
      #prepare cluster global config
      touch $_globals_/peers.list && touch $_globals_/known_hosts
      . $_config_/cluster.sh
    else
      BOOTSTRAP=0
      read -p "Donor Node IP: " peer
      #install cluster rsa key
      echo -e "Please paste the cluster serial...\n"
      bash $_config_/transfer.sh ~/.ssh && chmod 400 ~/.ssh/id_rsa
      #download cluster global config
      scp -r root@$peer:$_globals_ $(dirname $_globals_)
      rm ~/.ssh/known_hosts && unset peer
      . $_globals_/cluster.sh
    fi
    #create dev user
    adduser $DEV_USER --gecos "" --disabled-password
    echo -e "$DEV_PW\n$DEV_PW" | passwd $DEV_USER
    usermod -aG sudo $DEV_USER
    #install rsa keys
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    ln -s $_globals_/known_hosts ~/.ssh
    read test
    cp -a ~/.ssh /home/$DEV_USER
    read test
    chown -R $DEV_USER:$DEV_USER /home/$DEV_USER/.ssh
    #prepare installation folder
    #rm -rf $_target_/.temp
    chown -R $DEV_USER:$DEV_USER $_target_
    #continue installation as dev user
    sudo -u $DEV_USER -H sh -c "bash copal init $BOOTSTRAP" && su - $DEV_USER
  fi
fi
