#!/bin/bash
exc=$1 && cmd=$2
myips=$(hostname -I)
peers=$(copal peer -a)
user=$(whoami)
#
for peer in ${peers[@]}; do
  if [[ $exc != "-e" || $myips != *$peer* ]]; then
    ssh -t $user@$peer $cmd
  fi
done
