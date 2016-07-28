#!/usr/bin/env sh
set -eux

LIBRESSL_VERSION=2.4.1
LIBRESSL_SHA512=61db009bf13e409a822e8438cf6dee4ac3e7d763e548d4afa9bf493c0a24aad760438793eb66d3b9a6e6b3f05a61f6dd26ca4a3368587fe6b8214d5f4a814560

SRC=$PWD/libressl
OUT=$PWD/libressl-build

mkdir -p $SRC
curl -OL http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-$LIBRESSL_VERSION.tar.gz
echo "$LIBRESSL_SHA512  libressl-$LIBRESSL_VERSION.tar.gz" | sha512sum -c
tar -C $SRC --strip-components 1 -xf libressl-$LIBRESSL_VERSION.tar.gz

mkdir -p $SRC/build
cd $SRC/build
../configure --prefix=$OUT --disable-shared
make
make install
