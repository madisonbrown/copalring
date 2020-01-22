#!/bin/bash
if [[ -z $2 ]]; then
    data="" && echo -n "" > _temp
    while : ; do
        read line
        if [[ $line == "" ]]; then
            base64 -d _temp >> _data && rm _temp && break;
        else
            echo $line >> _temp
        fi
    done
    #
    bash $0 $1 _data
    rm _data
else
    file=/dev/null
    while read line; do
        if [[ ${line:0:1} == "@" ]]; then
            file=$1/${line:1}
            echo -n "" > $file
        else
            echo $line >> $file
        fi
    done < $2
fi
