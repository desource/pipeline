FROM centos:7.2.1511

ADD dbus.service /etc/systemd/system/dbus.service

RUN \
  yum -y update && \
  yum -y install systemd systemd-libs dbus && \
  yum clean all && \
  systemctl mask \
    dev-hugepages.mount \
    dev-mqueue.mount \
    display-manager.service \
    graphical.target \
    sys-fs-fuse-connections.mount \
    sys-kernel-config.mount \
    sys-kernel-debug.mount \
    systemd-logind.service \
    systemd-remount-fs.service && \
  systemctl enable dbus.service

VOLUME ["/run", "/sys/fs/cgroup"]

CMD ["/usr/lib/systemd/systemd"]
