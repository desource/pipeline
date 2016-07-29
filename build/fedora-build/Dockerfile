FROM fedora:23

RUN \
  dnf update -y && \
  dnf install -y \
      which \
      make \
      cmake \
      binutils \
      gcc \
      patch \
      tar \
      xz \
      unzip \
      git \
      findutils \
      golang && \
  dnf clean all
