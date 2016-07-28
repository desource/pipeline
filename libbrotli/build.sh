#!/usr/bin/env sh
set -eux

BASE=$PWD
OUT=$PWD/libbrotli-build

git clone https://github.com/bagder/libbrotli

cd $BASE/libbrotli
./autogen.sh
./configure --prefix=$OUT
make
make install

git clone https://github.com/google/ngx_brotli.git
