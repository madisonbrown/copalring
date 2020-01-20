#!/bin/bash
if [[ $BOOTSTRAP == 0 ]]; then
  read -s -p "Password: " pw
  pw_hash=$(echo $pw | sha256sum)
  if [[ $DEV_PW == $pw_hash ]]; then
    DEV_PW=$pw
  else
    echo "Incorrect Password"
    exit
  fi
#
echo "-----BEGIN RSA PRIVATE KEY-----" > $indir/config/id_rsa
  echo "Please paste the cluster private key..."
  while : ; do
    read line
    if [[ $line == "" ]]; then
      break
    else
      echo $line >> $indir/config/id_rsa
    fi
  done
  echo "-----END RSA PRIVATE KEY-----" >> $indir/config/id_rsa
fi
#
NODE_NAME=$(hostname)
#
i=0 && myips=($(hostname -I))
for ip in ${myips[@]}; do
  echo "[$i] $ip" && i=$((i+1))
done
read -p "Node IP: " i && NODE_IP=${myips[i]}
unset ip && unset myips && unset i
#
read -p "Data Node? [Y/n]: " DATA_NODE
if [[ $DATA_NODE == "" || $DATA_NODE == "Y" || $DATA_NODE == "y" ]]; then 
  DATA_NODE=1 
else 
  DATA_NODE=0 
fi
#
read -p "Application Node? [Y/n]: " APP_NODE
if [[ $APP_NODE == "" || $APP_NODE == "Y" || $APP_NODE == "y" ]]; then 
  APP_NODE=1 
else 
  APP_NODE=0 
fi
