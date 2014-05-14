FROM debian:7.4
MAINTAINER Sylvain Boily "sboily@avencall.com"

ADD http://mirror.xivo.fr/fai/xivo-migration/xivo_install_current.sh /root/xivo_install_current.sh
RUN apt-get -qq -y install wget vim net-tools rsyslog
RUN update-locale LANG=en_US.UTF-8 && . /etc/default/locale
RUN chmod +x /root/xivo_install_current.sh
RUN echo "deb http://http.debian.net/debian wheezy non-free" >> /etc/apt/sources.list
RUN apt-get update
RUN /root/xivo_install_current.sh -d

EXPOSE 443 80 5003 50051
