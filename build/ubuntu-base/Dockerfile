FROM ubuntu:trusty

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install python openssh-server && \
  sed -ri 's/#?UsePAM .*/UsePAM no/g' /etc/ssh/sshd_config && \
  echo "manual" > /etc/init/ssh.override && \
  mkdir -p /var/run/sshd
