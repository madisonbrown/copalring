#!/bin/bash
DIR=$(cd $(dirname $0) && pwd)
NAME=$(basename $DIR)
TARGET=$DIR/$NAME-$1
#
mkdir $TARGET & cp -a $DIR/src $TARGET
cd $TARGET && dh_make --indep --createorig
grep -v makefile debian/rules > debian/rules.new
mv debian/rules.new debian/rules
echo ./src/* ./ > debian/install
rm debian/*.ex
debuild