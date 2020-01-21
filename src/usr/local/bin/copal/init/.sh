#!/bin/bash
_target_=/etc/copal
_defaults_=/usr/share/copal/defaults
_vendor_=/usr/local/bin/copal/init/vendor
_config_=/usr/local/bin/copal/init/config
_globals_=$_target_/data/globals
#
if [[ -f $_globals_/cluster.sh ]]; then
  BOOTSTRAP=$1
  #retreive globals
  . $_globals_/cluster.sh
  . $_config_/node.sh
  #install vendor software
  sudo apt update && sudo apt upgrade -y
  . $_vendor_/apache.sh
  . $_vendor_/galera.sh
  . $_vendor_/php.sh
  . $_vendor_/phpmyadmin.sh
  . $_vendor_/git.sh
  #enable firewall
  . $_config_/ufw.sh
  #complete
  clear && echo -e "Installation successful!\n"
else
  if [[ -d /etc/copal ]];then
    echo "Copal has already been installed on this system and cannot be installed again."
  elif [[ $(whoami) != "root" ]]; then
    echo "Copal must be initialized by the root user."
  else
    read -p "Connect to existing cluster? [Y/n]" BOOTSTRAP
    if ([[ $BOOTSTRAP == "n" || $BOOTSTRAP == "N" ]]); then
      BOOTSTRAP=1
      . $_config_/cluster.sh
    else
      BOOTSTRAP=0
      bash $_config_/transfer.sh
    fi
    #create dev user
    adduser $DEV_USER --gecos "" --disabled-password
    echo -e "$DEV_PW\n$DEV_PW" | passwd $DEV_USER
    usermod -aG sudo $DEV_USER
    #install rsa keys
    rsync --archive --chown=$DEV_USER:$DEV_USER ~/.ssh /home/$DEV_USER
    cat /dev/zero | ssh-keygen -q -f /home/$DEV_USER/id_rsa -N ""
    #create target install directory
    mkdir $_target_ && chown $DEV_USER:$DEV_USER $_target_
    cp -a $_defaults_/copal/* $_target_
    #continue installation as dev user
    sudo -u $DEV_USER -H sh -c "bash $0 $BOOTSTRAP" && su - $DEV_USER
  fi
fi
