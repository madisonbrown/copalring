#!/bin/bash
cmd=$1 && args=${@:2}
cd /opt/copal;
if [[ -f $cmd ]]; then
    . $cmd.sh $args
elif [[ -d $cmd ]]; then
    cd $cmd && . .sh $args
else
    echo "Invalid command '$cmd'." && exit
fi
