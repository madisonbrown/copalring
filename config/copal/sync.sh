#!/bin/bash
func=$1
node=$2
hkey=$3
#peers.list
cd /etc/copal
if [[ $func == "add" ]]; then
  echo $node >> peers.list
elif [[ $func == "remove" ]]; then
  sed -i "/$node/d" peers.list
else
  exit 0
fi
readarray -t peers < peers.list
#galera.cnf
address=""
for peer in ${peers[@]}; do
  if [[ $address != "" ]]; then
    peer=",$peer"
  fi
  address+=$peer
done
sed -i "s/\"gcomm.*\"/\"gcomm:\/\/$address\"/g" /etc/copal/state/galera.cnf
#known_hosts
if [[ -n $hkey ]]; then
  if [[ $func == "add" ]]; then
    echo "$node $hkey" >> ~/.ssh/known_hosts
  elif [[ $func == "remove" ]]; then
    sed -i "/$node/d" known_hosts
  fi
fi
