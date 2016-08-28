#!/bin/sh
#
# Download and create a rootfs for concourse container
set -euo pipefail

declare -r version=1.6.0
declare -r sha256=07cd9fc6fbebdc0ae64f227f4844f1dc83b2bff631fb2b024b8f8dcff0099e99

declare -r src=${PWD}/src
declare -r glibc=${PWD}/glibc
declare -r out=${PWD}/out
declare -r rootfs=${PWD}/rootfs

mkdirs() {
  mkdir -p ${rootfs}/bin ${rootfs}/etc ${rootfs}/lib64 ${out}
}

download() {
  cd ${rootfs}

  curl -L "https://github.com/concourse/concourse/releases/download/v${version}/concourse_linux_amd64" \
       -o bin/concourse
  echo "${sha256}  bin/concourse" | sha256sum -c
  chmod +x bin/concourse
}

build_rootfs() {

  cp ${glibc}/libc.so.* ${glibc}/nptl/libpthread.so.* ${glibc}/elf/ld-linux-x86-64.so.* ${rootfs}/lib64

  ln -s /lib64 ${rootfs}/lib

  mkdir -p ${rootfs}/etc/ssl/certs
  cp /etc/pki/tls/certs/ca-bundle.crt ${rootfs}/etc/ssl/certs/ca-certificates.crt

  cat <<EOF > ${rootfs}/etc/nsswitch.conf
hosts: files mdns4_minimal dns [NOTFOUND=return] mdns4
EOF

  cat <<EOF > ${rootfs}/etc/passwd
root:x:0:0:root:/:/dev/null
nobody:x:65534:65534:nogroup:/:/dev/null
EOF

  cat <<EOF > ${rootfs}/etc/group
root:x:0:
nogroup:x:65534:
EOF

  tar -cf ${out}/{rootfs}.tar -C ${rootfs} .
}

dockerfile() {
  cat <<EOF > ${out}/tag
${version}
EOF

  cat <<EOF > ${out}/Dockerfile
FROM scratch

ADD {rootfs}.tar /

ENV \
  PATH=/bin \
  LD_LIBRARY_PATH=/lib

ENTRYPOINT [ "/bin/concourse" ]
EOF
}


mkdirs
download
build_rootfs
dockerfile
