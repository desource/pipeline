#!/bin/sh
set -eux

version=1.6.0
sha256=07cd9fc6fbebdc0ae64f227f4844f1dc83b2bff631fb2b024b8f8dcff0099e99

src=$PWD/src
glibc=$PWD/glibc

out=$PWD/out
rootfs=$PWD/rootfs

mkdir -p $rootfs/bin $rootfs/etc $rootfs/lib64 $out

cd $rootfs

curl -o bin/concourse -L "https://github.com/concourse/concourse/releases/download/v${version}/concourse_linux_amd64"
echo "${sha256}  bin/concourse" | sha256sum -c
chmod +x bin/concourse

echo 'hosts: files mdns4_minimal dns [NOTFOUND=return] mdns4' >> $ROOTFS/etc/nsswitch.conf

cat <<EOF > etc/passwd
root:x:0:0:root:/:/dev/null
nobody:x:65534:65534:nogroup:/:/dev/null
EOF

cat <<EOF > etc/group
root:x:0:
nogroup:x:65534:
EOF

tar -cf $out/rootfs.tar .

cat <<EOF $out/Dockerfile
FROM scratch

ADD rootfs.tar /

ENV PATH /bin

ENTRYPOINT [ "/bin/concourse" ]
EOF


