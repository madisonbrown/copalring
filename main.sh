#!/bin/bash
DIR=$(cd $(dirname $0) && pwd)
NAME=$(basename $DIR)
#
git merge working
#
TARGET=$DIR/temp/$NAME-1.0
mkdir temp && mkdir $TARGET
cd $TARGET && dh_make --indep --createorig
echo './src/* ./' > debian/install
echo '3.0 (native)' > debian/source/format
rm debian/*.ex
cp -a $DIR/src $TARGET
debuild
#
cd .. && mv *.deb /var/www/html
cd .. && rm -rf temp