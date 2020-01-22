#!/bin/bash
temp=/tmp/copal && echo > $temp
echo "@id_rsa" >> $temp && cat ~/.ssh/id_rsa >> $temp
echo "@id_rsa.pub" >> $temp && cat ~/.ssh/id_rsa.pub >> $temp
# file=~/.ssh/known_hosts && echo "@$file" >> $temp && cat $file >> $temp
# file=/etc/copal/data/globals/cluster.sh && echo "@$file" >> $temp && cat $file >> $temp 
# file=/etc/copal/data/globals/peers.list && echo "@$file" >> $temp && cat $file >> $temp
clear && echo -e "Copal Cluster Serial:\n"
base64 $temp && rm $temp && echo
