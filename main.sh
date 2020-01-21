#!/bin/bash
DIR=$(cd $(dirname $0) && pwd)
NAME=$(basename $DIR)
#
[[ -d deb ]] && rm -rf deb
mkdir deb
#
TARGET=$DIR/deb/$NAME-$1 && mkdir $TARGET
cd $TARGET && dh_make --indep --createorig
echo './src/* ./' > debian/install
echo '3.0 (native)' > debian/source/format
rm debian/*.ex
#
cp -a $DIR/src $TARGET
debuild
