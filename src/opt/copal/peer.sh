#!/bin/bash
cmd=$1
myips=$(hostname -I)
readarray -t peers < /etc/copal/data/globals/peers.list
#
if [[ $cmd == "-r" ]]; then
  if [[ ${#peers[@]} < 2 ]]; then
    exit
  fi
  #
  while : ; do
    peer=${peers[$RANDOM % ${#peers[@]}]}
    if [[ $myips != *$peer* ]]; then
      echo $peer
      break
    fi
  done
elif [[ $cmd == "-a" ]]; then
  echo ${peers[*]}
fi
