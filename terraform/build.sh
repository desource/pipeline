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
FROM scratch

ADD bin/terraform /bin/terraform
ADD tmp           /tmp

ENV PATH /bin

VOLUME ["/terraform"]

ENTRYPOINT [ "/bin/terraform" ]

EOF
