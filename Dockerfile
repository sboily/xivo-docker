# XiVO docker installation
FROM debian:jessie
MAINTAINER Sylvain Boily "sboily@proformatique.com"

# Set ENV
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV HOME /root
ENV init /lib/systemd/systemd

# Add necessary files
ADD http://mirror.xivo.io/fai/xivo-migration/xivo_install_current.sh /root/xivo_install_current.sh
ADD xivo-service /root/xivo-service
ADD asterisk.sql /tmp/asterisk.sql

# Chmod
RUN chmod +x /root/xivo_install_current.sh \
    && chmod +x /root/xivo-service

# Update repo
RUN apt-get -qq update \
    && apt-get -qq -y install \
                      apt-utils \
                      locales \
                      wget \
                      vim \
                      net-tools \
                      rsyslog \
                      udev \
                      iptables \
                      kmod

# Update locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN dpkg-reconfigure locales

# Install XiVO
RUN /root/xivo_install_current.sh -d

# Fix
RUN rm /usr/sbin/policy-rc.d
RUN touch /etc/network/interfaces

# Clean
RUN apt-get clean
RUN rm /root/xivo_install_current.sh

# Fix for systemd on docker
RUN cd /lib/systemd/system/sysinit.target.wants/; ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*; \
    rm -f /lib/systemd/system/plymouth*; \
    rm -f /lib/systemd/system/systemd-update-utmp*;
RUN systemctl set-default multi-user.target

VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 80 443 5003 9486

ENTRYPOINT ["/lib/systemd/systemd"]
CMD ["/root/xivo-service", "loop"]
