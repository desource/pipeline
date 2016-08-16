FROM ubuntu:xenial

RUN \
  DEBIAN_FRONTEND=noninteractive apt-get update -y && \
  DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
  DEBIAN_FRONTEND=noninteractive apt-get clean && \
  rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
