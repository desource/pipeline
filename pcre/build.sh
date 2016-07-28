#!/usr/bin/env sh

set -eu

BASE=$PWD

PCRE_VERSION=8.38
PCRE_SHA256=9883e419c336c63b0cb5202b09537c140966d585e4d0da66147dc513da13e629

mkdir -p $BASE/pcre
curl -OL ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-$PCRE_VERSION.tar.gz
echo "$PCRE_SHA256  pcre-$PCRE_VERSION.tar.gz" | sha256sum -c
tar -C $BASE/pcre --strip-components 1 -xf pcre-$PCRE_VERSION.tar.gz

cd $BASE/pcre
./configure --enable-utf8 --enable-jit --disable-shared --prefix=$BASE/pcre-build
make
make install
