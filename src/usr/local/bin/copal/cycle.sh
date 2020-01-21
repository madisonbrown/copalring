#!/bin/bash
exc=$1 && cmd=$2
myips=$(hostname -I)
peers=$(copal peer -a)
#
for peer in ${peers[@]}; do
  if [[ $exc != "-e" || $myips != *$peer* ]]; then
    ssh -t $USER@$peer $cmd
  fi
done
