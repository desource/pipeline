#!/bin/sh
set -eux

out=$PWD/out

export GOPATH=$PWD/go
export PATH=$GOPATH/bin:$PATH

mkdir -p $out/bin $out/tmp

cd $GOPATH/src/github.com/hashicorp/terraform

make bin XC_OS="linux darwin" XC_ARCH="amd64"

cp -r pkg $out/pkg

cat <<EOF > $out/Dockerfile
FROM alpine:3.4

RUN apk --no-cache add git

ADD pkg/linux_amd64/terraform /bin/terraform

VOLUME ["/terraform"]

ENTRYPOINT ["/bin/terraform"]

EOF
