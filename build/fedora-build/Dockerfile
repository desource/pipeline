FROM fedora:23

RUN \
  dnf update -y && \
  dnf install -y \
      which \
      make \
      binutils \
      gcc \
      patch \
      tar \
      xz \
      unzip \
      findutils && \
  dnf clean all
