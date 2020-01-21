#!/bin/bash
DIR=$(cd $(dirname $0) && pwd)
NAME=$(basename $DIR)
TARGET=$DIR/deb/$NAME-$1
#
[[ -d deb ]] || mkdir deb
mkdir $TARGET && cp -a $DIR/src $TARGET
cd $TARGET && dh_make --indep --createorig
echo './src/* ./' > debian/install
rm debian/*.ex
#debuild
