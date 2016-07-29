#!/usr/bin/env bash
set -eux

GLIBC_VERSION=2.23
GLIBC_SHA256SUM=94efeb00e4603c8546209cefb3e1a50a5315c86fa9b078b6fad758e187ce13e9

SRC=$PWD/glibc
OUT=$PWD/glibc-build

curl -OL http://ftp.gnu.org/gnu/libc/glibc-$GLIBC_VERSION.tar.xz
echo "$GLIBC_SHA256SUM  glibc-$GLIBC_VERSION.tar.xz" | sha256sum -c
mkdir -p $SRC
tar -C $SRC --strip-components=1 -xf glibc-$GLIBC_VERSION.tar.xz

mkdir -p $SRC/build
cd $SRC/build
../configure \
    --enable-shared \
    --without-cvs \
    --without-gd \
    --disable-profile \
    --disable-sanity-checks
make

cp -r $SRC/build $OUT
