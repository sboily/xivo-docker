# XiVO docker installation
FROM debian:7.4
MAINTAINER Sylvain Boily "sboily@avencall.com"

# Set ENV
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV HOME /root

# Add necessary files
ADD http://mirror.xivo.fr/fai/xivo-migration/xivo_install_current.sh /root/xivo_install_current.sh
ADD xivo-service /root/xivo-service
ADD asterisk.sql /tmp/asterisk.sql

# Chmod
RUN chmod +x /root/xivo_install_current.sh
RUN chmod +x /root/xivo-service

# Add non-free repo
RUN echo "deb http://http.debian.net/debian wheezy non-free" >> /etc/apt/sources.list

# Update repo
RUN apt-get -qq update

# Install the needed packages
RUN apt-get -qq -y install \
    apt-utils \
    locales \
    wget \
    vim \
    net-tools \
    rsyslog \
    udev \
    iptables \
    kmod \
    ssh

# Update locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN dpkg-reconfigure locales

# Install XiVO
RUN /root/xivo_install_current.sh

# Fix
RUN rm /usr/sbin/policy-rc.d
RUN touch /etc/network/interfaces

# Set password
RUN echo "root:xivo" | chpasswd

# Clean
RUN apt-get clean
RUN rm /root/xivo_install_current.sh

EXPOSE 22 80 443 5003 50051
CMD ["/root/xivo-service", "loop"]
