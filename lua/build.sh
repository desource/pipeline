#!/usr/bin/env bash
set -eux

LUA_VERSION=5.3.2
LUA_SHA1=7a47adef554fdca7d0c5536148de34579134a973

BASE=$PWD

mkdir -p $BASE/lua
curl -OL http://www.lua.org/ftp/lua-$LUA_VERSION.tar.gz
echo "$LUA_SHA1  lua-$LUA_VERSION.tar.gz" | sha1sum -c
tar -C $BASE/lua --strip-components 1 -xf lua-$LUA_VERSION.tar.gz

cd $BASE/lua
make linux
make install INSTALL_TOP=$BASE/lua-build
