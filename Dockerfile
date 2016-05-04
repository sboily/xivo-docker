# XiVO docker installation
FROM debian:jessie
MAINTAINER Sylvain Boily "sboily@proformatique.com"

# Set ENV
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV HOME /root

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
RUN locale-gen
RUN dpkg-reconfigure locales

# Install XiVO
RUN /root/xivo_install_current.sh

# Fix
RUN rm /usr/sbin/policy-rc.d
RUN touch /etc/network/interfaces

# Clean
RUN apt-get clean
RUN rm /root/xivo_install_current.sh

EXPOSE 80 443 5003 9486
CMD ["/root/xivo-service", "loop"]
