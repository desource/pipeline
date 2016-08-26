#!/bin/sh
set -eux

out=$PWD/out

export GOPATH=$PWD/go
export PATH=$GOPATH/bin:$PATH

mkdir -p $out/bin $out/tmp

cd $GOPATH/src/github.com/hashicorp/terraform

make bin XC_OS="linux" XC_ARCH="amd64"

cp pkg/linux_amd64/terraform $out/bin

cat <<EOF > $out/Dockerfile
FROM alpine:3.4

RUN apk --no-cache add git

ADD bin/terraform /bin/terraform
ADD tmp           /tmp

VOLUME ["/terraform"]

ENTRYPOINT [ "/bin/terraform" ]

EOF
