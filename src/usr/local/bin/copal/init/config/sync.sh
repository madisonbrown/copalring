#!/bin/bash
func=$1 && node=$2 && hkey=$3
#peers.list
cd $_target_/data/globals
if [[ $func == "add" ]]; then
  echo $node >> peers.list
elif [[ $func == "remove" ]]; then
  sed -i "/$node/d" peers.list
else
  exit 0
fi
#galera.cnf
address=$(copal peer -a | tr ' ' ',')
sed -i "s/\"gcomm.*\"/\"gcomm:\/\/$address\"/g" $_target_/data/locals/galera.cnf
#known_hosts
if [[ -n $hkey ]]; then
  if [[ $func == "add" ]]; then
    echo "$node $hkey" >> ~/.ssh/known_hosts
  elif [[ $func == "remove" ]]; then
    sed -i "/$node/d" known_hosts
  fi
fi
