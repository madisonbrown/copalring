#!/bin/bash
myips=$(hostname -I)
readarray -t peers < /etc/copal/peers.list
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
