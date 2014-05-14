FROM debian:7.4
MAINTAINER Sylvain Boily "sboily@avencall.com"

ENV DEBIAN_FRONTEND noninteractive
ADD http://mirror.xivo.fr/fai/xivo-migration/xivo_install_current.sh /root/xivo_install_current.sh
RUN echo "deb http://http.debian.net/debian wheezy non-free" >> /etc/apt/sources.list
RUN apt-get -qq update
RUN apt-get -qq -y install apt-utils locales wget vim net-tools rsyslog
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN dpkg-reconfigure locales
RUN chmod +x /root/xivo_install_current.sh
RUN /root/xivo_install_current.sh

EXPOSE 443 80 5003 50051
