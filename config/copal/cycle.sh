#!/bin/bash
cmd=$1
exc=$2
myips=$(hostname -I)
readarray -t peers < /etc/copal/peers.list
for peer in ${peers[@]}; do
  if [[ $exc != "-e" || $myips != *$peer* ]]; then
    ssh -t $USER@$peer $cmd
  fi
done
