#!/usr/bin/env sh
set -eux

SLZ_VERSION=1.0.0
SLZ_SHA256=4696da81bc4ac5ec5bbc36a62c168bdca4d35f4fbe63da76b2d9cf54be857a45

BASE=$PWD

OUT=$BASE/libslz-build

mkdir -p $BASE/libslz
curl -OL https://github.com/haproxy/libslz/archive/v$SLZ_VERSION.tar.gz
echo "$SLZ_SHA256  v$SLZ_VERSION.tar.gz" | sha256sum -c
tar -C $BASE/libslz --strip-components 1 -xf v$SLZ_VERSION.tar.gz

cd $BASE/libslz
make
make install PREFIX=$OUT
