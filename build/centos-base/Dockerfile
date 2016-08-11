FROM centos:7.2.1511

ADD dbus.service /etc/systemd/system/dbus.service

RUN \
  dnf -y update && \
  dnf -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs dbus && \
  dnf clean all && \
  systemctl mask dev-mqueue.mount dev-hugepages.mount \
    systemd-remount-fs.service sys-kernel-config.mount \
    sys-kernel-debug.mount sys-fs-fuse-connections.mount \
    display-manager.service graphical.target systemd-logind.service && \
  systemctl enable dbus.service

VOLUME ["/run", "/sys/fs/cgroup"]

CMD ["/usr/lib/systemd/systemd"]
